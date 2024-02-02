import { track } from "lwc";
import { LightningElement, } from 'lwc';

export default class ParentComponent extends LightningElement {
     @track itemname2 = '.....';

     
    handleClick(){
        //itemname2 = this.template.querySelector('c-child-component').itemName;
        console.log(this.template.querySelector('c-child-component').itemName);
        // itemname2 = this.template.querySelector("c-child-component").itemName;
        this.template.querySelector("c-child-component").handleChangeValue();
    }
   
    handlechange(event){
        this.itemname2 = event.target.value;
    }
}