public with sharing class AccountProcessor {
  @future
  public static void countContacts(List<Id> accountIds) {
    // Query the number of contacts for each account
    List<Account> accountsToUpdate = new List<Account>();
    for (Id accountId : accountIds) {
      Integer contactCount = [
        SELECT COUNT()
        FROM Contact
        WHERE AccountId = :accountId
      ];
      accountsToUpdate.add(
        new Account(Id = accountId, Number_Of_Contacts__c = contactCount)
      );
    }

    // Update the accounts with the number of contacts
    if (!accountsToUpdate.isEmpty()) {
      update accountsToUpdate;
    }
  }
}
