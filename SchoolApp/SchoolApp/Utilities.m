//
//  Utilities.m
//  SchoolApp
//
//  Created by Mohsin Khawas on 10/13/19.
//  Copyright © 2019 Mohsin Khawas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utilities.h"
@implementation Utilities

+ (UIAlertController *)getAlertController:(NSString *)message{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                        message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    
    indicator.hidesWhenStopped = YES;
    [indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    [indicator startAnimating];
    [[alert view] addSubview: indicator];
    
    return alert;
}
@end
