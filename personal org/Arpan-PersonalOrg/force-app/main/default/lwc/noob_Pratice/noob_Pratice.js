import { LightningElement } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Noob_Pratice extends LightningElement {

    handleclick(){
     //let url1 = "https://developer.salesforce.com/docs/component-library/bundle/lightning-platform-show-toast-event/documentation";
     this.showToast();
    }

    //ShowToast
    showToast(){
        const event = new ShowToastEvent({
            title:'Get Help',
            Message: 'Salesforce lightining guide',
            variant: Success
        });
        this.dispatchEvent(event);
    }

}