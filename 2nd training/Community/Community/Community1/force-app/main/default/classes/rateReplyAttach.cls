public class rateReplyAttach {
        public Rate_Reply__c rr { get; private set;}
        private ApexPages.Standardcontroller controller;
        
        id rateReplyID;
        public rateReplyAttach (){
                rateReplyID = ApexPages.currentPage().getParameters().get('id');
                rr = [Select r.id, r.recordTypeId, r.RecordType.Name, r.Quote_Reference2__c From 
                Rate_Reply__c r Where id =: rateReplyID limit 1];
        }
        public rateReplyAttach (ApexPages.StandardController c) {
                controller = c;
                rateReplyID = c.getRecord().id;
                rr = [Select r.id, r.recordTypeId, r.RecordType.Name, r.Quote_Reference2__c From 
                Rate_Reply__c r Where id =: rateReplyID limit 1]; 
        }
        
        public PageReference attachQuote() {
                String pageURL = '';
                
                /* Set page definition */
                if(rr.RecordType.Name == 'DS Air Shipment') {
                        pageURL = '/apex/rateReplyDS';
                } else if (rr.RecordType.Name == 'DS Diplomatic Shipment') {
                        pageURL = '/apex/rateReplyDSdiplomat';
                } else if (rr.RecordType.Name == 'DS FCL') {
                        pageURL = '/apex/rateReplyDSFCL';
                } else if (rr.RecordType.Name == 'DS LCL') {
                        pageURL = '/apex/rateReplyDSlcl';
                }
                else if (rr.RecordType.Name == 'Origin Service') {
                        pageURL = '/apex/rateReplyOS';
                }
                PageReference pdfPage = new PageReference(pageURL);
                
                /* Set rate reply ID on page defintion */
                pdfPage.getParameters().put('id', rr.id);
                
                /* Generate PDF Blob */
                Blob pdfBlob;
                if(!test.isRunningTest()){ // Date: 1/14/2016:- for skipping in this code in Test Class because it was throwing error of Method donot support getContent
					pdfBlob = pdfPage.getContent();
				}else{
					pdfBlob = blob.valueof('TEST');
				}
                //Blob pdfBlob = pdfPage.getContent();
                
                /* Convert PDF as attachment in Internal Costing object */
                Attachment a = new Attachment(parentId = rr.id, 
                name = 'Rate Reply - ' + rr.Quote_Reference2__c + '.pdf', body = pdfBlob);
                        
                /* insert attachment to object */
                insert a;
                
                /* Redirect to display PDF page */
                pdfPage.setRedirect(true);
                return pdfPage;
        }
        static testMethod void t1() {
                Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LIM', accountid=A.id, Email='lim@myMail.com');
        insert c;
                          
        Rate_Reply__c r = new Rate_Reply__c (recordtypeid = '01220000000TsdvAAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'agent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 01), Currency__c = 'USD');
        insert r;
        
                rateReplyAttach rra = new rateReplyAttach ( new ApexPages.StandardController(r) );
        }
        public static testMethod void test1() {
                Account a = new Account(name='Tan Enterprise');
        insert a;
        Contact c = new Contact(firstName='Ken', lastName='LIM', accountid=A.id, Email='lim@myMail.com');
        insert c;
                          
        Rate_Reply__c r = new Rate_Reply__c (recordtypeid = '01220000000TsdvAAC', Agent_Name__c = c.Id,
        Agent_Email__c = 'agent@what.com', Quote_Validity_days__c = '60', Initials__c = 'LLY',
        Date__c = Date.newInstance(2009, 11, 01), Currency__c = 'USD');
        insert r;
                
                PageReference pageRef = new PageReference('/apex/rateReplyDS');
        Test.setCurrentPage(pageRef);
        system.debug( '****************************** rate reply id is '+ r.id);
        
        ApexPages.currentPage().getParameters().put('id', r.id);
        
                rateReplyAttach rra = new rateReplyAttach ();
                try { rra.attachQuote(); } catch( System.NullPointerException npe) { } 
        }
}