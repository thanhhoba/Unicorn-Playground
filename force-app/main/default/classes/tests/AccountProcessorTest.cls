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
private class AccountProcessorTest {
  @isTest
  private static void testCountContacts() {
    // Create test accounts
    Account testAccount1 = new Account(Name = 'Test Account 1');
    Account testAccount2 = new Account(Name = 'Test Account 2');
    insert new List<Account>{ testAccount1, testAccount2 };

    // Create test contacts
    Contact testContact1 = new Contact(
      LastName = 'Contact 1',
      AccountId = testAccount1.Id
    );
    Contact testContact2 = new Contact(
      LastName = 'Contact 2',
      AccountId = testAccount1.Id
    );
    Contact testContact3 = new Contact(
      LastName = 'Contact 3',
      AccountId = testAccount2.Id
    );
    insert new List<Contact>{ testContact1, testContact2, testContact3 };

    // Call the future method
    Test.startTest();
    AccountProcessor.countContacts(
      new List<Id>{ testAccount1.Id, testAccount2.Id }
    );
    Test.stopTest();

    // Retrieve the accounts and assert the number of contacts
    Account updatedAccount1 = [
      SELECT Number_Of_Contacts__c
      FROM Account
      WHERE Id = :testAccount1.Id
    ];
    Account updatedAccount2 = [
      SELECT Number_Of_Contacts__c
      FROM Account
      WHERE Id = :testAccount2.Id
    ];

    System.assertEquals(
      2,
      updatedAccount1.Number_Of_Contacts__c,
      'Test Account 1 should have 2 contacts'
    );
    System.assertEquals(
      1,
      updatedAccount2.Number_Of_Contacts__c,
      'Test Account 2 should have 1 contact'
    );
  }
}
