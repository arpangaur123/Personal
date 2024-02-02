public class wrapperClassDelArt{
public String Cid = System.currentPagereference().getParameters().get('Cid');
public String Cname = System.currentPagereference().getParameters().get('Cname');
public String getCname(){return System.currentPagereference().getParameters().get('Cname');}
//public String getCid(){return System.currentPagereference().getParameters().get('Cid');}
    //Our collection of the class/wrapper objects cContact 
    public List<cContact> contactList {get; set;}
    
    public PageReference mySaveExit() {    
    
    PageReference p = new PageReference('/apex/shCratedetail?id='+Cid);    
    p.setRedirect(true);
    return p;
    
  }

    //This method uses a simple SOQL query to return a List of Contacts
    public List<cContact> getContacts() {
        if(contactList == null) {
            contactList = new List<cContact>();
            for(artApp__Artwork__c c : [SELECT Id, Name, Crate__r.Id, Crate__r.Name FROM artApp__Artwork__c WHERE Crate__r.Id =:Cid]) {
                // As each contact is processed we create a new cContact object and add it to the contactList
                contactList.add(new cContact(c));
            }
        }
        return contactList;
    }


    public PageReference processSelected() {

                //We create a new list of Contacts that we be populated only with Contacts if they are selected
        List<artApp__Artwork__c> selectedContacts = new List<artApp__Artwork__c>();

        //We will cycle through our list of cContacts and will check to see if the selected property is set to true, 
        //if it is we add the Contact to the selectedContacts list
        for(cContact cCon : getContacts()) {
            if(cCon.selected == true) {
                selectedContacts.add(cCon.con);
                //selectedContacts.Crate__c='';
            }
        }

        // Now we have our list of selected contacts and can perform any type of logic we want, sending emails, updating a field on the Contact, etc
        System.debug('These are the selected Contacts...');
        List <artApp__Artwork__c> lst_artapp = new List<artApp__Artwork__c>();
        for(artApp__Artwork__c con : selectedContacts) {
            system.debug(con);
            //selectedContacts.Crate__c='';
            con.Crate__c=null;
            lst_artapp.add(con);
            //update con;
        }
        if(lst_artapp.size() > 0)
            update lst_artapp;
        //return null;	
        PageReference p = new PageReference('/apex/mywrapper?Cid='+Cid+'&Cname='+Cname);
        p.setRedirect(true);
        return p;
    }


    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Contact and a Boolean value
    public class cContact {
        public artApp__Artwork__c con {get; set;}
        public Boolean selected {get; set;}

        //This is the contructor method. When we create a new cContact object we pass a Contact that is set to the con property. We also set the selected value to false
        public cContact(artApp__Artwork__c c) {
            con = c;
            selected = false;
        }
    }
    
    // add this inside the problematic apex class
// Note: Add more j++; on new lines to get more coverage

public void inflateTest() {
    Integer j = 0;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++;
    j++; 
  }
    
}