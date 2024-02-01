public class artworkCon2 {
    String transactionID = ApexPages.currentPage().getParameters().get('tid');
    String c = ApexPages.currentPage().getParameters().get('count');
    Integer c2 = Integer.valueOf(c);
    public List<artApp__Artwork__c>myListArtworks;
    
    public artworkcon2(ApexPages.StandardController con) {} 
      
    public List<artApp__Artwork__c> getMyListArtworks() {
        myListArtworks = [SELECT id, Name, artApp__Collector__c, II_Permit_No__c, artApp__Year__c, Internal_Location__c, 
        artApp__Artist__c, II_Permit_Declared_Date__c, artApp__Type__c, artApp__Media__c, CurrencyIsoCode, artApp__Cost__c,
        artApp__UOM__c, artApp__Width__c, artApp__Height__c, artApp__Length__c 
        FROM artApp__Artwork__c 
        WHERE (counter__c =: c2)];
        
        return myListArtworks;
    }

    /* Create page navigation */
    public PageReference step3() {
        myListArtworks.clear();
        PageReference artworkPage3 = new PageReference ('/apex/ArtworkStep3');
        artworkPage3.getParameters().put('count',c);
        artworkPage3.getParameters().put('tid',transactionID);
        artworkPage3.setRedirect(true);
        return artworkPage3;
    }
    public PageReference step1() {
        PageReference artworkPage1 = new PageReference ('/apex/ArtworkStep1');
        artworkPage1.setRedirect(true);
        return artworkPage1;
    }
    public PageReference done() {
        PageReference completedPF = new PageReference ('https://emea.salesforce.com/' + ApexPages.currentPage().getParameters().get('tid'));
        completedPF.setRedirect(true);
        return completedPF;
    }

}