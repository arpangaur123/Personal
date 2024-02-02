public with sharing class PrintCratingInstructionController {

    Crating_Instruction__c ciRec;
    public Crating_Instruction__c crateIns{get; set;}
    public list<Crafting_Details__c> craftingDetailsList {get;set;}

    public PrintCratingInstructionController(ApexPages.StandardController sc)
    {
        ciRec = (Crating_Instruction__c)sc.getRecord();
        craftingDetailsList = new list<Crafting_Details__c>();
        
        craftingDetailsList = [select CreatedDate, Triangle_Base_Width_cm__c,Triangle_Supports__c,Base_Plate_Width_cm__c,Base_Support__c,Crating_Notes__c,Base_Plate_Length_cm__c,Crate_No__c,Artwork_Details__c,Foam__c,Crate_Type__c, Artwork_Type__c, Opening_Side__c, Notes__c, Length__c, Breadth__c, 
                                    Height__c,Height_in__c,Length_in__c,Breadth_in__c,Triangle_Base_Width_in__c from Crafting_Details__c where Crating_Instruction__c =: ciRec.Id];
        
        crateIns = [Select Id,CreatedDate, Name, Client__c, Job_Reference__c,Job_Reference__r.Name, Date_of_Order__c, Required_Date__c, CreatedById,CreatedBy.Name,CS_Contact_No_New__c from Crating_Instruction__c where ID =:ciRec.Id];                            
    } 

}