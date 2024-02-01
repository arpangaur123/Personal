import { LightningElement, wire, track } from 'lwc';
import feachOpportunity from '@salesforce/apex/SearchableComboBoxController.feachOpportunity';

export default class SearchableComboBox extends LightningElement {
    @track searchResults;
    @track showSearchResultOptions = false;
    picklistOrdered = [];
    selectedSearchResult;
    get selectedValue() {
        
        return this.selectedSearchResult ? this.selectedSearchResult.Name : null;
    }

    connectedCallback() {
        this.fetchDefaultRecord();
    }
    fetchDefaultRecord() {
        feachOpportunity({ searchKey: null })
            .then(result => {
                result.forEach(element => {
                    this.picklistOrdered.push({ 'Id': element.Id, 'Name': element.Name });
                    console.log('element.Account : ', element.Name);
                })
            })
            .catch(error => {
                console.error('Error retrieving opportunities:', error);
            })
    }

    focusHandler() {
        console.log('focus : ');
        if (this.picklistOrdered != null) {
            this.searchResults = this.picklistOrdered;
            this.showSearchResultOptions = true
        }
    }
    search(event) {
        console.log('handel search ');
        const input = event.detail.value.toLowerCase();
        this.searchResults = [];
        this.picklistOrdered = [];
        if (input != '') {
            
            feachOpportunity({ searchKey: input })
                .then(result => {
                    console.log('result---- : ', result);
                    result.forEach(element => {
                        this.picklistOrdered.push({ 'Id': element.Id, 'Name': element.Name });
                        console.log('element.Account : ', element.Name);
                    })
                    this.searchResults = this.picklistOrdered;
                    
                })
                .catch(error => {
                    console.log('can not search--', error);
                })
                this.showSearchResultOptions = true;
        }
        if (input == '') {
            this.searchResults = [];
            this.showSearchResultOptions = false;
        }
    }
    selectSearchResult(event) {
        console.log('selectSearchResult : ');
        console.log('targetvalue',event.currentTarget.dataset.value);
        const selectedValue = event.currentTarget.dataset.value;
        this.selectedSearchResult = this.picklistOrdered.find(
            (picklistOption) => picklistOption.Name === selectedValue
        );
        console.log('selectedSearchResult',this.selectedSearchResult);
        this.clearSearchResults();
    }

    clearSearchResults() {
        this.searchResults = null;
         this.showSearchResultOptions = false;
    }
}