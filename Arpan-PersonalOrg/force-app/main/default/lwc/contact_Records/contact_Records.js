import { LightningElement, track, wire } from 'lwc';
import fetchingContactRecords from '@salesforce/apex/ContactController.fetchingContactRecords'
const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Phone', fieldName: 'Phone' },

]


export default class Contact_Records extends LightningElement {
    @track contactData = []
    initialRecords;
    Columns = columns;
    showMessage = false;

    @wire(fetchingContactRecords)
    getConData({ data, error }) {
        if (data) {
            this.contactData = data;
            this.initialRecords = data;
        }
        else if (error) {
            console.log('Error', error);
        };
    }

    handleChange(event) {
        try {

            const searchKey = event.target.value.toLowerCase();
            console.log('Search String is ' + searchKey);

            if (searchKey) {

                this.contactData = this.initialRecords;
                console.log('Contact Records : ' + JSON.stringify(this.contactData));

                if (this.contactData) {

                    let records = [];

                    for (let record of this.contactData) {

                        console.log('Rec is ' + JSON.stringify(record));
                        let valuesArray = Object.values(record);
                        console.log('valuesArray is ' + JSON.stringify(valuesArray));

                        for (let val of valuesArray) {

                            console.log('val is ' + val);
                            let strVal = String(val);

                            if (strVal) {

                                if (strVal.toLowerCase().includes(searchKey)) {
                                    this.showMessage = false;
                                    records.push(record);
                                    break;

                                } else {
                                    this.showMessage = true;
                                }

                            }

                        }

                    }

                    console.log('Matched contactData are ' + JSON.stringify(records));
                    this.contactData = records;

                }

            } else {

                this.contactData = this.initialRecords;

            }

        }

        catch (error) {
            console.log('Error in searching account : ', error);
        }



    }
}