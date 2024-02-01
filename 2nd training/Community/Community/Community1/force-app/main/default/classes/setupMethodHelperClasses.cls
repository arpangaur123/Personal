@isTest
public class setupMethodHelperClasses{
    
    
    public static artApp__Artist__c  getArtist(){
        artApp__Artist__c   ar = new artApp__Artist__c();
        ar.name ='Test';
        insert ar;
        return ar;
    }
    
    public static artApp__Artwork__c getArtWork(){
        
        artApp__Artwork__c art = new artApp__Artwork__c();
        art.Name='test';
        art.artApp__Artist__c = getArtist().id;
        art.Crate__c = getCrate().id;
        insert art;
        return art;
    }
    
    public static Crate__c getCrate(){
        Crate__c c = new Crate__c();
        c.Name ='test';
        insert c;
        return c;
    }
    
    public static Account getAccount(){
        
        Account acc = new Account();
        acc.Name='karan';
        insert acc;
        return acc;
    }
    
    public static opportunity getOpp(){
        opportunity opp = new opportunity ();
        opp.name='test';
        opp.stageName='closed won';
        opp.Estimated_Volume__c =20;
        opp.Pack_Date_1__c = system.today();
        opp.Amount = 500;
        opp.CloseDate = system.today();
        insert opp;
        return opp;
    }
    
    public static OpportunityLineItem getOppLineItem(){
        Account a = new Account(Name = 'Test Account Joe ');
        Id pbID = [select Id, name from PricebookEntry where isActive = True limit 1].id;
        Opportunity o = new Opportunity();
        OpportunityLineItem ol = new OpportunityLineItem();
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        insert o;
        
        ol.OpportunityId = o.Id;
        ol.Quantity = 1;
        ol.UnitPrice = 2.00;
        ol.PricebookEntryId = pbId;
        
        insert ol;
        return ol;
    }
    
    public static event getEvent(){
        
        Account a= new Account ();
        a.name='Test Account';
        insert a;
        
        Event e = new Event();
        e.WhatId=a.id;
        e.StartDateTime=system.today();
        e.EndDateTime=system.today()+5;
        insert  e;
        return e;       
    }
    
}