public class Callout99Acres {
    public static void getResponse(){
        String userName;
        String passWord;
        
        Http http = new Http();
        httpRequest request = new httpRequest();
        request.setEndpoint('https://www.99acres.com/99api/postData2.php?api=getmy99Response');
        request.setMethod('GET');
        String requestBody = '<?xml version="1.0"?><query><user_name>arpangaur123</user_name><pswd>Arpangaur@123</pswd><start_date>2013-02-20 00:00:00</start_date><end_date>2013-02-20 00:00:00</end_date></query>';
        request.setBody(requestBody);
        
            
            
    }
}