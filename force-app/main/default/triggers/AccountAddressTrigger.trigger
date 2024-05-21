// trigger AccountAddressTrigger on Account(before insert, before update) {
//   for (Account acc : Trigger.new) {
//     // Check if the "Match Billing Address" field is true
//     System.debug('Match_Billing_Address__c: ' + acc.Match_Billing_Address__c);

//     if (acc.Match_Billing_Address__c) {
//       // Set the Shipping Postal Code to match the Billing Postal Code
//       System.debug('In if: ' + acc.Match_Billing_Address__c);
//       acc.BillingPostalCode = acc.ShippingPostalCode;
//     }

//     System.debug('Acct is ' + acc);
//   }

// }
trigger AccountAddressTrigger on Account(before insert, before update) {
  for (Account acc : Trigger.new) {
    if (acc.Match_Billing_Address__c) {
      acc.ShippingPostalCode = acc.BillingPostalCode;
    }
  }
}
