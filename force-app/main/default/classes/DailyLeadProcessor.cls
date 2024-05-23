public with sharing class DailyLeadProcessor implements Schedulable {
  public void execute(SchedulableContext sc) {
    // Query to find the first 200 leads with a blank LeadSource
    List<Lead> leadsToUpdate = [
      SELECT Id
      FROM Lead
      WHERE LeadSource = NULL
      LIMIT 200
    ];

    // Update the LeadSource to 'Dreamforce'
    for (Lead lead : leadsToUpdate) {
      lead.LeadSource = 'Dreamforce';
    }

    // Perform the update
    if (!leadsToUpdate.isEmpty()) {
      update leadsToUpdate;
    }
  }
}
