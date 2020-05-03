/**
 * Created by Kirill.Kravchenko on 18.04.2020.
 */

trigger AccountTrigger on Account (after insert, after update) {
    if(Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            AccountTriggerHandler.upsertAccount(Trigger.new);
        }
    }
}