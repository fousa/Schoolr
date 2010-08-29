//
//  SchoolFormController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

@interface SchoolFormController : UIViewController

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *numberField;

@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;

@end
