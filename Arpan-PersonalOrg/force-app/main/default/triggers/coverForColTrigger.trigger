trigger coverForColTrigger on artApp__Artwork__c (before delete) {

     

      if(trigger.isdelete){

            //process Trigger.old list records here

            for(artApp__Artwork__c aw:Trigger.old){

if(aw.artApp__Collector__c != null){

                        aw.addError('This artwork is attached to a collector and cannot be deleted!');

                  }

            }

      }

}