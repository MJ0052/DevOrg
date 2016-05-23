public with sharing class QueryBuilderController {
	
	public String SelectedObject {get; set;}
	public String[] SelectedFields {get; set;}
	public String[] SelectedFieldsRight {get; set;}
	public String GeneratedQuery {get; set;}
    public List<sObject> SObjectList {get; set;}  
    public String SelectedOrder {get;set;}
    public String SelectedRecordsToDisplay {get;set;}
	public String SelectedFieldForOrder {get;set;}
	public List<String> FieldsOnLeft = new List<String>();
	public List<String> FieldsOnRight = new List<String>();
	
	
	public QueryBuilderController(){
		SelectedOrder = 'asc';
	}
	public List<SelectOption> getNumberOfRecordsList(){
		List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('500','500'));
        options.add(new SelectOption('1000','1000'));
        options.add(new SelectOption('5000','5000'));
        options.add(new SelectOption('50000','50000'));
        return options;
	}
	public List<SelectOption> getOrder() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('asc','Ascending'));
        options.add(new SelectOption('desc','Descending'));
       
        return options;
    }
    public List<SelectOption> getObjectList() {
    	List<SelectOption> options = new List<SelectOption>();
    	try{
        	options.add(new SelectOption('', 'Select'));  
        	Map <String,Schema.SobjectType> schemaMap=Schema.getGlobalDescribe(); 
			List<String> gd=new List<String>(schemaMap.keyset());
			gd.sort();
     		for(String s:gd)
     		{
         		options.add(new SelectOption(s,s));
     		}
        }
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting object list '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }  
        return options;
    }
    public void RetrieveSelectedObjectFields(){
    	SelectedFields = new List<String>();
    	GeneratedQuery = '';
    	SObjectList = new List<sObject>(); 
    	FieldsOnLeft = new List<String>();
    	FieldsOnRight = new List<String>();
    }
    public void RetrieveQuery(){
    	ShowGeneratedQuery();
    }
    public List<SelectOption> getFieldList() {
    	List<SelectOption> options = new List<SelectOption>();
    	try{
    		if(SelectedObject != null && SelectedObject != ''){
				String query = 'SELECT';
				Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(SelectedObject).getDescribe().fields.getMap();
				List<String> gd=new List<String>(objectFields.keyset());
				gd.sort();
     			for(String s:gd)
     			{
     				Boolean flagToAdd = true;
     				System.debug('FieldsOnRight' + FieldsOnRight);
     				if(FieldsOnRight != null && FieldsOnRight.size() > 0){
     					for(String sf: FieldsOnRight){
     						System.debug('FieldsOnRight' + FieldsOnRight);
     						if(sf == s){
     							flagToAdd = false;
     							break;
     						}
     					}
     				}
     				if(flagToAdd){
	         			options.add(new SelectOption(s,s));
	         			FieldsOnLeft.add(s);
     				}
    	 		}
    		}
        }
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting object fields list '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }
        if(options != null && options.size() > 0){
        	return options;
        }
        else{
        	return null;
        }
    }
    public List<SelectOption> getFieldListRight(){
    	List<SelectOption> options = new List<SelectOption>();
    	if(FieldsOnRight != null && FieldsOnRight.size() > 0){
    		for(String fieldsAtRight : FieldsOnRight){
    			options.add(new SelectOption(fieldsAtRight,fieldsAtRight));
    		}
    	}
    	return options;
    }
    public void ShowGeneratedQuery(){
    	try{
    		GeneratedQuery = 'Select Id ' ; 
        	for(String field : FieldsOnRight)  
        	{  
	            if(field.toLowerCase() != 'id' && field.toLowerCase() != '--none--')  
            GeneratedQuery += ','+ field + ' ' ;  
        }  
        GeneratedQuery += ' from ' + SelectedObject + ' ORDER BY ' + SelectedFieldForOrder + ' ' + SelectedOrder + ' LIMIT ' + SelectedRecordsToDisplay;
        }
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting object list '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }  
    }
    
    public void QueryResult()  
    {  
    	try{
        SObjectList = Database.query(GeneratedQuery);
        if(SObjectList.size() <= 0){
        	SObjectList = null;
        }  
        }
        catch(Exception e){
        	ApexPages.Message errormsg = new ApexPages.Message(ApexPages.severity.ERROR,'An error has occured while getting query result '+e.getMessage());
            ApexPages.addMessage(errormsg);
        }  
    }  
    public void AddTo(){
	  	for(String fieldsAtLeft : selectedFields){
    		FieldsOnRight.add(fieldsAtLeft);
    	}
    	RetrieveQuery();
    }
    public void RemoveFrom(){
    	if(selectedFieldsRight != null && selectedFieldsRight.size() > 0){
    	List<String> TempFieldsOnRight = new List<String>();
    	for(String fieldsAtRight : selectedFieldsRight){
    		FieldsOnLeft.add(fieldsAtRight);
    	}
    	for(String fieldsAtRight : FieldsOnRight){
    		Boolean flag = true;
    		for(String sF : selectedFieldsRight){
    			if(sF == fieldsAtRight){
    				flag = false;
    				break;
    			}
    		}
    		if(flag){
    			TempFieldsOnRight.add(fieldsAtRight);
    		}
    	}
    	FieldsOnRight = new List<String>();
    	FieldsOnRight = TempFieldsOnRight;
    	}
    	RetrieveQuery();
    }
}