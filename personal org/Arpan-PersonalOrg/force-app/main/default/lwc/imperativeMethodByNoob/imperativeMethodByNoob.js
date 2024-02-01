import { LightningElement, track } from 'lwc';
import fetchingContactRecords from '@salesforce/apex/ContactController.fetchingContactRecords';

const columns=[
    {label:'Name', fieldName: 'Name'},
    {label:'Email', fieldName: 'Email'},
    {label:'Name', fieldName: 'Name'}
];
export default class ImperativeMethodByNoob extends LightningElement {
@track colms = columns;
@track condate = [];
@track contacts =[10];

connectedCallback(){
    fetchingContactRecords()
    .then(result=>{
        this.condate = result;
    })      
    .catch(error =>{
        console.log('error occured');
    })
}

onClickHandler(){
    console.log('contact1',this.contacts);
    fetchingContactRecords()
        .then(result=>{
            this.contacts = result;
            console.log('result',result);
            console.log('contact2',this.contacts);
        })
        .catch(error=>{
            console.log('error occured', error);
        })
}

}