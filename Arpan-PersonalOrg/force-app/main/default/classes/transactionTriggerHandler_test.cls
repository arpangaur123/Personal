@isTest
public class transactionTriggerHandler_test {
    static testmethod void dotest(){
                List<artApp__Transaction__c> Tran_List = new List<artApp__Transaction__c>();
        
        Id accRTid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Account acc1 = new Account();
        acc1.Name = 'Montjoie Art Transactions';
        acc1.Type = 'Consultant/Dealer';
        acc1.RecordTypeId = accRTid;
        acc1.BillingStreet = '30 Avenue de la Republique';
        acc1.BillingCity = 'Neauphle Le Chateau';
        acc1.BillingPostalCode = '78640';
        acc1.BillingCountry = 'France';
        acc1.Phone = '+33 316 430 594';
        acc1.CurrencyIsoCode = 'SGD';
        insert acc1;
        
        
        
        Id  conRTid = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Artmove').getRecordTypeId();
        Contact con1 = new Contact();
        con1.AccountId = acc1.Id;
        con1.LastName = 'Laurent';
        con1.FirstName = 'Raoul';
        con1.RecordTypeId = conRTid;
        con1.MailingStreet = '30 Avenue de la Republique';
        con1.MailingCity = 'Neauphle Le Chateau';
        con1.MailingPostalCode = '78640';
        con1.MailingCountry = 'France';
        con1.Phone = '+33 316 430 594';
        con1.Email = 'raoullaurent-mat@wanadoo.fr';
        con1.CurrencyIsoCode = 'SGD';
        con1.Do_you_own_a_car__c = 'No';
        con1.Category__c = 'Carpenter';
        con1.Any_Relative_Acquaintance_in_Helutrans__c = 'No';
        con1.Personal_Character_References__c = 'Name';
        insert con1;
        
        Id artTranRTid = Schema.SObjectType.artApp__Transaction__c.getRecordTypeInfosByName().get('Release Order').getRecordTypeId();
        artApp__Transaction__c artTran1 = new artApp__Transaction__c();
        artTran1.CurrencyIsoCode = 'SGD';
        artTran1.RecordTypeId = artTranRTid;
        artTran1.artApp__Date__c = system.today();
        artTran1.artApp__Payment_Term__c = 'Prepay';
        artTran1.artApp__Shipping_Method__c = 'Customer Pickup';
        artTran1.artApp__Shipping_Term__c = 'FOB Origin';
        artTran1.Released_to__c = 'na';
        artTran1.Service_AddressHK__c = 'Helu-Trans HK Warehouse at GG / CHS / SC';
        artTran1.Payment_to_be_Collected__c = 10000;
        artTran1.Assigned_to__c = con1.id;
        Tran_List.add(artTran1);
        insert Tran_List;
        
        transactionTriggerHandler.upsertTransaction(Tran_List);
    }
}