// EmailManager.sendMail(
//   'bathanh.work@gmail.com',
//   'Trailhead Tutorial',
//   '123 body'
// );

List<Account> californiaAccounts = AccountUtils.accountsByState('CA');
for (Account acc : californiaAccounts) {
  System.debug('Account ID: ' + acc.Id + ', Account Name: ' + acc.Name);
}
