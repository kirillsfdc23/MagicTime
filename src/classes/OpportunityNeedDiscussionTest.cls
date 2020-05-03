/**
 * Created by Kirill.Kravchenko on 05.04.2020.
 */

@IsTest
private class OpportunityNeedDiscussionTest {
    @IsTest
    static void testBehavior() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        insert acc;

        System.debug(acc);

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opp';
        opp.AccountId = acc.Id;
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today();

        insert opp;

        System.debug(opp);

        opp.StageName = 'Need Discussion';

        update opp;

        acc = [SELECT Id, Opportunity_is_on_discussion__c FROM Account WHERE Id =:acc.Id];

        System.assertEquals(acc.Opportunity_is_on_discussion__c, opp.Id);
    }
}