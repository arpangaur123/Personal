trigger BookingTrigger on Booking__c (before insert, before Update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            BookingHandler.validateTheBookingOnInsert(Trigger.new);
        }
        if(Trigger.IsUpdate){
            BookingHandler.validateTheBookingOnUpdate(trigger.new, Trigger.oldMap );
        }
    }
    
}