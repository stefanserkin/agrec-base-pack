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

    @IsTest
    static void testTransactionTriggerRecord() {
        Id contactId = TriggerTestUtility.getFakeId(Contact.SObjectType);
        Id trxId = TriggerTestUtility.getFakeId(TREX1__Transaction__c.SObjectType);

        String oldStatus = 'Draft';
        String newStatus = 'Close';

        TREX1__Transaction__c oldTrx = TestDataFactory.createTransaction(contactId);
        oldTrx.Id = trxId;
        oldTrx.TREX1__Status__c = oldStatus;

        TREX1__Transaction__c newTrx = oldTrx.clone(true, true, true, true);
        newTrx.TREX1__Status__c = newStatus;

        TransactionTriggerRecord triggerRecord = new TransactionTriggerRecord();
        Test.startTest();
        triggerRecord.newSobject = newTrx;
        triggerRecord.oldSobject = oldTrx;
        Test.stopTest();

        System.Assert.areEqual(trxId, triggerRecord.record.Id, 'Should have received the original record id');
        System.Assert.areEqual(newStatus, triggerRecord.record.TREX1__Status__c, 'Received incorrect status for the new record');
        System.Assert.areEqual(oldStatus, triggerRecord.recordPrior.TREX1__Status__c, 'Received incorrect status for prior record');
    }

}