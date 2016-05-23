<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Employee_Deactivated</fullName>
        <ccEmails>mustafa.jhabuawala@extrapreneursindia.com</ccEmails>
        <description>Employee Deactivated</description>
        <protected>false</protected>
        <recipients>
            <field>Manager_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Employee_Deactivation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Employee_Manager_Email</fullName>
        <field>Manager_Email__c</field>
        <formula>Manager__r.Email__c</formula>
        <name>Employee Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Manager_Email</fullName>
        <field>Manager_Email__c</field>
        <formula>Email__c</formula>
        <name>Manager Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Non_Techincal</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Role_Unique_ID</fullName>
        <field>Role_Unique_ID__c</field>
        <formula>Role__r.Id</formula>
        <name>Role Unique ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Role_Unique_ID1</fullName>
        <field>Role_Unique_ID__c</field>
        <formula>Role__r.Id</formula>
        <name>Role Unique ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Role_Unique_ID2</fullName>
        <field>Role_Unique_ID__c</field>
        <formula>Role__r.Id</formula>
        <name>Role Unique ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Employee Deactivation</fullName>
        <actions>
            <name>Employee_Deactivated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Is_Active__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Employee Role Assignment</fullName>
        <actions>
            <name>Role_Unique_ID2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Get Manager Email - Employee</fullName>
        <actions>
            <name>Employee_Manager_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Record Type to Non Technical</fullName>
        <actions>
            <name>Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employee__c.Current_Employee__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
