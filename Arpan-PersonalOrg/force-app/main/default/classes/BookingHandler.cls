public class BookingHandler {
    
    Public Static void validateTheBookingOnInsert(List<Booking__c> newBookingList){
        commanValidationOnUpdateInsert(newBookingList);
        
    } 

    public static void validateTheBookingOnUpdate(List<Booking__c> BookingList , Map<Id, Booking__c> idToBookingoldMap){
        List<Booking__c> bookingListForUpdateion = new List<Booking__c>();
            for(Booking__c booking : BookingList){
                if(booking.Start_Date__c != idToBookingoldMap.get(booking.Id).Start_Date__c 
                   || booking.End_Date__c != idToBookingoldMap.get(booking.Id).End_Date__c 
                   || booking.Room__c != idToBookingoldMap.get(booking.Id).Room__c
                   || Booking.Check_In_Status__c != idToBookingoldMap.get(booking.Id).Check_In_Status__c){
                    bookingListForUpdateion.add(booking);
                }
            }
        commanValidationOnUpdateInsert(bookingListForUpdateion);
        
    }
    
    public static void commanValidationOnUpdateInsert(List<Booking__c> ListOfBookings){
        Set<Id> setOfCustomerId = new Set<Id>();
        Set<Id> setOfRoomId = new Set<Id>();
        for(Booking__c booking : ListOfBookings){
            setOfCustomerId.add(booking.Customer__c);
            setOfRoomId.add(booking.Room__c);
        }
        Map<Id, Room__c> idToRoomMap = new Map<Id, Room__c>([SELECT Id, Name, Maintenance_Mode__c,Check_in_Check_Out_Time__c,Booking_Amount__c,
                                                             (SELECT Id, Name,Check_In_Status__c,End_Date__c,Start_Date__c,Check_Out_Time__c, Customer__r.Name 
                                                              from Bookings__r ORDER BY End_Date__c ) 
                                                             from Room__c WHERE ID IN:setOfRoomId]);
        Map<Id, Contact> idToCustomerMap = new  Map<Id, Contact>([SELECT Id, Name,(SELECT Id, Name,Start_Date__c FROM Bookings__r) FROM Contact WHERE Id IN:setOfCustomerId ]); 
        system.debug('map' + idToRoomMap);
        
        for(Booking__c booking : ListOfBookings){
            setOfCustomerId.add(booking.Customer__c);
            if(booking.Room__c == NULL){
                booking.Room__c.addError('Please select the Room');
            }
            if(idToRoomMap.get(booking.Room__c).Check_in_Check_Out_Time__c == 'Standard'){
                booking.Check_In_Time__c = Time.newInstance(11,00,00, 000);
                booking.Check_Out_Time__c = Time.newInstance(12,00,00, 000);
            }
            if(booking.Check_In_Time__c == NULL || booking.Check_Out_Time__c == NULL || booking.Start_Date__c == NULL || booking.End_Date__c == NULL){
                booking.addError('Please check all the time related fields. They can\'t be blank');
            }
            if(booking.End_Date__c < booking.Start_Date__c){
                booking.End_Date__c.addError('End date should be preceding Date of '+ booking.Start_Date__c);
            }
            if(idToRoomMap.get(booking.Room__c).Maintenance_Mode__c == True){
                booking.addError(idToRoomMap.get(booking.Room__c).Name + '- This room is in maintenance mode. Please try for Another room.');
            }
//Validate,Room can't be booked twice for the same date.
            
                if(idToRoomMap.get(booking.Room__c).Bookings__r.size() > 0){
                    for(Booking__c oldbooking : idToRoomMap.get(booking.Room__c).bookings__r){
                        if(( oldbooking.End_Date__c > booking.Start_Date__c )){
                            if((oldbooking.Check_out_Time__c >= booking.Check_in_Time__c)){
                                system.debug('room name'+oldbooking.name);
                                booking.addError('There is already a booking : ' + oldbooking.name +' till ' + oldbooking.End_Date__c + ' ' + booking.Check_out_Time__c);
                                System.debug('Current Booking start date : ' + booking.Start_Date__c); 
                            }
                        }
                    }
                } 
                 
//validate, if check_In_Status is Check-Out then room's field(Booking_amount) and booking's field(Amount_Paid) should be equal
            if(booking.Check_In_Status__c == NULL){
                booking.Check_In_Status__c.addError('Please select the status');
            }
            else{
                if(booking.Check_In_Status__c == 'Check-Out' && booking.Amount_Paid__c != idToRoomMap.get(booking.Room__c).Booking_Amount__c){
                    Decimal dueAmount = idToRoomMap.get(booking.Room__c).Booking_Amount__c - booking.Amount_Paid__c ;  
                    booking.Amount_Paid__c.addError('Please pay the due amount--' +dueAmount); 
                }
            }
// This validate that a Customer can't has more than 2 booking for same date
            if(booking.Customer__c == null)
            {
                booking.Customer__c.addError('Please provide customer name');
            }
            else {
                Integer count = 0;
                for(Booking__c conSize : idToCustomerMap.get(booking.Customer__c).Bookings__r){
                    if(conSize.Start_Date__c == booking.Start_Date__c){
                        count++;
                    }
                    if(count>=2){
                        booking.addError('You can\'t book more than 2 booking for same date');
                    }
                }	
            }
        }
    }  
}  
















/*
public static void validateTheBookingOnUpdate(List<Booking__c> newBookingList , Map<Id, Booking__c> idToBookingMap){
Map<Id, Room__c> idToRoomMap = new Map<Id, Room__c>([SELECT Id, Name, Maintenance_Mode__c,Check_in_Check_Out_Time__c,Booking_Amount__c,
(SELECT Id, Name,Check_In_Status__c,End_Date__c,Start_Date__c,Check_Out_Time__c, Customer__r.Name 
from Bookings__r  ) 
from Room__c]);
for(Booking__c Booking : newBookingList){




List<Booking__c> bookingListForUpdation = new List<Booking__c>();

for(Booking__c booking : newBookingList){
if( booking.Start_Date__c != idToBookingMap.get(booking.Id).Start_Date__c ||
booking.End_Date__c != idToBookingMap.get(booking.Id).End_Date__c || 
booking.Check_In_Time__c != idToBookingMap.get(booking.Id).Check_In_Time__c ||
booking.Check_Out_Time__c != idToBookingMap.get(booking.Id).Check_Out_Time__c ||
booking.Check_In_Status__c != idToBookingMap.get(booking.Id).Check_In_Status__c ||
booking.Amount_Paid__c != idToBookingMap.get(booking.Id).Amount_Paid__c){
bookingListForUpdation.add(booking);
system.debug('if');
}
else{
if(booking.Check_In_Status__c == 'Check-Out'){
bookingListForUpdation.add(booking); 
system.debug('else');
}
}
}
system.debug('list'+bookingListForUpdation);
validateTheBookingOnInsert(bookingListForUpdation);
*/

/*
DateTime dt = DateTime.newInstance(2022,09,10);
String dateStr = dt.format('yyyy/MM/dd');
System.debug('>>>>' + dateStr);


DateTime dt1 = DateTime.newInstance(2022,09,10);
DateTime dt2 = DateTime.newInstance(2022,09,11);
String dateStr1 = dt1.format('yyyy/MM/dd');
String dateStr2 = dt2.format('yyyy/MM/dd');
Integer S_E = dt1.daysBetween(dt2);
Integer E_S = dt2.daysBetween(dt1);
system.debug('S_E'+ S_E);
system.debug('E_S'+ E_S);
if(dateStr1>dateStr2){
System.debug('SDate'+dateStr1);
}
else{
System.debug('EDate'+dateStr2); 
}
System.debug('>>>>' + dateStr1);
//System.assertEquals(dateStr, '2015/04/24');

*/