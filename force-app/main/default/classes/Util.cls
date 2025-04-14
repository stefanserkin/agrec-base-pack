public inherited sharing class Util {

    private static String namespace {
        get {
            if (namespace == null) {
                namespace = getNamespace();
            }
            return namespace;
        }
        set;
    }

    public static String getNamespace() {
        String className = Util.class.getName();
        return className.contains('.') ? className.substringBefore('.') : '';
    }

    public static String prefixNamespace(String value) {
        return String.isBlank(namespace) ? value : namespace + '__' + value;
    }

    public static String prefixClassNamespace(String className) {
        return String.isBlank(namespace) ? className : namespace + '.' + className;
    }

    public static Boolean isOrgEmailEnabled() {
        Boolean emailDeliverabilityEnabled = true;
        try {
            Messaging.reserveSingleEmailCapacity(1);
            Messaging.reserveMassEmailCapacity(1);
        } catch (System.NoAccessException e) {
            emailDeliverabilityEnabled = false;
        }
        return emailDeliverabilityEnabled;
    }
    
}