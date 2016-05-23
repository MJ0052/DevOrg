@isTest
public class DulicateLeadHandlerTest {

     static testMethod void dulicatecheck()
    {
        List<Lead> leadlist = new LIST<Lead>();
         
        for(integer i=0;i<5;i++)
        {
            lead l= new Lead();
            l.LastName = 'test';
            l.Phone = '9893745601';
            l.Company = 'leadcomp';
            leadlist.add(l);
        }
           
        if(leadlist.size()>0)
        insert leadlist;
        System.assertEquals(0, leadlist.size());    
    }
}