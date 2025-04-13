@IsTest
private class Triggers_Test {
    
    @IsTest
    static void testContentDocumentLinkTrigger() {
        List<Account> accounts = TestDataFactory.createAccounts(1);
        insert accounts;

        List<ContentDocumentLink> cdls = TestDataFactory.createFiles(accounts);

        Test.startTest();
        List<Database.SaveResult> results = Database.insert(cdls, false);
        Test.stopTest();
    }

    @IsTest
    static void testTransactionTrigger() {
        List<Contact> contacts = TestDataFactory.createContacts(1);
        insert contacts;

        TREX1__Transaction__c trx = TestDataFactory.createTransaction(contacts[0].Id);

        Test.startTest();
        List<Database.SaveResult> results = Database.insert(new List<TREX1__Transaction__c>{trx}, false);
        Test.stopTest();
    }

}