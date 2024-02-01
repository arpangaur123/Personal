public without sharing  class QrCodeScanOnArtWorkController {
    public artApp__Artwork__c artWrk{get; set;} 
    public List<Attachment> attList{get; set;} 
    public boolean showImg{get; set;}
    public boolean showValidQR{get; set;}
    public String errorMsg{get; set;}
    public QrCodeScanOnArtWorkController(){
        showImg=false; 
        errorMsg = 'There is no Artwork image.';
        artWrk = new artApp__Artwork__c();
        attList = new List<Attachment>();
        if(ApexPages.currentPage().getParameters().get('Id') != ''){
            string currentRecordId = ApexPages.currentPage().getParameters().get('Id');
            system.debug('currentRecordId'+currentRecordId);
            artWrk = [select id,Name,Artist_Name_Formula__c,Barcode_ID__c, Packed_Dimensions__c, Dimensions__c ,Bond_Status__c,Internal_Location__r.Name,artApp__Collector__r.Name,(select id,name,ParentId from Attachments where ParentId =: currentRecordId) from artApp__Artwork__c where id =:currentRecordId];
            system.debug(artWrk.Bond_Status__c);
            if(artWrk.Internal_Location__r.Name != Null){
            if(!(artWrk.Internal_Location__r.Name.containsIgnoreCase('release')||artWrk.Internal_Location__r.Name.containsIgnoreCase('deliver')||artWrk.Internal_Location__r.Name.containsIgnoreCase('dispose')||artWrk.Internal_Location__r.Name.containsIgnoreCase('held by')||artWrk.Internal_Location__r.Name.containsIgnoreCase('annex')||artWrk.Internal_Location__r.Name.containsIgnoreCase('pend')||artWrk.Internal_Location__r.Name.containsIgnoreCase('old')||artWrk.Internal_Location__r.Name.containsIgnoreCase('not ship')||artWrk.Internal_Location__r.Name.containsIgnoreCase('to cc')||artWrk.Internal_Location__r.Name.containsIgnoreCase('enroute'))){
                     if(artWrk.Attachments!=null && artWrk.Attachments.size()>0){
                         attList=artWrk.Attachments;
                         showImg=true; 
                     }
                 }
            else{
                showValidQR = true;
                errorMsg='The QR code is not valid anymore.';
            }
            }
            else{
                 if(artWrk.Attachments!=null && artWrk.Attachments.size()>0){
                         attList=artWrk.Attachments;
                         showImg=true; 
                     }
            }
        }
        else{
            errorMsg = 'No Record found.';
        }
    }
}