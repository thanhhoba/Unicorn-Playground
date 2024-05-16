public with sharing class AccountTriggerHandler {
  public static void CreateAccounts(List<Account> accts) {
    for (Account acc : accts) {
      acc.ShippingState = acc.BillingState;
    }
  }
}
