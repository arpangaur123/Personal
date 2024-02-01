import { LightningElement, api} from 'lwc';

export default class ChildComponent extends LightningElement {
    @api itemName = "childVariable";

    @api handleChangeValue(){
     
        this.itemName = "Api Mathod";
    }
    connectedCallback(){
        //alert('hello1');
    }
}