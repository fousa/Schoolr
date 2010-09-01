//
//  CommentController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 01/09/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"
#import "ClassViewController.h"

#import "School.h"
#import "SchoolClass.h"

@class RootViewController;
@class ClassViewController;

@interface CommentController : UIViewController

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) IBOutlet UITextView *commentField;

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) SchoolClass *schoolClass;

@end
