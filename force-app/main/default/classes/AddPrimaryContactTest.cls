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
public class AddPrimaryContactTest {
  @testSetup
  static void setup() {
    // Insert 50 Accounts with BillingState 'NY' and 50 Accounts with BillingState 'CA'
    List<Account> accounts = new List<Account>();
    for (Integer i = 0; i < 50; i++) {
      accounts.add(
        new Account(Name = 'Test Account NY ' + i, BillingState = 'NY')
      );
    }
    for (Integer i = 0; i < 50; i++) {
      accounts.add(
        new Account(Name = 'Test Account CA ' + i, BillingState = 'CA')
      );
    }
    insert accounts;
  }

  @isTest
  static void testAddPrimaryContact() {
    // Create a sample Contact
    Contact sampleContact = new Contact(
      FirstName = 'Primary',
      LastName = 'Contact',
      Email = 'primary.contact@example.com'
    );

    // Create an instance of AddPrimaryContact for CA
    AddPrimaryContact job = new AddPrimaryContact(sampleContact, 'CA');

    // Start the test
    Test.startTest();
    System.enqueueJob(job);
    Test.stopTest();

    // Verify that 50 Contacts were inserted for Accounts with BillingState 'CA'
    List<Contact> insertedContacts = [
      SELECT Id, AccountId
      FROM Contact
      WHERE Email = 'primary.contact@example.com'
    ];
    System.assertEquals(
      50,
      insertedContacts.size(),
      'Expected 50 Contacts to be inserted for CA Accounts'
    );
  }
}
