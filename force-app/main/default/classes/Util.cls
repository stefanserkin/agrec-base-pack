/*
 * MIT License
 * Copyright (c) 2024 Asphalt Green, Inc.
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
@NamespaceAccessible
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

    @NamespaceAccessible
    public static String getNamespace() {
        String className = Util.class.getName();
        return className.contains('.') ? className.substringBefore('.') : '';
    }

    @NamespaceAccessible
    public static String prefixNamespace(String value) {
        return String.isBlank(namespace) ? value : namespace + '__' + value;
    }

    @NamespaceAccessible
    public static String prefixClassNamespace(String className) {
        return String.isBlank(namespace) ? className : namespace + '.' + className;
    }

    @NamespaceAccessible
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