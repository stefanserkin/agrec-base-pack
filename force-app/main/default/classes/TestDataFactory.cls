@NamespaceAccessible
@IsTest
public class TestDataFactory {

    public static List<Account> createAccounts(Integer numberOfRecords) {
        List<Account> records = new List<Account>();
        for (Integer i = 0; i < numberOfRecords; i++) {
            records.add(
                new Account(Name = 'Test account ' + String.valueOf(i))
            );
        }
        return records;
    }

    public static List<Contact> createContacts(Integer numberOfRecords) {
        List<Contact> records = new List<Contact>();
        for (Integer i = 0; i < numberOfRecords; i++) {
            records.add(
                new Contact(
                    FirstName = 'Tester' + String.valueOf(i),
                    LastName = 'Testeroo' + String.valueOf(i),
                    Email = 'testeroodle' + String.valueOf(i) + '@example.com'
                )
            );
        }
        return records;
    }
    
    public static List<ContentDocumentLink> createFiles(List<SObject> linkedEntities) {
        ContentVersion cv = new ContentVersion();
        cv.title = 'Test CDL Trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData = Blob.valueOf('Test File Body');         
        insert cv;

        ContentVersion cvRefreshed = [SELECT Id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];

        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();
        for (SObject sobj : linkedEntities) {
            Id linkedEntityId = (Id) sobj.get('Id');
            cdls.add( createContentDocumentLink(linkedEntityId, cvRefreshed.ContentDocumentId) );
        }
        return cdls;
    }

    public static ContentDocumentLink createContentDocumentLink(Id linkedEntityId, Id contentDocumentId) {
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.LinkedEntityId = linkedEntityId;
        cdl.ContentDocumentId = contentDocumentId;
        cdl.ShareType = 'I';
        cdl.Visibility = 'AllUsers';
        return cdl;
    }

    public static TREX1__Transaction__c createTransaction(Id contactId) {
        Id recordTypeId = Schema.SObjectType.TREX1__Transaction__c.getRecordTypeInfosByDeveloperName().get('Standard').getRecordTypeId();
        TREX1__Transaction__c trx = new TREX1__Transaction__c();
        trx.RecordTypeId = recordTypeId;
        trx.TREX1__Status__c = 'Draft';
        trx.TREX1__Contact__c = contactId;
        return trx;
    }

}