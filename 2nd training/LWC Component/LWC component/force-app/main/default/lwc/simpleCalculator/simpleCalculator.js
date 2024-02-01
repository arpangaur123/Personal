import { LightningElement, track} from 'lwc';

export default class SimpleCalculator extends LightningElement {
    firstNumber;
    secondNumber;
     result;
     previousResult = false;
    @track previousResultArray = []

    numberChangeHandler(event){
        this.firstNumber=event.target.value;
    }
    numberChangeHandler1(event){
        this.secondNumber=event.target.value;
    }
    
    addHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.result =  `${firstN} + ${secondN} = ${firstN+secondN}` ;
        this.previousResultArray.push(this.result);
        
    }

    subHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.result =  `${firstN} - ${secondN} = ${firstN-secondN}` ;
        this.previousResultArray.push(this.result);
        
    }
    
    multiplyHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.result =  `${firstN} * ${secondN} = ${firstN*secondN}` ;
        this.previousResultArray.push(this.result);
        
    }
    
    DivisionHandler(){
        const firstN = parseInt(this.firstNumber);
        const secondN = parseInt(this.secondNumber);
        this.result =  `${firstN} / ${secondN} = ${firstN/secondN}` ;
        this.previousResultArray.push(this.result);
        
    }
    
    refreshHandler(){
        this.firstNumber = null;
        this.secondNumber = null;
        console.log(this.firstNumber);
        console.log(this.secondNumber);
    }

    previousResultHandler(event){
        this.previousResult = event.target.checked;
    }

}