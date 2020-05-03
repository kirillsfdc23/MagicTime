/**
 * Created by Kirill.Kravchenko on 05.04.2020.
 */

trigger OpportunityNeedDiscussion on Opportunity (after update) {

    List<Id> accIds = new List<Id>();
    for (Opportunity opp : Trigger.New) {
        accIds.add(opp.AccountId);
    }

    System.debug('accIds = ' + accIds);

    List<Account> accsToBeUpdated = new List<Account>();
    for (Account acc : [
            SELECT Id, Opportunity_is_on_discussion__c
            FROM Account
            WHERE Id IN :accIds
    ]) {
        for (Opportunity oppNew : Trigger.New) {

            Opportunity oppOld = Trigger.oldMap.get(oppNew.Id);

            System.debug('oppNew = ' + oppNew);

            System.debug('oppOld = ' + oppOld);

                if (oppNew.StageName == 'Need Discussion' && !(oppOld.StageName == 'Need Discussion')) {
                    acc.Opportunity_is_on_discussion__c = oppNew.Id;
                    accsToBeUpdated.add(acc);
                }
                else if (oppOld.StageName == 'Need Discussion' && !(oppNew.StageName == 'Need Discussion')) {
                    acc.Opportunity_is_on_discussion__c = null;
                    accsToBeUpdated.add(acc);
                }

        }
    }

        System.debug('accsToBeUpdated = ' + accsToBeUpdated);

        if (accsToBeUpdated.size() > 0) {
            List<Database.SaveResult> srList = Database.update(accsToBeUpdated, false);
            for (Database.SaveResult sr : srList) {
                if (!sr.isSuccess()) {
                    System.debug('Insert error is: ' + sr.getErrors() + ' ' + sr.getId());
                }
            }
        }
    }
