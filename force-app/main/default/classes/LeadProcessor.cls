public with sharing class LeadProcessor implements Database.Batchable<sObject> {
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT Id FROM Lead]);
  }

  // Execute method to update LeadSource of each Lead record to "Dreamforce"
  public void execute(Database.BatchableContext bc, List<Lead> scope) {
    for (Lead l : scope) {
      l.LeadSource = 'Dreamforce';
    }
    update scope;
  }

  // Finish method for post-processing (optional)
  public void finish(Database.BatchableContext bc) {
    // You can add post-processing logic here if needed
  }
}
