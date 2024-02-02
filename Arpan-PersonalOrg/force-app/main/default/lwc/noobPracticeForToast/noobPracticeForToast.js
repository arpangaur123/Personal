import { LightningElement } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class Noob_Pratice extends LightningElement {
     Greeting = "World";
    
     hanhlechange(event){
        
        console.log('arpan');
        this.Greeting = event.target.value;
        console.log(this.url1);

     }
    
     handleclick(){
     //let url1 = "https://developer.salesforce.com/docs/component-library/bundle/lightning-platform-show-toast-event/documentation";
     
     this.showToast();
    }


    //ShowToast
    showToast(){
        const event = new ShowToastEvent({
            title:'Get Help',
            message:'Salesforce lightining guide',
            variant: 'Success',
        })
        this.dispatchEvent(event);
    }

    getMessage=(a,b)=>{
        console.log('Hello');
    //    alert("callMyFunction");
     return a/b;
    }

    connectedCallback(){
        //alert("callMyFunction4444333333");
       let a = this.getMessage(10,3);
       //alert("callMyFunction4444333333........."+a);
    }

    
}