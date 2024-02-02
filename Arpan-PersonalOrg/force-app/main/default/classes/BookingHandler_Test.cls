@isTest
public class BookingHandler_Test {
    @testSetup static void setup(){
        //Contact data
        Contact con = new Contact();
        con.FirstName = 'Arpan';
        con.LastName = 'Gaur';
        insert con;
        
        //Room Data
        Room__c room = new Room__c();
        room.Name = 'Ac Room 101';
        room.Check_in_Check_Out_Time__c = 'Adjustable';
        room.Booking_Amount__c = 2000;
        room.Maintenance_Mode__c = False;
        insert room;
        
        //Booking Data
        Booking__c booking = new Booking__c();
        booking.Name = 'Booking 1';
        //booking.Customer__c = 
        booking.Start_Date__c = System.today() +5;
        booking.End_Date__c = System.today() + 7;
        //time 
        booking.Check_In_Status__c = 'Check-In';
        booking.Check_In_Time__c = Time.newInstance(10, 30, 00, 00);
        booking.Check_Out_Time__c = Time.newInstance(11, 30, 00, 00);
        booking.Amount_Paid__c = 1500;
        booking.Customer__c = con.Id;
        booking.Room__c = room.Id;
        insert booking;
        
        
    }
    @isTest
    Public Static void validateTheBookingOnInsert_test(){
        
        List<Booking__c> bookingList = [SELECT Id,Customer__c,Room__c, Check_In_Status__c, Name, Start_Date__c, End_Date__c, Check_In_Time__c,Amount_Paid__c, Check_Out_Time__c  FROM Booking__c];
        Test.startTest(); 
        BookingHandler.validateTheBookingOnInsert(bookingList);
        Test.stopTest();
    }
    @isTest
    Public static void validateTheBookingOnUpdate_test(){
        List<Booking__c> bookingList = [SELECT Id,Customer__c,Room__c, Check_In_Status__c, Name, Start_Date__c, End_Date__c, Check_In_Time__c,Amount_Paid__c, Check_Out_Time__c  FROM Booking__c];
        Map<Id,Booking__c> idToBookingMap = new Map<Id,Booking__c>(bookingList);
        
        for(Booking__c booking : bookingList){
            booking.Start_Date__c = system.today()+8;
            booking.End_Date__c = System.today()+9;
            booking.Check_In_Status__c = 'Check-Out';
            booking.Amount_Paid__c = 2000;
        }
        update bookingList;
        Test.startTest(); 
        BookingHandler.validateTheBookingOnUpdate(bookingList,idToBookingMap);
        Test.stopTest();
    }
    
    @isTest
    Public static void validateTheBookingOnUpdate_test2(){
        //Contact data
        Contact con = new Contact();
        con.FirstName = 'Arpan';
        con.LastName = 'Gaur';
        insert con;
        
        //Room Data
        Room__c room = new Room__c();
        room.Name = 'Ac Room 101';
        room.Check_in_Check_Out_Time__c = 'Standard';
        room.Booking_Amount__c = 2000;
        room.Maintenance_Mode__c = True;
        insert room;
        
        //Booking Data
        List<Booking__c> bookingList = new List<Booking__c>();
        Booking__c booking = new Booking__c();
        booking.Name = 'Booking 1';
        //booking.Check_In_Time__c = Time.newInstance(10, 30, 00, 00);
        booking.Check_Out_Time__c = Time.newInstance(11, 30, 00, 00);
        booking.Start_Date__c = System.today() +7;
        booking.End_Date__c = System.today() + 5;
        //booking.Check_In_Status__c = 'Check-In';
        
        booking.Room__c = room.Id;
        //booking.Amount_Paid__c = 1500;
        //booking.Customer__c = con.Id;
        bookingList.add(booking);
        try{
            insert bookingList;
        }catch(Exception e){
            
        }
        
        Test.startTest(); 
        BookingHandler.validateTheBookingOnInsert(bookingList);
        Test.stopTest();
    }
}