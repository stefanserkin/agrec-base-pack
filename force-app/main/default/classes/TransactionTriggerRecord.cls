global class TransactionTriggerRecord extends TriggerRecord {

    global TREX1__Transaction__c record {
        get {
            return (TREX1__Transaction__c) this.newSObject;
        }
    }
    
    global TREX1__Transaction__c recordPrior {
        get {
            return (TREX1__Transaction__c) this.oldSObject;
        }
    }

}