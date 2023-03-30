/**************************************************************************
 * @author Jason
 * @Description  : Controller for the LWC: createNewFlight                  
 * ========================================================================
 * @History
 * ------------------------------------------------------------------------
 * VERSION     AUTHOR                    DATE         DETAIL
    1.0      Jason Simmons           30/03/2023   Initial implementation  
 **************************************************************************/
public with sharing class CreateNewFlightController {
    
    public CreateNewFlightController() {}

     /**
     * This method will retrieve the flight information
     * 
     * @param Id recordId - The record id of the flight which created by the Lightning form 
     * @return Flight__c
     * @author Jason
     */
    @AuraEnabled
    public static Flight__c getFlightInfo(String recordId){
        try {
            
            Flight_Selector flightSelector = new Flight_Selector();
            List<String> flightReturnFields = new List<String> {
                                        'Arrival_Airport__c', 
                                        'Arrival_Airport__r.Name', 
                                        'Departure_Airport__r.Name',
                                        'Arrival_Airport__r.Airport_Name__c',
                                        'Departure_Airport__r.Airport_Name__c', 
                                        'Distance_KM__c'};        
            flightSelector.sObjectFieldStringList = flightReturnFields;
            
                 
            return flightSelector.selectById(recordId);
        
        } catch (Exception e) {
            
            throw new AuraHandledException(e.getMessage());
        }
    }
}
