public with sharing class CartonFabricationPageController {
    
    Carton_Fabrication__c ciRec;
    public Carton_Fabrication__c crateIns{get; set;}
    public list<Crafting_Details__c> craftingDetailsList {get;set;}
    public list<CrateInstructionLineItem__c> crateinstructionItemList {get;set;}
    
    public CartonFabricationPageController(ApexPages.StandardController sc)
    {
        ciRec = (Carton_Fabrication__c)sc.getRecord();
        craftingDetailsList = new list<Crafting_Details__c>();
        String idstr=string.valueof(ciRec);
        crateinstructionItemList=[select Breadth_inch__c,Carton_Lining__c,Carton_Type__c,Height_inch__c,Length_inch__c,Additional_Notes__c from CrateInstructionLineItem__c where Carton_Fabrication__c=:ciRec.id];
        crateIns = [Select Id,CreatedDate, Name, Client__c, Job_Reference__c,Job_Reference__r.Name,  Required_Date__c, CreatedById,CreatedBy.Name,CS_Contact_No__c from Carton_Fabrication__c where ID =:ciRec.id];                            
    } 
    
}