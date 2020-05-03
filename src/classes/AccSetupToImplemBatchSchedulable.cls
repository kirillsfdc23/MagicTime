/**
 * Created by Kirill.Kravchenko on 08.04.2020.
 */

global class AccSetupToImplemBatchSchedulable implements Schedulable {
    global void execute (SchedulableContext sc) {
        OpportunityAccSetupToImplementBatch batch = new OpportunityAccSetupToImplementBatch();
        database.executeBatch(batch);
    }
}