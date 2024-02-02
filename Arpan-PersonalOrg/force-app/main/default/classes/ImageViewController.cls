public class ImageViewController {
   public string imgId{get;set;} 
   
   public ImageViewController(){
        String tempId=apexpages.currentpage().getparameters().get('eid');
      system.debug('tempId'+tempId);
        String trimText = tempId.substring(0,tempId.length()-Integer.valueOf(15));
          
        Blob decoded = EncodingUtil.base64Decode(trimText);
       
        	imgId = decoded.toString();
        
   }
}