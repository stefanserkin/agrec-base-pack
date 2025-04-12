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

}