@IsTest
private class FieldPathManager_Test {
    
    @IsTest
    static void testNormalize() {
        System.Assert.areEqual('trex1__contact__r.name', FieldPathManager.normalize('  TREX1__Contact__r.Name '),
            'normalize should trim and lowercase input');
        System.Assert.areEqual('', FieldPathManager.normalize(null),
            'normalize should return empty string for null input');
        System.Assert.areEqual('', FieldPathManager.normalize('   '),
            'normalize should return empty string for blank input');
    }

    @IsTest
    static void testIsValid() {
        System.Assert.isTrue(FieldPathManager.isValid('trex1__contact__r.name'),
            'isValid should accept normal field paths with underscores and dots');
        System.Assert.isTrue(FieldPathManager.isValid('name'),
            'isValid should accept simple field paths');

        System.Assert.isFalse(FieldPathManager.isValid('trex1__contact__r.name '),
            'isValid should reject field paths with spaces');
        System.Assert.isFalse(FieldPathManager.isValid('trex1__contact__r.{name}'),
            'isValid should reject field paths with invalid characters');
        System.Assert.isFalse(FieldPathManager.isValid(''),
            'isValid should reject blank input');
        System.Assert.isFalse(FieldPathManager.isValid(null),
            'isValid should reject null input');
    }
    
}