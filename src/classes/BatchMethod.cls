/**
 * Created by milena_lea on 05.04.2020.
 */

public class BatchMethod implements Database.Batchable<sObject> {
    public String query;
    public Action DMLAction;
    public String Field;
    public String Value;
    public Schema.DisplayType FieldType;
    public BatchMethod(String query, Action action, String Field, String Value, Schema.DisplayType FieldType){
        this.query = query;
        this.DMLAction = action;
        this.Field = field;
        this.Value = value;
        this.FieldType = fieldType;
    }

    public Database.QueryLocator start( Database.BatchableContext bc){
        return Database.getQueryLocator(this.query);
    }
    public void execute(Database.BatchableContext bc, List<SObject> scope){

        if (DMLAction == Action.Ins) {
            List<Database.SaveResult> sr = Database.insert(scope);
        } else if (DMLAction == Action.UPD) {
            If(!String.isBlank(field)) {
                for (SObject sobj : scope) {
                    if( FieldType.name() == 'BOOLEAN') {
                        sobj.put(field, Boolean.valueOf(value));
                    } else if( FieldType.name() == 'CURRENCY'  ){
                        sobj.put(field, Decimal.valueOf(value));
                    }

                }
            }
            List<Database.SaveResult> sr = Database.update(scope);
        } else if (DMLAction == Action.DEL) {
            List<Database.DeleteResult> sr = Database.delete(scope);
        } else if (DMLAction == Action.UPS) {
            If(!String.isBlank(field)) {
                for (SObject sobj : scope) {
                    sobj.put(field, value);
                }
            }
            List<Database.UpsertResult> sr = Database.upsert(scope);
        }



    }

    public void finish (Database.BatchableContext bc){

    }

}