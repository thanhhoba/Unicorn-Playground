/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class DailyLeadProcessorTest {
  @isTest
  static void testDailyLeadProcessor() {
    // Insert 200 test Lead records with blank LeadSource
    List<Lead> testLeads = new List<Lead>();
    for (Integer i = 0; i < 200; i++) {
      testLeads.add(
        new Lead(LastName = 'TestLead' + i, Company = 'TestCompany' + i)
      );
    }
    insert testLeads;

    // Verify that the LeadSource is null before scheduling the job
    for (Lead lead : [SELECT LeadSource FROM Lead WHERE LeadSource = NULL]) {
      System.assertEquals(null, lead.LeadSource);
    }

    // Schedule the DailyLeadProcessor job
    String jobId = System.schedule(
      'Daily Lead Processor Job',
      '0 0 0 * * ?',
      new DailyLeadProcessor()
    );

    // Start the test, which runs the scheduled job
    Test.startTest();
    Test.stopTest();

    // Verify that the LeadSource has been updated to 'Dreamforce'
    for (Lead lead : [
      SELECT LeadSource
      FROM Lead
      WHERE LeadSource = 'Dreamforce'
    ]) {
      System.assertEquals('Dreamforce', lead.LeadSource);
    }

    // Verify that all 200 leads have been updated
    Integer count = [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce'];
    System.assertEquals(200, count);
  }
}
