@IsTest
public class TestDataFactory {

    public static List<Account> createAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numberOfAccounts; i++) {
            accounts.add(
                new Account(Name = 'Test account ' + String.valueOf(i))
            );
        }
        return accounts;
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
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.LinkedEntityId = (Id) sobj.get('Id');
            cdl.ShareType = 'I';
            cdl.ContentDocumentId = cvRefreshed.ContentDocumentId;
            cdl.Visibility = 'AllUsers'; 
            cdls.add(cdl);
        }
        
        return cdls;
    }

}