/**************************************************************************
 * @author Company X
 * @Description  : Trigger handel calss for the sObject Flight__c
 * ========================================================================
 * @History
 * ------------------------------------------------------------------------
 * VERSION     AUTHOR                    DATE         DETAIL
    1.0      Jason Simmons           30/03/2023   Initial implementation  
 **************************************************************************/
public with sharing class FlightTriggerHandler {
    
    
    public FlightTriggerHandler() {}

    /**
     * This method will pass the list of flight to for updateFlightDistance calculate distance.
     * 
     * @param List<Flight__c> flightList - records that is triggered
     * @author Jason
     */
    public static void afterInsertFlight(List<Flight__c> flightList){
        
        updateFlightDistance(flightList);
    }

    /**
     * This method first see if only the arrival or/and departure is changed it will continue.
     * and this method will pass the list of flight to for updateFlightDistance calculate distance.
     * 
     * @param List<Flight__c> flightList - records that is triggered
     * @return List<Flight__c>
     * @author Jason
     */
    public static void afterUpdateFlight(List<Flight__c> newFlightList, Map<Id, Flight__c> oldFlightMap){
        
        List<Flight__c> listOfFlightToUpdate = new List<Flight__c>();
        
        for (Flight__c flight:  newFlightList) {

            Flight__c flightOld = oldFlightMap.get(flight.Id);

            if( flight.Arrival_Airport__c != flightOld.Arrival_Airport__c || 
                flight.Departure_Airport__c != flightOld.Departure_Airport__c) {
                    
                    listOfFlightToUpdate.add(flight);
            }
        }  

        if(listOfFlightToUpdate.size() > 0) {
            
            updateFlightDistance(listOfFlightToUpdate);
        }        
    }
    
    /**
     * This method will retrieve the distance calculation 
     * & add it to flight record's Distance_KM__c field.
     * 
     * @param List<Flight__c> flightList - records that is triggered
     * @return List<Flight__c>
     * @author Jason
     */
    public static void updateFlightDistance(List<Flight__c> flightList){

        Set<Id> flightIds = new Set<Id>();
        List<Flight__c> flightsListToUpdate = new List<Flight__c>(); 

        for (Flight__c flight : flightList) {
                
            flightIds.add(flight.Id);
        }

        for (Flight__c flight : [SELECT Arrival_Airport__c, 
                                        Arrival_Airport__r.Airport_Location__c, 
                                        Departure_Airport__c, 
                                        Departure_Airport__r.Airport_Location__c 
                                FROM Flight__c
                                WHERE Id IN: flightIds]) {

            Location depatureLocation = flight.Departure_Airport__r.Airport_Location__c;
            Location arrivalLocation = flight.Arrival_Airport__r.Airport_Location__c;       
                                
            Decimal kmValue = CalculateHelper.calculateDistance(depatureLocation.latitude,
                                                                depatureLocation.longitude, 
                                                                arrivalLocation.latitude, 
                                                                arrivalLocation.longitude) / 1000;            
                                
            flight.Distance_KM__c = kmValue.intValue();  
            flightsListToUpdate.add(flight);                
        }

        updateFlightRecords(flightsListToUpdate);
    }


    public static void updateFlightRecords(List<Flight__c> flightsToUpdate){
        
        if(flightsToUpdate.size() > 0){
            
            try {

                update flightsToUpdate;
            } 
            catch (Exception e) {
                String errorMsg = 'Error at Line : '+ e.getLineNumber() + ' - type : ' + e.getTypeName() + ' - error : ' + e.getMessage();
                System.debug('#Erro on update: '+ errorMsg);
            }                       
        }         
    }
}
