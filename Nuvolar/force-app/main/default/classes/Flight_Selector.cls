/**
 * Selector class for the SObject Flight__c
 * 
 * @author Richard J Simmons
 * @since Date 30/03/2023.
 */
public inherited sharing class Flight_Selector extends SObjects_Selector{
    
    //Implementation of the abstract method to define the object to query on
    private Schema.SObjectType getSObjectType()
    {
        return Flight__c.SObjectType;
    }

    public Flight_Selector() {}

    //SELECTORS

    /**
     * Select an Flight__c records with Flight__c Id
     * 
     * @param String fId : flight record id
     * @return Flight__c
     * @author Jason
     */
    public Flight__c selectById(Id fId)
    {
        soqlQuery = String.format(
                'SELECT {0} ' +
                'FROM {1} ' +
                'WHERE {2} ',

                new List<String> {
                        getSelectString(),
                        getSObjectName(),
                        'Id =: fId'
        });

        try{
            
            return Database.query(soqlQuery); 
        }
        catch(Exception e){
            
            System.debug('An error occure during the Query request ' + e.getMessage() + ' @ line: '+ e.getLineNumber());
            return new Flight__c();
        }       
    }
}
