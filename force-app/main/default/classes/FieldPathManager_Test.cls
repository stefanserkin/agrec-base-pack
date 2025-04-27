@IsTest
private class FieldPathManager_Test {
    
    @IsTest
    static void testNormalize() {
        System.assertEquals('trex1__contact__r.name', FieldPathManager.normalize('  TREX1__Contact__r.Name '),
            'normalize should trim and lowercase input');
        System.assertEquals('', FieldPathManager.normalize(null),
            'normalize should return empty string for null input');
        System.assertEquals('', FieldPathManager.normalize('   '),
            'normalize should return empty string for blank input');
    }

    @IsTest
    static void testIsValid() {
        System.assertEquals(true, FieldPathManager.isValid('trex1__contact__r.name'),
            'isValid should accept normal field paths with underscores and dots');
        System.assertEquals(true, FieldPathManager.isValid('name'),
            'isValid should accept simple field paths');

        System.assertEquals(false, FieldPathManager.isValid('trex1__contact__r.name '),
            'isValid should reject field paths with spaces');
        System.assertEquals(false, FieldPathManager.isValid('trex1__contact__r.{name}'),
            'isValid should reject field paths with invalid characters');
        System.assertEquals(false, FieldPathManager.isValid(''),
            'isValid should reject blank input');
        System.assertEquals(false, FieldPathManager.isValid(null),
            'isValid should reject null input');
    }
    
}