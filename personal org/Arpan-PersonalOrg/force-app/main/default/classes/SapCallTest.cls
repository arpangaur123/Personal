@isTest
public class SapCallTest{
    
    
    @isTest  static void test1(){
        
        sap_api__c sap=new sap_api__c();
        sap.Name='testApi';
        sap.Client_Id__c='abcd123';
        sap.Url__c='https://abcd.com';
        sap.Cache_Control__c='no';
        sap.Client_Secret__c='testSecret';
        sap.Content_Type__c='testCont';
        sap.X_Api_Key__c='testKey123';
        insert sap; 
        
        Account ac=new Account();
        ac.Name='no idea';
        insert ac;
        
        Opportunity opp=new Opportunity();
        opp.AccountId=ac.id;
        opp.Name='new opp';
        opp.StageName='Closed Won'; 
        opp.Estimated_Volume__c=12.4;
        opp.Pack_Date_1__c=system.today()-30;
        opp.Amount=123;
        opp.CloseDate=system.today()+10;
        insert opp;
        
        artApp__Artist__c artist=new artApp__Artist__c();
        artist.Name='Akhtar';
        insert artist;
        
        
        artApp__Collector__c aCol=new artApp__Collector__c();
        aCol.Name='Sotheby\'s Hong Kong Limited';
        aCol.artApp__Email__c='sa@ifi.com';
        aCol.artApp__Phone__c='9878987865';
        aCol.artApp__Contact_Last_Name__c='sahu';
        insert aCol;
        
        Job_Reference__c job=new Job_Reference__c();
        job.Name='08/126';
        job.Client_Account__c=aCol.id;
        job.Account__c=ac.id;
        job.Opportunity__c=opp.id;
        insert job;
        
        artApp__Artwork__c art=new artApp__Artwork__c();
        art.Item_No__c='SF1234';
        art.Shared_Crate__c='S';
        art.Job_Reference__c=job.id;
        art.artApp__Collector__c=aCol.id;
        art.artApp__Artist__c=artist.Id;
        art.Name='SF123 Test';
        art.artApp__Length__c=12;
        art.artApp__Width__c=112;
        art.artApp__Height__c=122;
        art.artApp__UOM__c='M';
        art.Weight_kg__c=10;
        art.UOM_Wt__c='KG';
        art.Shared_Crate__c='S';
        insert art;
        
        PageReference pg= page.SAPcall;
        ApexPages.currentPage().getParameters().put('lid',art.id);
        
        SapclassController ctrl= new SapclassController();
        ctrl.webMethod();
        
    }
    
    
    
    @isTest 
    public static void test2(){
        
        sap_api__c sap=new sap_api__c();
        sap.Name='testApi';
        sap.Client_Id__c='abcd123';
        sap.Url__c='https://abcd.com';
        sap.Cache_Control__c='no';
        sap.Client_Secret__c='testSecret';
        sap.Content_Type__c='testCont';
        sap.X_Api_Key__c='testKey123';
        insert sap; 
        
        Account ac=new Account();
        ac.Name='no idea';
        insert ac;
        
        Opportunity opp=new Opportunity();
        opp.AccountId=ac.id;
        opp.Name='new opp';
        opp.StageName='Closed Won'; 
        opp.Estimated_Volume__c=12.4;
        opp.Pack_Date_1__c=system.today()-30;
        opp.Amount=123;
        opp.CloseDate=system.today()+10;
        insert opp;
        
        artApp__Artist__c artist=new artApp__Artist__c();
        artist.Name='Akhtar';
        insert artist;
        
        
        artApp__Collector__c aCol=new artApp__Collector__c();
        aCol.Name='Sotheby\'s Hong Kong Limited';
        aCol.artApp__Email__c='sa@ifi.com';
        aCol.artApp__Phone__c='9878987865';
        aCol.artApp__Contact_Last_Name__c='sahu';
        insert aCol;
        
        Job_Reference__c job=new Job_Reference__c();
        job.Name='08/126';
        job.Client_Account__c=aCol.id;
        job.Account__c=ac.id;
        job.Opportunity__c=opp.id;
        insert job;
        
        artApp__Artwork__c art=new artApp__Artwork__c();
        art.Item_No__c='SF1234';
        art.Job_Reference__c=job.id;
        art.artApp__Collector__c=aCol.id;
        art.artApp__Artist__c=artist.Id;
        art.Name='SF123 Test';
        art.artApp__Length__c=12;
        art.artApp__Width__c=112;
        art.artApp__Height__c=122;
        art.artApp__UOM__c='M';
        art.Weight_kg__c=10;
        art.UOM_Wt__c='KG';
        insert art;
    }
    
    @isTest 
    public static void test3(){
        
        sap_api__c sap=new sap_api__c();
        sap.Name='testApi';
        sap.Client_Id__c='abcd123';
        sap.Url__c='https://abcd.com';
        sap.Cache_Control__c='no';
        sap.Client_Secret__c='testSecret';
        sap.Content_Type__c='testCont';
        sap.X_Api_Key__c='testKey123';
        insert sap; 
        
        Account ac=new Account();
        ac.Name='no idea';
        insert ac;
        
        Opportunity opp=new Opportunity();
        opp.AccountId=ac.id;
        opp.Name='new opp';
        opp.StageName='Closed Won'; 
        opp.Estimated_Volume__c=12.4;
        opp.Pack_Date_1__c=system.today()-30;
        opp.Amount=123;
        opp.CloseDate=system.today()+10;
        insert opp;
        
        artApp__Artist__c artist=new artApp__Artist__c();
        artist.Name='Akhtar';
        insert artist;
        
        
        artApp__Collector__c aCol=new artApp__Collector__c();
        aCol.Name='Sotheby\'s Hong Kong Limited';
        aCol.artApp__Email__c='sa@ifi.com';
        aCol.artApp__Phone__c='9878987865';
        aCol.artApp__Contact_Last_Name__c='sahu';
        insert aCol;
        
        Job_Reference__c job=new Job_Reference__c();
        job.Name='08/126';
        job.Client_Account__c=aCol.id;
        job.Account__c=ac.id;
        job.Opportunity__c=opp.id;
        insert job;
        
        Location__c locObj = new  Location__c();
        locObj.Name ='RELEASE DELIV HELD OLD DISPOSED';
        insert locObj;
        
        Crate__c obj = new Crate__c();
        obj.CBarcode_ID__c='Test';
        obj.myCollector__c=aCol.id;
        obj.Location__c=locObj.id;
        obj.With_Legs__c='Yes';
        obj.IPPC_Stamp__c='Yes';
        obj.Job_Reference__c=job.id;
        insert obj;
        
        artApp__Artwork__c art=new artApp__Artwork__c();
        art.Item_No__c='SF1234';
        art.Job_Reference__c=job.id;
        art.artApp__Collector__c=aCol.id;
        art.artApp__Artist__c=artist.Id;
        art.Name='SF123 Test';
        art.artApp__Length__c=12;
        art.artApp__Width__c=112;
        art.artApp__Height__c=122;
        art.artApp__UOM__c='M';
        art.Weight_kg__c=10;
        art.UOM_Wt__c='KG';
        art.Crate__c=obj.id;
        art.Shared_Crate__c='I';
        art.Internal_Location__c=locObj.id;
        insert art;
        
        
       
    }
    
     @isTest 
    public static void test4(){
        
        sap_api__c sap=new sap_api__c();
        sap.Name='testApi';
        sap.Client_Id__c='abcd123';
        sap.Url__c='https://abcd.com';
        sap.Cache_Control__c='no';
        sap.Client_Secret__c='testSecret';
        sap.Content_Type__c='testCont';
        sap.X_Api_Key__c='testKey123';
        insert sap; 
        
        Account ac=new Account();
        ac.Name='no idea';
        insert ac;
        
        Opportunity opp=new Opportunity();
        opp.AccountId=ac.id;
        opp.Name='new opp';
        opp.StageName='Closed Won'; 
        opp.Estimated_Volume__c=12.4;
        opp.Pack_Date_1__c=system.today()-30;
        opp.Amount=123;
        opp.CloseDate=system.today()+10;
        insert opp;
        
        artApp__Artist__c artist=new artApp__Artist__c();
        artist.Name='Akhtar';
        insert artist;
        
        
        artApp__Collector__c aCol=new artApp__Collector__c();
        aCol.Name='Sotheby\'s Hong Kong Limited';
        aCol.artApp__Email__c='sa@ifi.com';
        aCol.artApp__Phone__c='9878987865';
        aCol.artApp__Contact_Last_Name__c='sahu';
        insert aCol;
        
        Job_Reference__c job=new Job_Reference__c();
        job.Name='08/126';
        job.Client_Account__c=aCol.id;
        job.Account__c=ac.id;
        job.Opportunity__c=opp.id;
        insert job;
        
        Location__c locObj = new  Location__c();
        locObj.Name ='Test';
        insert locObj;
        
        Location__c locObj1 = new  Location__c();
        locObj1.Name ='Test1';
        insert locObj1;
        
        Crate__c obj = new Crate__c();
        obj.CBarcode_ID__c='Test';
        obj.myCollector__c=aCol.id;
        obj.Location__c=locObj1.id;
        obj.With_Legs__c='Yes';
        obj.IPPC_Stamp__c='Yes';
        obj.Job_Reference__c=job.id;
        insert obj;
        
        artApp__Artwork__c art=new artApp__Artwork__c();
        art.Item_No__c='SF1234';
        art.Job_Reference__c=job.id;
        art.artApp__Collector__c=aCol.id;
        art.artApp__Artist__c=artist.Id;
        art.Name='SF123 Test';
        art.artApp__Length__c=12;
        art.artApp__Width__c=112;
        art.artApp__Height__c=122;
        art.artApp__UOM__c='M';
        art.Weight_kg__c=10;
        art.UOM_Wt__c='KG';
        art.Crate__c=obj.id;
        art.Shared_Crate__c='S';
        art.Internal_Location__c=locObj.id;
        insert art;
    }
    
    
    @isTest 
    public static void test5(){
        
        sap_api__c sap=new sap_api__c();
        sap.Name='testApi';
        sap.Client_Id__c='abcd123';
        sap.Url__c='https://abcd.com';
        sap.Cache_Control__c='no';
        sap.Client_Secret__c='testSecret';
        sap.Content_Type__c='testCont';
        sap.X_Api_Key__c='testKey123';
        insert sap; 
        
        Account ac=new Account();
        ac.Name='no idea';
        insert ac;
        
        Opportunity opp=new Opportunity();
        opp.AccountId=ac.id;
        opp.Name='new opp';
        opp.StageName='Closed Won'; 
        opp.Estimated_Volume__c=12.4;
        opp.Pack_Date_1__c=system.today()-30;
        opp.Amount=123;
        opp.CloseDate=system.today()+10;
        insert opp;
        
        artApp__Artist__c artist=new artApp__Artist__c();
        artist.Name='Akhtar';
        insert artist;
        
        
        artApp__Collector__c aCol=new artApp__Collector__c();
        aCol.Name='Sotheby\'s Hong Kong Limited';
        aCol.artApp__Email__c='sa@ifi.com';
        aCol.artApp__Phone__c='9878987865';
        aCol.artApp__Contact_Last_Name__c='sahu';
        insert aCol;
        
        Job_Reference__c job=new Job_Reference__c();
        job.Name='08/126';
        job.Client_Account__c=aCol.id;
        job.Account__c=ac.id;
        job.Opportunity__c=opp.id;
        insert job;
        
        Location__c locObj = new  Location__c();
        locObj.Name ='Test1';
        insert locObj;
        
        Location__c locObj1 = new  Location__c();
        locObj1.Name ='RELEASE';
        insert locObj1;
        
        Crate__c obj = new Crate__c();
        obj.CBarcode_ID__c='Test';
        obj.myCollector__c=aCol.id;
        obj.Location__c=locObj1.id;
        obj.With_Legs__c='Yes';
        obj.IPPC_Stamp__c='Yes';
        obj.Job_Reference__c=job.id;
        insert obj;
        
        artApp__Artwork__c art=new artApp__Artwork__c();
        art.Item_No__c='SF1234';
        art.Job_Reference__c=job.id;
        art.artApp__Collector__c=aCol.id;
        art.artApp__Artist__c=artist.Id;
        art.Name='SF123 Test';
        art.artApp__Length__c=12;
        art.artApp__Width__c=112;
        art.artApp__Height__c=122;
        art.artApp__UOM__c='M';
        art.Weight_kg__c=10;
        art.UOM_Wt__c='KG';
        art.Crate__c=obj.id;
        art.Shared_Crate__c='S';
        art.Internal_Location__c=locObj.id;
        insert art;
    }
}