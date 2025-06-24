@IsTest
private class FieldPathResolver_Test {

    @IsTest
    static void testSimpleFieldResolution() {
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Case.sObjectType, 'Subject');
        System.Assert.areEqual('Subject', result.apiName);
        System.Assert.areEqual('Case', result.objectApiName);
        System.Assert.areEqual('Subject', result.label, 'Expected label to be populated');
        System.Assert.isFalse(result.isRelationship);
        System.Assert.isNull(result.relationshipName);
        System.Assert.isNotNull(result.fieldDescribe);
        System.Assert.areEqual(Schema.DisplayType.STRING, result.fieldDescribe.getType());
    }

    @IsTest
    static void testOneLevelRelationshipResolution() {
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Case.sObjectType, 'Contact.Email');
        System.Assert.areEqual('Contact.Email', result.apiName);
        System.Assert.areEqual('Contact', result.objectApiName);
        System.Assert.areEqual('Email', result.label, 'Expected label to be populated');
        System.Assert.isTrue(result.isRelationship);
        System.Assert.areEqual('Contact', result.relationshipName);
        System.Assert.isNotNull(result.fieldDescribe);
        System.Assert.areEqual(Schema.DisplayType.EMAIL, result.fieldDescribe.getType());
    }

    @IsTest
    static void testTwoLevelRelationshipResolution() {
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Case.sObjectType, 'Contact.Account.Industry');
        System.Assert.areEqual('Contact.Account.Industry', result.apiName);
        System.Assert.areEqual('Account', result.objectApiName);
        System.Assert.areEqual('Industry', result.label, 'Expected label to be populated');
        System.Assert.isTrue(result.isRelationship);
        System.Assert.areEqual('Account', result.relationshipName);
        System.Assert.isNotNull(result.fieldDescribe);
        System.Assert.areEqual(Schema.DisplayType.PICKLIST, result.fieldDescribe.getType());
    }

    @IsTest
    static void testInvalidFieldPath() {
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Case.sObjectType, 'Contact.NonExistent');
        System.Assert.areEqual('Contact.NonExistent', result.apiName);
        System.Assert.areEqual('Case', result.objectApiName, 'Should return base object name when invalid');
        System.Assert.isNull(result.label);
        System.Assert.isFalse(result.isRelationship, 'Should be false since field resolution failed');
        System.Assert.isNull(result.relationshipName);
        System.Assert.isNull(result.fieldDescribe);
    }

    @IsTest
    static void testFallbackByRelationshipName() {
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Contact.sObjectType, 'Account.Name');
        System.Assert.areEqual('Account.Name', result.apiName);
        System.Assert.areEqual('Account', result.objectApiName);
        System.Assert.areEqual('Account Name', result.label);
        System.Assert.isTrue(result.isRelationship);
        System.Assert.areEqual('Account', result.relationshipName);
        System.Assert.isNotNull(result.fieldDescribe);
        System.Assert.areEqual(Schema.DisplayType.STRING, result.fieldDescribe.getType());
    }

    @IsTest
    static void testNonRelationshipMidPath() {
        // Attempt to resolve something like Name.Account.Industry
        FieldPathResolutionResult result = FieldPathResolver.resolveFieldPath(Schema.Case.sObjectType, 'Subject.Account.Industry');
        System.Assert.areEqual('Subject.Account.Industry', result.apiName);
        System.Assert.areEqual('Case', result.objectApiName);
        System.Assert.isNull(result.label);
        System.Assert.isFalse(result.isRelationship);
        System.Assert.isNull(result.fieldDescribe);
    }
    
}
