import { LightningElement, wire, track } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import ArtworkRecordsAsPerPortalUser from '@salesforce/apex/ArtworkTestController.ArtworkRecordsAsPerPortalUser'
import searchRecords from '@salesforce/apex/ArtworkTestController.searchRecords';

const columns = [
    {
        label: 'Name', fieldName: 'Name', type: 'url', typeAttributes: {
            label: { fieldName: 'Name' },
            target: '_blank'
        }
    },
    {
        label: 'Artist', fieldName: 'artistName', typeAttributes: {
            label: { fieldName: 'artApp__Artist__r' }
        }
    },
    {
        label: 'Collector', fieldName: 'collectorName'
    },
    { label: 'Location', fieldName: 'Location_Status__c' },
    { label: 'Item No', fieldName: 'Item_No__c' },
    { label: 'Artwork Dimensions', fieldName: 'Dimensions__c' },
    { label: 'Packed Dimensions', fieldName: 'Packed_Dimensions__c' },
    { label: 'CreatedById', fieldName: 'CreatedById' },
]

export default class ArtworkTest extends LightningElement {
    @track ArtworkData = []
    @track loadMoreStatus = '';
    initialRecords;
    Columns = columns;
    showMessage = false;
    rowLimit = 50;
    rowOffSet = 0;
    searchText = false;
    lengthh;


    @wire(ArtworkRecordsAsPerPortalUser, { limitSize: '$rowLimit', offset: '$rowOffSet' })
    wiredData({ data, error }) {
        if (data) {
            console.log('OUTPUT : ', data);

            let tempRecords = JSON.parse(JSON.stringify(data));
            tempRecords = tempRecords.map(row => {
                // console.log('art : ',row.artApp__Artist__r.Name);
                return { ...row, artistName: row.artApp__Artist__r.Name, collectorName: row.artApp__Collector__r.Name };
            })
            this.ArtworkData = tempRecords;

        }
        else if (error) {
            console.log('error : ', error);
        }
    }

    // loadData(){
    //     return  getAccounts({ limitSize: this.rowLimit , offset : this.rowOffSet })
    //     .then(result => {
    //         let updatedRecords = [...this.accounts, ...result];
    //         this.accounts = updatedRecords;
    //         this.error = undefined;
    //     })
    //     .catch(error => {
    //         this.error = error;
    //         this.accounts = undefined;
    //     });
    // }

    loadMoreData(event) {
        // const currentRecord = this.accounts;
        // const { target } = event;
        // target.isLoading = true;

        // this.rowOffSet = this.rowOffSet + this.rowLimit;
        // this.loadData()
        //     .then(()=> {
        //         target.isLoading = false;
        //     });   
    }



    async handleSearch(event) {
        const srchResult = await searchRecords({ searchKey: event.target.value, limitSize: 50 })
            .then(result => {
                console.log('result : ', result);
                let tempRecords = JSON.parse(JSON.stringify(result));
                tempRecords = tempRecords.map(row => {
                    // console.log('art : ',row.artApp__Artist__r.Name);
                    return { ...row, artistName: row.artApp__Artist__r.Name, collectorName: row.artApp__Collector__r.Name };
                })
                this.ArtworkData = tempRecords;
            })
            .catch(error => {
                console.log('searchRecord error : ', error);
            })

    }
}