/***********************************************************************
 * @license
 * MIT License
 * Copyright (c) 2025 Asphalt Green, Inc.
 * See the LICENSE file in the project root for full license text.
 * 
 * @description
 * Common LWC utilities
 * 
 * @date 2025
 * @author
 * Asphalt Green Data and Information Systems
 ***********************************************************************/
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export function showToast(component, title, message, variant = 'info') {
    component.dispatchEvent(
        new ShowToastEvent({
            title,
            message,
            variant
        })
    );
}

export function handleError(component, error, fallbackTitle = 'Something went wrong') {
    let message = 'Unknown error';

    if (Array.isArray(error?.body)) {
        message = error.body.map(e => e.message).join(', ');
    } else if (typeof error?.body?.message === 'string') {
        message = error.body.message;
    } else if (error?.message) {
        message = error.message;
    } else if (typeof error === 'string') {
        message = error;
    }

    showToast(component, fallbackTitle, message, 'error');
}
