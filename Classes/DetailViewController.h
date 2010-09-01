//
//  DetailViewController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 10to1 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MessageUI/MessageUI.h>

#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"

#import "SchoolFormController.h"
#import "ClassFormController.h"
#import "CounterCell.h"
#import "InfoView.h"

#import "School.h"
#import "SchoolClass.h"

@class RootViewController, ClassViewController, CounterCell;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
    
    UIPopoverController *popoverController;
    UIToolbar *toolbar;

    RootViewController *rootViewController;
	
	NSManagedObjectContext *managedObjectContext;
	
	School *school;
	SchoolClass *schoolClass;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *emailButtonItem;

@property (nonatomic, retain) IBOutlet UIView *changeableView;

@property (nonatomic, retain) IBOutlet UIView *schoolView;
@property (nonatomic, retain) IBOutlet InfoView *classCountLabel;
@property (nonatomic, retain) IBOutlet CounterCell *counterField;
@property (nonatomic, retain) IBOutlet InfoView *teacherCountLabel;
@property (nonatomic, retain) IBOutlet InfoView *studentCountLabel;

@property (nonatomic, retain) IBOutlet UIView *classView;
@property (nonatomic, retain) IBOutlet CounterCell *brothersCounterField;
@property (nonatomic, retain) IBOutlet CounterCell *studentCounterField;
@property (nonatomic, retain) IBOutlet CounterCell *teacherCounterField;

@property (nonatomic, retain) ClassViewController *classViewController;
@property (nonatomic, assign) RootViewController *rootViewController;

- (IBAction)showSchoolForm:(id)sender;
- (IBAction)schowEmailForm:(id)sender;

- (void)setSchoolItem:(School *)mySchool;
- (void)setClassItem:(SchoolClass *)mySchoolClass;

- (void)setBrotherSisterCount:(NSNumber *)count;
- (void)setStudentCount:(NSNumber *)count;
- (void)setTeacherCount:(NSNumber *)count;

@end
