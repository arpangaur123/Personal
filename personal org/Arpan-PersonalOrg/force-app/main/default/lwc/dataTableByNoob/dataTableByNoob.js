import { LightningElement , track,wire} from 'lwc';
import fetchingContactRecords from '@salesforce/apex/ContactController.fetchingContactRecords'
const columns = [
    {label: 'Name', fieldName: 'Name'},
    {label: 'Email', fieldName: 'Email'},
    {label: 'Phone', fieldName: 'Phone'}
];

export default class DataTableByNoob extends LightningElement {
    @track colm = columns;
    @track conData = [];

    @wire(fetchingContactRecords)
    getConData({data, error}){
        if(data){
            this.conData=data;
        }
        else if(error){
            console.log('error occured', error);
        }
    }
    // @wire(fetchingContactRecords)
    // getConData({data, error}){
    //     if(data){
    //         this.conData=data;
    //     }
    //     else if(error){
    //         console.log('error occured', error);
    //     }
    // }
}