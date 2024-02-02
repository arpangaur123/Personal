public class ImagInsertionIntoRichText {
    
    public String naam{get;set;}
    public ID folderid{get;set;}
    public Blob file{get;set;}
    
    public void insrt()
    {
        
        Document d= new Document();
        
        d.name = naam;
        d.body=file; // body field in document object which holds the file.
       // d.folderid='00l90000000inFEAAY'; //folderid where the document will be stored insert d;
        insert d;
        /*
Case cs = new Case();
cs.FirstExample__Comments__c = '<img src="https://rustagiankit-developer-edition--c.ap1.content.force.com/servlet/servlet.FileDownload?file='+d.id+'" width="500" height="281"></img>'; //FirstExample is namespace & Comments__c is Rich Text Area field
cs.Status = 'New';
cs.Origin = 'Web';
insert cs;
*/
    }
}