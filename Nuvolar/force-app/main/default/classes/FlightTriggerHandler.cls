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
     * This method will retrieve the distance calculation 
     * & add it to flight record's Distance_KM__c field.
     * 
     * @param Flight__c flight - records that is triggered
     * @return Flight__c
     * @author Jason
     */
    public static Flight__c updateFlightDistance(Flight__c flight){
        
        if(flight == null) {

            return new Flight__c();
        }

        Flight__c flightToUpdate = new Flight__c(); 

        Flight_Selector flightSelector = new Flight_Selector();
        List<String> flightReturnFields = new List<String> {'Arrival_Airport__c', 
                                                            'Arrival_Airport__r.Airport_Location__c', 
                                                            'Departure_Airport__c', 
                                                            'Departure_Airport__r.Airport_Location__c'};  
        
        flightSelector.sObjectFieldStringList = flightReturnFields;

       
        flightToUpdate = flightSelector.selectById(flight.Id); 

        Location depatureLocation = flightToUpdate.Departure_Airport__r.Airport_Location__c;
        Location arrivalLocation = flightToUpdate.Arrival_Airport__r.Airport_Location__c;       

        Decimal kmValue = CalculateHelper.calculateDistance(depatureLocation.latitude,
                                                            depatureLocation.longitude, 
                                                            arrivalLocation.latitude, 
                                                            arrivalLocation.longitude) / 1000;            

        flightToUpdate.Distance_KM__c = kmValue.setScale(2).intValue();    
       
        
        return flightToUpdate;
    }
}