/**
 * Created by Kirill.Kravchenko on 08.04.2020.
 */

global class OpportunityAccSetupToImplementBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('Test123');
        return Database.getQueryLocator(
                'SELECT Id,  StageName FROM Opportunity ' +
                'WHERE StageName = \'Account Setup\' AND ' +
                'Account.First_Transaction_Date__c = TODAY'
        );
    }

    global void execute (Database.BatchableContext BC, List<Opportunity> scope) {
        if (scope.size()>0) {
            for(Opportunity opp: scope) {
                opp.StageName = 'Implementation';
            }
            update scope;
        }

    }

    global void finish (Database.BatchableContext BC) {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        String[] toAddresses = new String[] {'kirillkravchenko23@yandex.ru'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Apex Batch Job is done');
        mail.setPlainTextBody('The batch Apex job processed ');

        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}