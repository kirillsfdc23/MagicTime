/**
 * Created by milena_lea on 05.04.2020.
 */

public class QueueableMethod implements Queueable{

    public void execute(QueueableContext context){
        Map<Id, Account> accs = new Map<Id, Account>( [SELECT Id,Complete_Setup__c from Account where Complete_Setup__c = false]);
        List<Opportunity> opps = [Select Id, StageName from Opportunity where AccountId in :accs.keySet() and (not StageName like '%Close%')];
        List<Contact> conts =  [select Id, Account_Submitted__c from Contact where AccountId in :accs.keySet() and Account_Submitted__c = FALSE];
        for(Account acc : accs) {
            accs.Complete_Setup__c = true;
        }
        for (Contact cn : conts) {
            conts.Account_Submitted__c = true;
        }
        for (Opportunity opp : opps){
            opps.StageName = 'Account Submitted';
        }

        if (accs.size() > 0){
            update accs.values();
        }
        if(conts.size() > 0){
            update  conts;
        }
        if(opps.size() > 0){
            update opps;
        }
    }


}