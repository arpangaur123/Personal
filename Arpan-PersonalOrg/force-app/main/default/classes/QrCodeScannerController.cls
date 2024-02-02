public without sharing class QrCodeScannerController{
    public Crate__c crate{get; set;} 
    public list<artApp__Artwork__c> artWorkList{get; set;}
    public boolean showArtList{get; set;}
    public boolean showValidQR{get; set;}
    public String errorMsg{get; set;}
    public QrCodeScannerController(){
        showArtList=false;
        errorMsg='There is no record for Artwork under the crate.';
        artWorkList = new list<artApp__Artwork__c>();
        crate = new Crate__c();
        Set<String> mySet = new Set<String>{'%release%','%deliver%','%dispose%','%held by%','%annex%','%pend%','%old%','%not ship%','%to cc%','%enroute%'};
            if(ApexPages.currentPage().getParameters().get('Id') != ''){
                string currentRecordId = ApexPages.currentPage().getParameters().get('Id');
                system.debug('currentRecordId'+currentRecordId);
                crate = [select id,Name,Dimensions__c,Location__r.Name,myCollector__r.Name,myCollector__c,(select id,Artist_Name_Formula__c,Name,Barcode_ID__c,artApp__Primary_Image__c,artApp__Primary_Image_Id__c,QR_Code__c from Artwork__r where NOT(Internal_Location__r.Name Like: mySet)) from Crate__c where id =: currentRecordId];
                if(crate.Location__r.Name != Null){
                    if(!(crate.Location__r.Name.containsIgnoreCase('release')||crate.Location__r.Name.containsIgnoreCase('deliver')||crate.Location__r.Name.containsIgnoreCase('dispose')||
                         crate.Location__r.Name.containsIgnoreCase('held by')||crate.Location__r.Name.containsIgnoreCase('annex')||crate.Location__r.Name.containsIgnoreCase('pend')||
                         crate.Location__r.Name.containsIgnoreCase('old')||crate.Location__r.Name.containsIgnoreCase('not ship')||crate.Location__r.Name.containsIgnoreCase('to cc')||
                         crate.Location__r.Name.containsIgnoreCase('enroute'))){
                             if(crate.Artwork__r!=null && crate.Artwork__r.size() >0){
                                 system.debug('crate'+crate.Artwork__r);
                                 showArtList=true;
                                 for(artApp__Artwork__c art : crate.Artwork__r){
                                     artWorkList.add(art);
                                 }
                             }
                         }
                    else{
                        showValidQR = true;
                        errorMsg='The QR code is not valid anymore.';
                    }
                }
                else{
                    if(crate.Artwork__r!=null && crate.Artwork__r.size() >0){
                        system.debug('crate'+crate.Artwork__r);
                        showArtList=true;
                        for(artApp__Artwork__c art : crate.Artwork__r){
                            artWorkList.add(art);
                        }
                    }
                    
                }
            }
        else{
            errorMsg='No Record found.';
        }
    }
}