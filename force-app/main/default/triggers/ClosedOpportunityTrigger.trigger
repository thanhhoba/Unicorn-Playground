trigger ClosedOpportunityTrigger on Opportunity(after insert, after update) {
  // List to store the tasks to be created
  List<Task> taskList = new List<Task>();

  // Loop through each opportunity in the trigger context
  for (Opportunity opp : Trigger.new) {
    // Check if the opportunity stage is Closed Won
    if (opp.StageName == 'Closed Won') {
      // Create a new task and associate it with the opportunity
      Task followUpTask = new Task(
        Subject = 'Follow Up Test Task',
        WhatId = opp.Id,
        Status = 'Not Started', // You can set a default status for the task
        Priority = 'Normal' // You can set a default priority for the task
      );
      taskList.add(followUpTask);
    }
  }

  // Insert all the tasks if the list is not empty
  if (!taskList.isEmpty()) {
    insert taskList;
  }
}
