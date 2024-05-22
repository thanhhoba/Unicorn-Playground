public with sharing class LeadProcessor implements Database.Batchable<sObject> {
  public Integer recordCount = 10;

  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT Id FROM Lead]);
  }

  // Execute method to update LeadSource of each Lead record to "Dreamforce"
  public void execute(Database.BatchableContext bc, List<Lead> leads) {
    for (Lead l : leads) {
      l.LeadSource = 'Dreamforce';
    }
    update leads;
    recordCount = recordCount + leads.size();
    System.debug('Record process is ' + recordCount);
  }

  // Finish method for post-processing (optional)
  public void finish(Database.BatchableContext bc) {
    System.debug('Total record process is ' + recordCount);
  }
}
