public class SapclassController {

    public string ld{get;set;}   
    
    public SapclassController (){
        
    }
    
    public void webMethod(){
        ld = ApexPages.currentPage().getParameters().get('lid');
         List<artApp__Artwork__c> artLst = [select Item_No__c ,  artApp__Collector__c, artApp__Length__c,artApp__Width__c, Packed_Width__c,artApp__Height__c,artApp__UOM__c,Weight_kg__c,UOM_Wt__c from artApp__Artwork__c where id =:ld];
         if(artLst.size()>0){
          if(String.isBlank(artLst[0].artApp__Collector__c) || artLst[0].artApp__Length__c==null || artLst[0].artApp__Width__c==null || artLst[0].artApp__Height__c==null ||String.isBlank(artLst[0].artApp__UOM__c) || artLst[0].Weight_kg__c==null || String.isBlank(artLst[0].UOM_Wt__c))   
             ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO,'Please fill all 6 values.'));
          else{
              list<string> lid=new list<string>();
              lid.add(ld);
        
              //Web service method
              string s = SapCallHelper.DoCallout(lid , 'From Button');
              if(s=='success')
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.INFO,'Sap api called Successfully.'));
              if(s=='diff')
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Collector Name must be Sotheby\'s Hong Kong Limited'));
              }
         }
         //public boolean chk {get; set;}
    }
   
}