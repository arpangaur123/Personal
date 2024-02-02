public class Company {
    public string comName;
    public string ceo;
    public integer employeeCount;
    public Long revenue;
    
    public company(string Name, string ceo, integer employeeCount, long revenue){
        this.comName = Name;
        this.ceo= ceo;
        this.employeecount =employeeCount;
        this.revenue = revenue;
        system.debug('Company name-'+this.comName+ ' CEO-'+ this.ceo+' no. of employee'+this.employeeCount+'revanue'+this.revenue);
    }
    
    List<Client> customers = new List<Client>();
    public void  addcustomer(string clientName,string website, string email,Long phone){
        Client customer = new Client(clientName,website, email, phone);
        customers.add(customer);
    }
    
    public void  showAllCustomer(){
        for(Client customer:customers){
            //  system.debug('client name-'+customer.clientName+' website-'+customer.website+' email-'+customer.email+' phone-'+customer.phone);
            system.debug(customer);
        }
        
    }    
    
    private class Client{
        public string clientName ;
        public string website;
        public string email;
        public Long phone;
        
        public client(string clientName,string website, string email,Long phone){
            this.clientName = clientName;
            this.website = website;
            this.email = email;
            this.phone = phone;
            
        }
    }
}