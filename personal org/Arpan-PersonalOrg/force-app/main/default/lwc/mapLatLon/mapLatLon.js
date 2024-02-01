import { LightningElement,api,wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi'

export default class MapLatLon extends LightningElement { 
    @api LatField;
    @api LonField;
    @api LocField;
    @api sObject;
    @api recordId;
    lat;
    lon;
    fields;
    address;
    error;
    markers;  
    zoomLevel = 14;

    connectedCallback(){
        this.fields = [`${this.sObject}.${this.LatField}`,`${this.sObject}.${this.LonField}`,`${this.sObject}.${this.LocField}`];
        console.log(this.fields);
        this.lat = this.LatField;
        this.lon = this.LonField;
        this.loc = this.LocField;

    }

    @wire(getRecord, { recordId: '$recordId',fields:'$fields'})
    wiredRecord({ error, data }) {
        if (data) {
            console.log(JSON.stringify(data));
            this.error = undefined;
            const property = data.fields;
            console.log(this.lat);
            console.log(property[this.lat]);
            
            this.markers = [
                {
                    location: {
                        Latitude: property[this.lat].value,
                        Longitude: property[this.lon].value
                    },
                    title: property[this.loc].value
                }
            ];
        } else if (error) {
            this.error = error;
            this.address = undefined;
            this.markers = [];
        }
    }

}