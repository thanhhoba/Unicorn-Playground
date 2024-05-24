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
private class TestAccountDeletion {
  @isTest
  static void testDeleteAccountWithOneOpportunity() {
    // Test data setup
    // Create one account with one opportunity by calling a utility method
    Account[] accts = TestDataFactory.createAccountsWithOpps(1, 1);
    // Perform test
    Test.startTest();
    Database.DeleteResult result = Database.delete(accts[0], false);
    Test.stopTest();
    // Verify that the deletion should have been stopped by the trigger,
    // so check that we got back an error.
    System.assert(!result.isSuccess());
    System.assert(result.getErrors().size() > 0);
    System.assertEquals(
      'Cannot delete account with related opportunities.',
      result.getErrors()[0].getMessage()
    );
  }
  @isTest
  static void testDeleteAccountWithNoOpportunities() {
    // Test data setup
    // Create one account with no opportunities by calling a utility method
    Account[] accts = TestDataFactory.createAccountsWithOpps(1, 0);
    // Perform test
    Test.startTest();
    Database.DeleteResult result = Database.delete(accts[0], false);
    Test.stopTest();
    // Verify that the deletion was successful
    System.assert(result.isSuccess());
  }
  @isTest
  static void testDeleteBulkAccountsWithOneOpportunity() {
    // Test data setup
    // Create accounts with one opportunity each by calling a utility method
    Account[] accts = TestDataFactory.createAccountsWithOpps(200, 1);
    // Perform test
    Test.startTest();
    Database.DeleteResult[] results = Database.delete(accts, false);
    Test.stopTest();
    // Verify for each record.
    // In this case the deletion should have been stopped by the trigger,
    // so check that we got back an error.
    for (Database.DeleteResult dr : results) {
      System.assert(!dr.isSuccess());
      System.assert(dr.getErrors().size() > 0);
      System.assertEquals(
        'Cannot delete account with related opportunities.',
        dr.getErrors()[0].getMessage()
      );
    }
  }
  @isTest
  static void testDeleteBulkAccountsWithNoOpportunities() {
    // Test data setup
    // Create accounts with no opportunities by calling a utility method
    Account[] accts = TestDataFactory.createAccountsWithOpps(200, 0);
    // Perform test
    Test.startTest();
    Database.DeleteResult[] results = Database.delete(accts, false);
    Test.stopTest();
    // For each record, verify that the deletion was successful
    for (Database.DeleteResult dr : results) {
      System.assert(dr.isSuccess());
    }
  }
}
