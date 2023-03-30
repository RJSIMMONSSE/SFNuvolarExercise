/**
 * Test class for the CreateNewFlightController
 * 
 * @author Richard J Simmons
 * @since Date 30/03/2023.
 */
@IsTest
public with sharing class TEST_CreateNewFlightController {

    @TestSetup
    public static void setupTestData(){
        

        List<Airport__c> airportList = new List<Airport__c>();

        //CMB
        Airport__c airport1 = new Airport__c(
            Name = 'AAA',
            Airport_Name__c = 'Test A1',
            Airport_Location__latitude__s = 7.1803574440931515,
            Airport_Location__longitude__s = 79.88425209763032
        );
        //BCN
        Airport__c airport2 = new Airport__c(
            Name = 'BBB',
            Airport_Name__c = 'Test A2',
            Airport_Location__latitude__s = 41.29761424966808,
            Airport_Location__longitude__s = 2.0833155557287997
        );

        airportList.add(airport1);
        airportList.add(airport2);
        insert airportList;
        
        Flight__c flight = new Flight__c(
            Name = 'Test A to B',
            Arrival_Airport__c = airport1.Id,
            Departure_Airport__c = airport2.Id
        );

        insert flight;
    }

    @IsTest
    static void testgetFlightInfo() {

        Flight__c flight = [SELECT Id FROM Flight__c WHERE Name = 'Test A to B'];

        Test.startTest();

        Flight__c returnFlight = CreateNewFlightController.getFlightInfo(flight.Id);

        Test.stopTest();
        //CMB to BCN
        System.assertEquals(8463, returnFlight.Distance_KM__c);
    }

    @IsTest
    static void testWhenChangeAirportRecalculate() {

        Test.startTest();

        Airport__c airport3 = new Airport__c(
            Name = 'BBB',
            Airport_Name__c = 'Test A2',
            Airport_Location__latitude__s = 59.650032492410396,
            Airport_Location__longitude__s = 17.934165453975115
        );

        insert airport3;

        Flight__c flight = [SELECT Id, Arrival_Airport__c, Distance_KM__c FROM Flight__c WHERE Name = 'Test A to B'];

        System.assertEquals(8463, flight.Distance_KM__c);

        flight.Arrival_Airport__c = airport3.Id;
        update flight;

        Flight__c updatedFlight = [SELECT Id, Distance_KM__c FROM Flight__c WHERE Name = 'Test A to B'];

        Test.stopTest();
        //CMB to BCN
        System.assertEquals(2315, updatedFlight.Distance_KM__c);
    }
}
