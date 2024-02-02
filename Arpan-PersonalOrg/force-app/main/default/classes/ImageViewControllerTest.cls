@isTest
public class ImageViewControllerTest {
    
    @isTest
    public static void testMthd(){
        artApp__Artist__c aac=new artApp__Artist__c();
        aac.Name='test';
        insert aac;
        
        artApp__Artwork__c app = new artApp__Artwork__c();
        app.Name = 'TestApp';
        app.artApp__Artist__c=aac.id;
        insert app;
        
        
        Attachment n = new Attachment();
        n.Name = 'myImage.jpg';
        n.ContentType = 'text/plain; charset=UTF-8';   
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        n.ParentId = app.Id;
        n.Body = bodyBlob; 
        //n.contentType = 'image/jpeg';
        insert n;
        
        String encryptId = String.valueOf(n.id);
        
        String encodedImageId  = EncodingUtil.base64Encode(Blob.valueOf(encryptId));
       
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < 15) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        encodedImageId+=randStr; 
        
        PageReference pgRf = Page.ImageView;
        Test.setCurrentPage(pgRf);
        System.currentPageReference().getParameters().put('eid',encodedImageId);
        ImageViewController img = new ImageViewController();
        
        
    }
}