/**
 * Created by Kirill.Kravchenko on 18.04.2020.
 */

public class AccountTriggerHandler {
    public static void upsertAccount(List<Account> accList) {
        updateContactLanguages(accList);
    }

    private static void updateContactLanguages(List<Account> accList) {

        Set<Account> accountsSet = new Set<Account>([
                SELECT Id, Website
                FROM Account
                WHERE ID in: accList AND Website LIKE '%@yandex.ru']);

        Set<Id> accIds = new Set<Id>();

        for (Account acc : accountsSet) {
            accIds.add(acc.Id);
        }

        List<Contact> contactsToUpdate = new List<Contact>([
                SELECT Id, Languages__c
                FROM Contact
                WHERE AccountId in: accIds]);

        for (Contact cont: contactsToUpdate) {
            cont.Languages__c = 'Russian';
        }

        update contactsToUpdate;

    }


}
/*        Map<Id, Account> accMap = new Map<Id, Account>([
                SELECT Id, Website, (SELECT Id FROM Contacts)
                FROM Account
                WHERE Id in: accList AND Website LIKE '@yandex.ru']);
     }
*/