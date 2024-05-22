public with sharing class AddPrimaryContact implements Queueable {
  private Contact contact;
  private String stateAbbreviation;

  // Constructor
  public AddPrimaryContact(Contact contact, String stateAbbreviation) {
    this.contact = contact;
    this.stateAbbreviation = stateAbbreviation;
  }

  // Execute method
  public void execute(QueueableContext context) {
    // Query Accounts with the specified BillingState
    List<Account> accounts = [
      SELECT Id
      FROM Account
      WHERE BillingState = :stateAbbreviation
      LIMIT 200
    ];

    // List to hold Contacts to be inserted
    List<Contact> contactsToInsert = new List<Contact>();

    // Create a Contact for each Account
    for (Account acc : accounts) {
      Contact clonedContact = contact.clone(false, false, false, false);
      clonedContact.AccountId = acc.Id;
      contactsToInsert.add(clonedContact);
    }

    // Insert Contacts
    if (!contactsToInsert.isEmpty()) {
      insert contactsToInsert;
    }
  }
}
