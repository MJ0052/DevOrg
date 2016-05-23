public class CSVParserController 
{
    public class Headers{
        string header1;
        string header2;
        string header3;
        string header4;
        string header5;
        string header6;
        string data1;
        string data2;
        string data3;
        string data4;
        string data5;
        string data6;
    }
    public class DataMembers{
        string data1;
        string data2;
        string data3;
        string data4;
        string data5;
        string data6;
    }
    public string fileName{get;set;}
    public Blob contentFile{get;set;}
    String[] filelines = new String[]{};
    List<Account> csvUploadedData;
    List<Campaign_Management__c> csvUploadedData1;
    List<Headers> trialData;
    
    public void ReadFile()
    {
        try{
                //FILE CONVERSION FROM BLOB TO STRING
                fileName =blobToString( contentFile,'ISO-8859-1');            
                filelines = fileName.split('\n');
                csvUploadedData = new List<Account>();
            	csvUploadedData1 = new List<Campaign_Management__c>();
            	trialData = new List<Headers>();
                for (Integer i=1;i<filelines.size();i++)
                {
                    String[] csvData = new String[]{};
                    csvData = filelines[i].split(',');
                    
                    Account a = new Account();
                    a.Name = csvData[0];
                    a.ShippingStreet = csvData[1];       
                    a.ShippingCity = csvData[2];
                    a.ShippingState = csvData[3];
                    a.ShippingPostalCode = csvData[4];
                    a.ShippingCountry = csvData[5];
        
                    csvUploadedData.add(a);
                    
                    Campaign_Management__c cm = new Campaign_Management__c();
                    //cm.Name = csvData[0];
                    cm.Campaign_Name__c = csvData[0];       
                    cm.Category__c = csvData[1];
                    cm.Description__c = csvData[2];
                    cm.Type__c = csvData[3];
                    //cm.ShippingCountry = csvData[5];
                    csvUploadedData1.add(cm);
                    
                    Headers headersObj = new Headers();
                    if(i == 1){
                    	headersObj.header1 = csvData[0];
                        headersObj.header2 = csvData[1];
                        headersObj.header3 = csvData[2];
                        headersObj.header4 = csvData[3];
                        headersObj.header5 = csvData[4];
                        headersObj.header6 = csvData[5];
                	}
                    else{
                        headersObj.data1 = csvData[0];
                        headersObj.data2 = csvData[1];
                        headersObj.data3 = csvData[2];
                        headersObj.data4 = csvData[3];
                        headersObj.data5 = csvData[4];
                        headersObj.data6 = csvData[5];
                    }
                    trialData.add(headersObj);
                }
         }
         catch(Exception e){
                 ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured reading the CSV file'+e.getMessage());
                ApexPages.addMessage(errormsg);
         }       
    }
    public List<Account> getUploadedData()
    {
        if (csvUploadedData!= NULL)
            if (csvUploadedData.size() > 0)
                return csvUploadedData;
            else
                return null;                    
        else
            return null;
    }  
    public List<Headers> getCSVTrialData()
    {
        if (trialData!= NULL)
            if (trialData.size() > 0)
                return trialData;
            else
                return null;                    
        else
            return null;
    } 
    public List<Campaign_Management__c> getUploadedData1()
    {
        if (csvUploadedData1!= NULL)
            if (csvUploadedData1.size() > 0)
                return csvUploadedData1;
            else
                return null;                    
        else
            return null;
    }  
    public static String blobToString(Blob input, String inCharset){
        String hex = EncodingUtil.convertToHex(input);
        System.assertEquals(0, hex.length() & 1);
        final Integer bytesCount = hex.length() >> 1;
        String[] bytes = new String[bytesCount];
        for(Integer i = 0; i < bytesCount; ++i)
            bytes[i] =  hex.mid(i << 1, 2);
        return EncodingUtil.urlDecode('%' + String.join(bytes, '%'), inCharset);
    }         
}