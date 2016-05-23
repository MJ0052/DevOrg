@isTest
public with sharing class QueryBuilderControllerTest {
	@testSetup 
	static void setUp() {
		Account accountObj;
		List<Account> accountList = new List<Account>();
		for(Integer i=1;i<=10;i++){
			accountObj = new Account();
			accountObj.Name = 'QUERY BUILDER TEST ' + i;
			accountList.add(accountObj);
		}
		insert accountList;
	}
	
    static testmethod void GetObjectList(){
    	QueryBuilderController controller = new QueryBuilderController();
    	Map <String,Schema.SobjectType> schemaMap=Schema.getGlobalDescribe(); 
    	List<SelectOption> soption = controller.getFieldList();
    	System.assertEquals((soption == null || soption.size() == 0) ? true : false,true);
    	List<SelectOption> optionList = controller.getObjectList();
    	System.assertEquals(schemaMap.size(),optionList.size() + 1);
    }
    static testmethod void GetObjectFieldList(){
    	QueryBuilderController controller = new QueryBuilderController();
    	List<SelectOption> objectoptionList = controller.getObjectList();
    	controller.SelectedObject = objectoptionList[3].getValue();
    	controller.RetrieveSelectedObjectFields();
    	List<SelectOption> fieldoptionList = controller.getFieldList();
    	
    	Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(controller.SelectedObject).getDescribe().fields.getMap();
		for(Integer i=0;i< fieldoptionList.size();i++){
			System.assertEquals((objectFields.get(fieldoptionList[i].getValue()))!=null ? true:false,true);
		}
    }
    static testmethod void GenerateQuery(){
    	QueryBuilderController controller = new QueryBuilderController();
    	List<SelectOption> objectoptionList = controller.getObjectList();
    	controller.SelectedObject = objectoptionList[3].getValue();
    	List<SelectOption> fieldoptionList = controller.getFieldList();
    	controller.SelectedFields = new List<String>();
    	Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(controller.SelectedObject).getDescribe().fields.getMap();
		for(Integer i=0;i< fieldoptionList.size();i++){
			System.assertEquals((objectFields.get(fieldoptionList[i].getValue()))!=null ? true:false,true);
			controller.SelectedFields.add(fieldoptionList[i].getValue());
		}
		controller.getNumberOfRecordsList();
		controller.getOrder();
		controller.SelectedOrder = 'asc';
		controller.SelectedFieldForOrder = fieldoptionList[1].getValue();
		controller.SelectedRecordsToDisplay = '500';
		controller.RetrieveQuery();
		controller.QueryResult();
		List<Account> accountList1 = new List<Account>([Select Id from Account]);
		System.assertEquals(controller.SObjectList.size(),accountList1.size());
		
		delete accountList1;
		controller.QueryResult();
		System.assertEquals(controller.SObjectList == null ? true : false,true);
		//controller.GeneratedQuery;
    }
}