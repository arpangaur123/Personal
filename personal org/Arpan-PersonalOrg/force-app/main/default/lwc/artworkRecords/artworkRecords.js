import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import ArtworkRecordsAsPerPortalUser from '@salesforce/apex/ArtworkController.ArtworkRecordsAsPerPortalUser'
import searchRecords from '@salesforce/apex/ArtworkController.searchRecords'

//import searchRecords from '@salesforce/apex/ArtworkTestController.searchRecords';

const columns = [
    {
        label: 'Barcode Id', fieldName: 'Barcode_ID__c'
    },
    {
        label: 'Name', fieldName: 'nameUrl', type: 'url', typeAttributes: {
            label: { fieldName: 'Name' },
            target: '_blank'
        }
    },
    {
        label: 'Artist', fieldName: 'artistName', typeAttributes: {
            label: { fieldName: 'artApp__Artist__c' }
        }
    },
    {
        label: 'Collector', fieldName: 'collectorName', typeAttributes: {
            label: { fieldName: 'artApp__Collector__c' }
        }
    },
    { label: 'Item No', fieldName: 'Item_No__c' },
    { label: 'Artwork Dimensions', fieldName: 'Dimensions__c' },
    { label: 'Packed Dimensions', fieldName: 'Packed_Dimensions__c' },
   
]
export default class ArtworkRecords extends NavigationMixin(LightningElement) {
    @track ArtworkData = []
    @track loadMoreStatus = '';
    initialRecords;
    @track totalrecords;
    @track currentRecords = 50;
    Columns = columns;
    showMessage = false;
    rowLimit = 50;
    rowOffSet = 0;
    searchText;
    lengthh;
    loading = true;
    

    connectedCallback() {
       
      
        this.loadData();
        

    }

    loadData() {
        if (this.searchText == undefined || this.searchText == null || this.searchText == '') {
            console.log('loaddata called : ',this.searchText);
            // this.ArtworkData = [];
            return ArtworkRecordsAsPerPortalUser({ limitSize: this.rowLimit, offset: this.rowOffSet })
                .then(response => {
                    console.log('response---', response)
                    this.totalrecords = response.totalNoOfRecord;
                    let tempData = response.artRecords.map(row => {
                        return { ...row, nameUrl: `/${row.Id}`, artistName: row.artApp__Artist__r.Name, collectorName: row.artApp__Collector__r.Name };
                    })
                    tempData.forEach(currentItem => {
                        this.ArtworkData.push(currentItem);
                    });
                    console.log('ArtworkData------------', JSON.parse(JSON.stringify(this.ArtworkData)));
                    this.ArtworkData = JSON.parse(JSON.stringify(this.ArtworkData));

                    console.log('Records----', this.ArtworkData)
                    //this.ArtworkData = newDAta;  
                }).catch(error => {
                    console.log('Error: ' + JSON.stringify(error));
                });
        }
    }

    loadMoreData(event) {
        console.log('loadMoreData------------- : ');
        const { target } = event;
        console.log('target : ', target.isLoading);
        target.isLoading = true;
        if (this.totalrecords > this.rowOffSet) {
            this.rowOffSet = this.rowOffSet + this.rowLimit;
            this.loadData()
                .then(() => {
                    target.isLoading = false;
                    if (this.totalrecords > (this.currentRecords + 50)) {
                        this.currentRecords = this.currentRecords + 50
                    } else {
                        this.currentRecords = this.totalrecords;
                    }
                });

        } else {
            target.isLoading = false;
            this.loadMoreStatus = 'No more to load.'
        }

    }

    async handleSearch(event) {
        this.searchText = event.target.value;
        console.log('searchText bef : ',this.searchText);
        if (this.searchText.length > 0) {
            this.loading = false;
            let consFunction = await searchRecords({ searchKey: event.target.value, limitSize: 50 })
                .then(result => {
                  this.currentRecords = result.length;
                  this.loadMoreStatus = ''
                    console.log('result : ', result);
                    let tempRecords = JSON.parse(JSON.stringify(result));
                    tempRecords = tempRecords.map(row => {
                        // console.log('art : ',row.artApp__Artist__r.Name);
                        return { ...row, nameUrl: `/${row.Id}`, artistName: row.artApp__Artist__r.Name, collectorName: row.artApp__Collector__r.Name };
                    })
                    this.ArtworkData = tempRecords;
                })
                .catch(error => {
                    console.log('searchRecord error : ', error);
                })
        }
        else {
            console.log('searchText aft : ',this.searchText);
            this.loading = true;
            this.currentRecords = 50;
            this.ArtworkData = [];
            this.rowOffSet = 0;
            this.loadData();
            
        }

    }


    navigateToNewArtwork() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'artApp__Artwork__c',
                actionName: 'new'
            }
        });
    }

  
}