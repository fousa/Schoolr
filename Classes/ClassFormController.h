//
//  ClassFormController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClassViewController.h"

@class ClassViewController;

@interface ClassFormController : UIViewController {
	
}

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *studentCountField;

@property (nonatomic, retain) IBOutlet ClassViewController *classViewController;

@end
