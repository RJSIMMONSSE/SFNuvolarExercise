/**
 * custome LWC for create and display flight records.
 * 
 * @author Richard J Simmons
 * @since Date 30/03/2023.
 */
import { LightningElement, track, api } from 'lwc';
import FLIGHT_OBJECT from '@salesforce/schema/Flight__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//Fields
import NAME_FIELD from '@salesforce/schema/Flight__c.Name';
import DEPATURE_AIR_PORT_FIELD from '@salesforce/schema/Flight__c.Departure_Airport__c';
import ARRIVAL_AIR_PORT_FIELD from '@salesforce/schema/Flight__c.Arrival_Airport__c';
//Methods
import getFlightInfo from '@salesforce/apex/CreateNewFlightController.getFlightInfo';
//Custom Labels
import depature from '@salesforce/label/c.Departure';
import arrival from '@salesforce/label/c.Arrival';
import distance from '@salesforce/label/c.Distance';
import success from '@salesforce/label/c.Title_Success';
import messageSuccess from '@salesforce/label/c.Message_Success';
import error from '@salesforce/label/c.Title_Error';


export default class CreateNewFlight extends LightningElement {

    flightObject = FLIGHT_OBJECT;
    Objectfields = [NAME_FIELD, DEPATURE_AIR_PORT_FIELD, ARRIVAL_AIR_PORT_FIELD];    
    
    isNewFlight = false;  
    isFlightInfo = false; 
    departureAirportCode 
    departureAirportName;
    arrivalAirportCode
    arrivalAirportName;
    distance;
    year;

    label = {
        depature,
        arrival,
        distance
    }

    connectedCallback(){
        const d = new Date();
        this.year = d.getFullYear();        
    }

    createNewFlight(){
        this.isFlightInfo = false;
        this.isNewFlight = true;        
    }

    handleFlightCreated(event){
        const evt = new ShowToastEvent({
            title: success,
            message: messageSuccess,
            variant: 'success',
        });

        this.dispatchEvent(evt);
       
        this.isNewFlight = false;           

        getFlightInfo({recordId: event.detail.id})            
            .then((data)=>{
                this.departureAirportCode = data.Departure_Airport__r.Name;
                this.departureAirportName = data.Departure_Airport__r.Airport_Name__c;
                this.arrivalAirportCode = data.Arrival_Airport__r.Name;
                this.arrivalAirportName = data.Arrival_Airport__r.Airport_Name__c; 
                this.distance = data.Distance_KM__c; 
                
                this.isFlightInfo = true;

            }).catch((err)=>{                
                console.log('Some erro occured when retrieving data' + err);
                const evt = new ShowToastEvent({
                    title: error,
                    message: err,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
    }
}
