//
//  RKAlert.m
//  RestKit
//
//  Created by Blake Watters on 4/10/11.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h>
#endif

#import "RKAlert.h"
#import "RKLog.h"

void RKAlert(NSString *message) {
    RKAlertWithTitleAndController(message, @"Alert", nil);
}

void RKAlertWithTitle(NSString *message, NSString *title) {
    RKAlertWithTitleAndController(message, title, nil);
}

void RKAlertWithTitleAndController(NSString *message, NSString *title, UIViewController *presentingController) {    
#if TARGET_OS_IPHONE
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    if (presentingController) {
        [presentingController presentViewController:alert animated:YES completion:nil];
    } else {
        RKLogCritical(@"%@: %@", title, message);
    }
    [alert release];
#elif TARGET_OS_MAC
    Class alertClass = NSClassFromString(@"NSAlert");
    if (alertClass) {
        NSAlert *alert = [[alertClass alloc] init];
        [alert setMessageText:message];
         [alert setInformativeText:message];
        [alert addButtonWithTitle:NSLocalizedString(@"OK", nil)];
        [alert runModal];
        [alert release];
    } else {
        RKLogCritical(@"%@: %@", title, message);
    }
#elif TARGET_OS_UNIX
    RKLogCritical(@"%@: %@", title, message);
#endif
}
