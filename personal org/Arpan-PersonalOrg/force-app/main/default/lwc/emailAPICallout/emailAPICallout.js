import { LightningElement } from 'lwc';
import PostCallout from '@salesforce/apex/MailApiCallOut.PostCallout';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class EmailAPICallout extends LightningElement {

    values = {
        emailReceiver : '',
        subject : '',
        body : ''
    }

    onChangeHadller(event){
        this.values[event.target.name] = event.target.value;
    }
    sendOnClickHandller(){
        if(this.values.emailReceiver != null){
            window.alert('Please Fill the Required Fields');
            console.log('call in')
        }
        
        PostCallout({recieverEmail : this.values.emailReceiver, subject : this.values.subject, body : this.values.body})
        .then(result=>{
            console.log('resilt',result);
            this.showToast('Success', 'Email Sent !!!' , 'success');

        }).catch(error=>{
            console.log('error',error);
            this.showToast('Error', error.body.message , 'error');
        })
        
    }

    showToast(title, message, variant){
        const event = ShowToastEvent({
            title : title,
            message : message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}