// Account acct = new Account(
//   Name = 'Test Account 4',
//   Phone = '(415)555-8989',
//   AccountNumber = '12132141',
//   NumberOfEmployees = 50,
//   BillingPostalCode = '12345',
//   ShippingPostalCode = '54321'
// );
// insert acct;

Account acc = [
  SELECT Id, Match_Billing_Address__c, BillingPostalCode, ShippingPostalCode
  FROM Account
  WHERE Name = 'Test Account 4'
  LIMIT 1
];
acc.BillingPostalCode = '678904';
acc.Match_Billing_Address__c = true;
update acc;

// Verify that ShippingPostalCode is updated to '67890'

