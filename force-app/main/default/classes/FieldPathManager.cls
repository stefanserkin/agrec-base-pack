/***********************************************************************
 * @license
 * MIT License
 * Copyright (c) 2025 Asphalt Green, Inc.
 * See the LICENSE file in the project root for full license text.
 * 
 * @description Utilities for handling field paths in fields to merge
 * 
 * @date 2025
 * @author 
 * Asphalt Green Data and Information Systems
 ***********************************************************************/
@NamespaceAccessible
public with sharing class FieldPathManager {
    
    private static final Pattern VALID_FIELD_PATH_PATTERN = Pattern.compile('^[a-zA-Z0-9_.]+$');

    /**
     * Normalize a field path string for consistency.
     * Lowercases and trims whitespace.
     */
    @NamespaceAccessible
    public static String normalize(String fieldPath) {
        return String.isBlank(fieldPath) ? '' : fieldPath.trim().toLowerCase();
    }

    /**
     * Validate that a normalized field path contains only allowed characters.
     * Letters, numbers, underscores, and dots are allowed.
     */
    @NamespaceAccessible
    public static Boolean isValid(String fieldPath) {
        if (String.isBlank(fieldPath)) {
            return false;
        }
        Matcher m = VALID_FIELD_PATH_PATTERN.matcher(fieldPath);
        return m.matches();
    }

}