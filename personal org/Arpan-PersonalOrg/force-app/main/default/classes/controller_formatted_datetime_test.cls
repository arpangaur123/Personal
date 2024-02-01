@isTest
public class controller_formatted_datetime_test {
    @isTest
    static void getTimeinSGT1(){
        controller_formatted_datetime cfd = new controller_formatted_datetime();
        
        cfd.getFormattedDatetime();
        
        cfd.date_time = system.now();
        cfd.getFormattedDatetime();
        
        cfd.defined_format = 'hh:mm:ss';
        cfd.getFormattedDatetime();
    }
}