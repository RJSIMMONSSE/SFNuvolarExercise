/**************************************************************************
 * @author Jason
 * @Description  : Trigger for the Flight__c Object              
 * ========================================================================
 * @History
 * ------------------------------------------------------------------------
 * VERSION     AUTHOR                    DATE         DETAIL
    1.0      Jason Simmons           30/03/2023   Initial implementation  
 **************************************************************************/
trigger Flight_AI_AU on Flight__c (after insert, after update) {

    if(System.Trigger.IsAfter){
        
        if(System.Trigger.isInsert) {           
            
            FlightTriggerHandler.afterInsertFlight(Trigger.new);
        }

        if(System.Trigger.isUpdate){

            FlightTriggerHandler.afterUpdateFlight(Trigger.new,  Trigger.oldMap);           
        }
    }  
}
