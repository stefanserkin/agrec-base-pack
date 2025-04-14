@IsTest
private class Util_Test {
    
    /***************************************************
     * Test receiving namespace
     * Use local class prefix to get namespace at runtime
     ***************************************************/
    @IsTest
    static void testGetNamespace() {
        String className = Util.class.getName();
        String expectedResult = className.contains('.') ? className.substringBefore('.') : '';

        Test.startTest();
        String result = Util.getNamespace();
        Test.stopTest();

        System.Assert.areEqual(expectedResult, result, 'Received unexpected namespace');
    }

    @IsTest
    static void testPrefixNamespace() {
        String localClass = Util.class.getName();
        Boolean hasNamespace = localClass.contains('.');

        String fieldName = 'My_Custom_Field__c';
        String className = 'MyCustomClass';

        Test.startTest();
        String fieldResult = Util.prefixNamespace(fieldName);
        String classResult = Util.prefixClassNamespace(className);
        Test.stopTest();

        String expectedFieldResult = hasNamespace ? className.substringBefore('.') + '__' + fieldName : fieldName;
        String expectedClassResult = hasNamespace ? className.substringBefore('.') + '.' + className : className;

        System.Assert.areEqual(expectedFieldResult, fieldResult, 'Received unexpected namespace for field name');
        System.Assert.areEqual(expectedClassResult, classResult, 'Received unexpected namespace for class name');
    }

    /***************************************************
     * Test utility method that should tell us whether or not
     *   email deliverability is active in the org
     ***************************************************/
    @IsTest
    static void testIsOrgEmailEnabled() {
        Boolean expectedResult = true;
        Boolean result;
        try {
            Messaging.reserveSingleEmailCapacity(1);
            Messaging.reserveMassEmailCapacity(1);
        } catch (System.NoAccessException e) {
            expectedResult = false;
        }

        Test.startTest();
        result = Util.isOrgEmailEnabled();
        Test.stopTest();

        System.Assert.areEqual(expectedResult, result, 'Received unexpected deliverability status');
    }

}