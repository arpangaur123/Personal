import { LightningElement, track,  } from 'lwc';
//import HelloWorld from './helloWorld/helloWorld.html';

export default class practice extends LightningElement {
     @track dynamicGreeting = 'World';
    //  onchange Function
    greetingChangeHandler(event){
        this.dynamicGreeting = event.target.value; 
    }
    // looping or iteration
    @track cityName = ['jaipur', 'Bangluru', 'Mumbai'];

    // conditional rendering
    @track displayDiv=false ;
    conditionalIfElse(event){
        this.displayDiv = event.target.checked;
        //this.displayDiv=true;
    }


}