public with sharing class AccountUtils {
  public static List<Account> accountsByState(string stateAbbreviation) {
    List<Account> accounts = [
      SELECT Id, Name
      FROM Account
      WHERE BillingState = :stateAbbreviation
    ];

    return accounts;
  }
}
