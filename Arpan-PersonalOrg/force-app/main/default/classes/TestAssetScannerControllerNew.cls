@isTest
public class TestAssetScannerControllerNew {
    static testMethod void testMeForBorrow(){
    	
    	Map<string, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Contact.getRecordTypeInfosByName();
    	Id conRT = rtMap.get('HT Staff - SG').getRecordTypeId(); 
    	Contact c = new contact();
	        c.RecordTypeId = conRT;
	        c.FirstName='Martin';
	        c.LastName='Lockwood';
	        c.Division__c='Singapore';
	        c.Gender_HT__c='Male';
	        c.ID_Type_HT__c='NRIC (Blue)';
	        c.ID_No_HT__c='S6860650H';
        insert c;
        
        Location__c L=new Location__c();
	        L.Name='Test Loaction';
	        L.Storage_Facility__c='Display Site';
	    insert L;  
	    
	    Asset__c A = new Asset__c();
        A.name='Test Machine';
        A.Brand__c='Tata Motors';
        A.Model__c='ABC12345';
        A.Type__c='Vehicle';
        A.Serial_No__c='000ABCF112';
        A.HT_Barcode_No__c='CR150414007';
        A.Location_User__c='HHGS';
        A.Asset_Type__c='Singapore';
        A.Location_New__c=null;
        A.Loaned_To__c = null;
        insert A;  
	    
	    PageReference editPage = Page.AssetScannerPage;
		Test.setCurrentPage(editPage);
		
		AssetScannerController ctrl = new AssetScannerController();
		List<selectOption> optionList = ctrl.getOptions();
		
		ctrl.selectedpickvalue = 'Borrow';
		ctrl.collection_string = A.HT_Barcode_No__c;
		ctrl.contactBarcode = c.ID_No_HT__c;
		ctrl.location = L.Name;
		ctrl.visibleSection = false;
		ctrl.messageFlag = false;
		ctrl.message = '';
		ctrl.message1 = '';
		ctrl.messageTitle = '';
		ctrl.messageFlagError = false;
		ctrl.messageFlagSuccess = false;
		
		ctrl.VisibleMethod();
		ctrl.updateSave();
		ctrl.Close();
    }
    
    static testMethod void testMeForReturn(){
    	
    	Map<string, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Contact.getRecordTypeInfosByName();
    	Id conRT = rtMap.get('HT Staff - SG').getRecordTypeId(); 
    	Contact c = new contact();
	        c.RecordTypeId = conRT;
	        c.FirstName='Martin';
	        c.LastName='Lockwood';
	        c.Division__c='Singapore';
	        c.Gender_HT__c='Male';
	        c.ID_Type_HT__c='NRIC (Blue)';
	        c.ID_No_HT__c='S6860650H';
        insert c;
        
        Location__c L=new Location__c();
	        L.Name='Test Loaction';
	        L.Storage_Facility__c='Display Site';
	    insert L;  
	    
	    Asset__c A = new Asset__c();
        A.name='Test Machine';
        A.Brand__c='Tata Motors';
        A.Model__c='ABC12345';
        A.Type__c='Vehicle';
        A.Serial_No__c='000ABCF112';
        A.HT_Barcode_No__c='CR150414007';
        A.Location_User__c='HHGS';
        A.Asset_Type__c='Singapore';
        A.Location_New__c=null;
        A.Loaned_To__c = null;
        insert A;  
	    
	    PageReference editPage = Page.AssetScannerPage;
		Test.setCurrentPage(editPage);
		
		AssetScannerController ctrl = new AssetScannerController();
		List<selectOption> optionList = ctrl.getOptions();
		
		ctrl.selectedpickvalue = 'Return';
		ctrl.collection_string = A.HT_Barcode_No__c;
		ctrl.contactBarcode = c.ID_No_HT__c;
		ctrl.location = L.Name;
		ctrl.visibleSection = false;
		ctrl.messageFlag = false;
		ctrl.message = '';
		ctrl.message1 = '';
		ctrl.messageTitle = '';
		ctrl.messageFlagError = false;
		ctrl.messageFlagSuccess = false;
		
		ctrl.VisibleMethod();
		ctrl.updateSave();
    }
    static testMethod void testMeErrorsForBorrow(){
    	
    	Map<string, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Contact.getRecordTypeInfosByName();
    	Id conRT = rtMap.get('HT Staff - SG').getRecordTypeId(); 
    	Contact c = new contact();
	        c.RecordTypeId = conRT;
	        c.FirstName='Martin';
	        c.LastName='Lockwood';
	        c.Division__c='Singapore';
	        c.Gender_HT__c='Male';
	        c.ID_Type_HT__c='NRIC (Blue)';
	        c.ID_No_HT__c='S6860650H';
        insert c;
        
        Location__c L=new Location__c();
	        L.Name='Test Loaction';
	        L.Storage_Facility__c='Display Site';
	    insert L;  
	    
	    Asset__c A = new Asset__c();
        A.name='Test Machine';
        A.Brand__c='Tata Motors';
        A.Model__c='ABC12345';
        A.Type__c='Vehicle';
        A.Serial_No__c='000ABCF112';
        A.HT_Barcode_No__c='CR150414007';
        A.Location_User__c='HHGS';
        A.Asset_Type__c='Singapore';
        A.Location_New__c=null;
        A.Loaned_To__c = null;
        insert A;  
	    
	    PageReference editPage = Page.AssetScannerPage;
		Test.setCurrentPage(editPage);
		
		AssetScannerController ctrl = new AssetScannerController();
		List<selectOption> optionList = ctrl.getOptions();
		
		ctrl.selectedpickvalue = 'Borrow';
		ctrl.collection_string = 'eknknk5,knknd4';
		ctrl.contactBarcode = 'Cknkne3';
		ctrl.location = L.Name;
		ctrl.visibleSection = false;
		ctrl.messageFlag = false;
		ctrl.message = '';
		ctrl.message1 = '';
		ctrl.messageTitle = '';
		ctrl.messageFlagError = false;
		ctrl.messageFlagSuccess = false;
		
		ctrl.VisibleMethod();
		ctrl.updateSave();
		ctrl.Close();
		
		ctrl.selectedpickvalue = 'Borrow';
		ctrl.collection_string = '';
		ctrl.contactBarcode = '';
		
		ctrl.updateSave();
				
    }
    static testMethod void testMeErrorsForReturn(){
    	
    	Map<string, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Contact.getRecordTypeInfosByName();
    	Id conRT = rtMap.get('HT Staff - SG').getRecordTypeId(); 
    	Contact c = new contact();
	        c.RecordTypeId = conRT;
	        c.FirstName='Martin';
	        c.LastName='Lockwood';
	        c.Division__c='Singapore';
	        c.Gender_HT__c='Male';
	        c.ID_Type_HT__c='NRIC (Blue)';
	        c.ID_No_HT__c='S6860650H';
        insert c;
        
        Location__c L=new Location__c();
	        L.Name='Test Loaction';
	        L.Storage_Facility__c='Display Site';
	    insert L;  
	    
	    Asset__c A = new Asset__c();
        A.name='Test Machine';
        A.Brand__c='Tata Motors';
        A.Model__c='ABC12345';
        A.Type__c='Vehicle';
        A.Serial_No__c='000ABCF112';
        A.HT_Barcode_No__c='CR150414007';
        A.Location_User__c='HHGS';
        A.Asset_Type__c='Singapore';
        A.Location_New__c=null;
        A.Loaned_To__c = c.Id;
        insert A;  
	    
	    PageReference editPage = Page.AssetScannerPage;
		Test.setCurrentPage(editPage);
		
		AssetScannerController ctrl = new AssetScannerController();
		List<selectOption> optionList = ctrl.getOptions();
		
		ctrl.selectedpickvalue = 'Return';
		ctrl.collection_string = 'eknknk5,knknd4';
		
		ctrl.location = L.Name;
		ctrl.visibleSection = false;
		ctrl.messageFlag = false;
		ctrl.message = '';
		ctrl.message1 = '';
		ctrl.messageTitle = '';
		ctrl.messageFlagError = false;
		ctrl.messageFlagSuccess = false;
		
		ctrl.VisibleMethod();
		ctrl.updateSave();
		ctrl.Close();
		
		ctrl.selectedpickvalue = 'Return';
		ctrl.collection_string = '';		
		
		ctrl.updateSave();
		
		ctrl.selectedpickvalue = 'Return';
		ctrl.collection_string = A.HT_Barcode_No__c+'knknds';
		
		ctrl.updateSave();
		
		ctrl.selectedpickvalue = 'Return';
		ctrl.collection_string = 'CR150414007';
		
		ctrl.updateSave();		
    }
}