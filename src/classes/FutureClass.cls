/**
 * Created by milena_lea on 05.04.2020.
 */

global class FutureMethod {

    @Future
    public static void updatAccRelObj(Set<Id> AccountIds){
        Opportunity[] opps = [Select Id, StageName from Opportunity where AccountId in :AccountIds and (not StageName like '%Close%')];
        for (Opportunity opp : opps){
            opp.StageName = 'Account Submitted';
        }

        Contact[] conts = [select Id, Account_Submitted__c from Contact where AccountId in :AccountIds and Account_Submitted__c = FALSE];
        for(Contact cnt : conts){
            cnt.Account_Submitted__c = true;
        }

        Database.SaveResult[] updRes = Database.update(opps, false);
        updRes.addAll(Database.update(conts, false));

        List<Error_Loging__c> errs = new List<Error_Loging__c>();
        for (Database.SaveResult sr : updRes){
            if (!sr.isSuccess()) {
                for (Database.Error err : sr.getErrors()) {
                    errs.add(new Error_Loging__c(Message__c = (String)('Status Code: ' + err.statusCode + ' Fields: '
                            + String.join(err.fields, ', ')
                            + ' Error Message: ' +  err.message),
                            RecordId__c = sr.getId()));
                }
            }
        }
        Database.SaveResult[] errRes = Database.insert(errs, false);
        for (Database.SaveResult sr : errRes) {
            System.debug(sr.getErrors());
        }
    }

    public Database.SaveResult[] updateAccount(Account[] accounts) {
        for (Account acc : accounts){
            acc.Complete_Setup__c = true;
        }

        Set<Id> accIds = new Set<ID>();
        Database.SaveResult[] saveRes = Database.update(accounts,false);
        for(Database.SaveResult sr : saveRes){
            if(sr.success){
                accIds.add(sr.id);
            }
        }
        updatAccRelObj(accIds);
        return saveRes;
    }

}