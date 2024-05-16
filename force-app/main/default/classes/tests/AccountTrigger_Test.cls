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
private class AccountTrigger_Test {
  @isTest
  static void TestCreateNewAccountInBulk() {
    // Test Setup data
    // Create 200 new Accounts
    List<Account> accts = new List<Account>();
    for (Integer i = 0; i < 200; i++) {
      Account acct = new Account(Name = 'Test Account ' + i);
      accts.add(acct);
    }
    // Perform Test
    Test.startTest();
    insert accts;
    Test.stopTest();
    // Verify that 200 new Accounts were inserted
    List<Account> verifyAccts = [SELECT Id FROM Account];
    System.assertEquals(200, verifyAccts.size());
    // Also verify that 200 new Opportunities were inserted
    List<Opportunity> verifyOpps = [SELECT Id FROM Opportunity];
    System.assertEquals(200, verifyOpps.size());
  }

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
  private class AccountTrigger_Test {
    @isTest
    static void TestCreateNewAccountInBulk() {
      // Test Setup data
      // Create 200 new Accounts
      List<Account> accts = new List<Account>();
      for (Integer i = 0; i < 200; i++) {
        Account acct = new Account(Name = 'Test Account ' + i);
        accts.add(acct);
      }
      // Perform Test
      Test.startTest();
      insert accts;
      Test.stopTest();
      // Verify that 200 new Accounts were inserted
      List<Account> verifyAccts = [SELECT Id FROM Account];
      System.assertEquals(200, verifyAccts.size());
      // Also verify that 200 new Opportunities were inserted
      List<Opportunity> verifyOpps = [SELECT Id FROM Opportunity];
      System.assertEquals(200, verifyOpps.size());
    }
  }
}
