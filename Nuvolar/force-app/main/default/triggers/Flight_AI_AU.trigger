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

        List<Flight__c> flightsToUpdateList = new List<Flight__c>();
        
        if(System.Trigger.isInsert) {           
            
            for (Flight__c flight : System.Trigger.new) {
                
                if(flight.Distance_KM__c == null){

                    Flight__c flightToUpdate = FlightTriggerHandler.updateFlightDistance(flight);
                    flightsToUpdateList.add(flightToUpdate);
                }
            }          
        }

        if(System.Trigger.isUpdate){

            for (Flight__c flight:  System.Trigger.new) {

                Flight__c flightOld = Trigger.oldMap.get(flight.Id);

                if( flight.Arrival_Airport__c != flightOld.Arrival_Airport__c || 
                    flight.Departure_Airport__c != flightOld.Departure_Airport__c) {

                        Flight__c flightToUpdate = FlightTriggerHandler.updateFlightDistance(flight);
                        flightsToUpdateList.add(flightToUpdate);
                }
            }  
        }

        if(flightsToUpdateList.size() > 0){

            update flightsToUpdateList;
        }  
    }  
}