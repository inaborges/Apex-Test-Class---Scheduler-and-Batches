// Scheduler
global class OpportunityScheduler implements Schedulable{
	global void execute(SchedulableContext sc){
		OpportunityBatch batch = new OpportunityBatch();
		if(!Test.isRunningTest()){
			database.executebatch(batch);
		}
	}
}

// Scheduler test method
@istest
class OpportunitySchedulerTest{
	public static testMethod void testschedule() {
		Test.StartTest();
		OpportunityScheduler testsche = new OpportunityScheduler();
		String sch = '0 0 23 * * ?';
		system.schedule('Test status Check', sch, testsche );
		Test.stopTest();
	}
}

// Batch
global class OpportunityBatch implements database.batchable<sObject>{

	global String opptyList;
	global Database.QueryLocator start(Database.BatchableContext info){
		String status = ‘Submitted’;
		opptyList = 'select name,AccountName__c from Opportunity where
		status__c =\''+ status +'\'' ;
		return Database.getQueryLocator(claimList);
	}
	
	global void execute(Database.batchableContext info,List<Opportunity> opptyList){
		List<Opportunity> opportunitiesList = new List< Opportunity >();
		for(Opportunity oppty: opptyList){
		oppty.status__c = ‘Approved’;
		opportunitiesList.add(oppty);
		}
		Insert opportunitiesList;
	}
	global void finish(Database.batchableContext info){

	}
}

// Batch test method
@istest
public class OpportunityBatchtest{
	//query the activities to process
	static testmethod void OpportunityTestMethod(){
		Opportunity oppty = new Opportunity ();
		oppty.name = ‘test Oppty’;
		oppty.status__c = ‘submitted’;
		insert oppty;
		OpportunityBatch opptybatch = new OpportunityBatch ();
		Status = ‘Submitted’;
		opptybatch.opptyList = 'SELECT name,AccountName__c FROM Opportunity WHERE status__c =\''+ status +'\’ AND id=\' AND Id=\''+claim.id+'\'';
		Database.executebatch(opptybatch);
	}
}
