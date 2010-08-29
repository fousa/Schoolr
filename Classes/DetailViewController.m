//
//  DetailViewController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 10to1 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureSchoolView;
- (void)configureClassView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
	managedObjectContext = [(SchoolsPicsAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
}

#pragma mark -
#pragma mark Object insertion

- (IBAction)showSchoolForm:(id)sender {
	if (rootViewController.classActive) {
		ClassFormController *classFormController = [[ClassFormController alloc] initWithNibName:@"ClassForm" bundle:[NSBundle mainBundle]];
		classFormController.modalPresentationStyle = UIModalPresentationFormSheet;
		classFormController.classViewController = self.classViewController;
		[self presentModalViewController:classFormController animated:YES];
	} else {
		SchoolFormController *schoolFormController = [[SchoolFormController alloc] initWithNibName:@"SchoolForm" bundle:[NSBundle mainBundle]];
		schoolFormController.modalPresentationStyle = UIModalPresentationFormSheet;
		[self presentModalViewController:schoolFormController animated:YES];
	}
}

- (IBAction)schowEmailForm:(id)sender {
	if (school != nil) {
		MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
		[mailController setSubject:[NSString stringWithFormat:@"Pictures for %@ (%@)", school.name, school.number]];
		
		MGTemplateEngine *mailEngine = [MGTemplateEngine templateEngine];
		[mailEngine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:mailEngine]];
		NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"mail" ofType:@"html"];
		NSMutableDictionary *variables = [NSMutableDictionary dictionary];
		[variables setObject:school forKey:@"school"];
		[variables setObject:[NSNumber numberWithInt:[school.classes count]] forKey:@"totalClasses"];
		[variables setObject:[NSNumber numberWithInt:[school totalTeachers]] forKey:@"totalTeachers"];
		[variables setObject:[NSNumber numberWithInt:[school totalStudents]] forKey:@"totalStudents"];
		[variables setObject:school.bothersSistersCount forKey:@"totalBrothersAndSisters"];
		[variables setObject:school.classes forKey:@"classes"];
		NSString *html = [mailEngine processTemplateInFileAtPath:templatePath withVariables:variables];
		[mailController setMessageBody:html isHTML:YES];
		
		mailController.modalPresentationStyle = UIModalPresentationFormSheet;
		[self presentModalViewController:mailController animated:YES];
		[mailController release];
	}
}

#pragma mark -
#pragma mark Managing the detail item

- (void)setSchoolItem:(School *)mySchool {
	[school release];
	school = [mySchool retain];
		
	[self configureSchoolView];
}

- (void)setClassItem:(SchoolClass *)mySchoolClass {
    
	[schoolClass release];
	schoolClass = [mySchoolClass retain];
		
	[self configureClassView];
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }		
}

- (void)configureSchoolView {
    self.titleLabel.text = school.name;
	
	self.counterField.selector = @selector(setBrotherSisterCount:);
	self.counterField.text = @"Brothers & Sisters";
	self.counterField.count = [school.bothersSistersCount intValue];
	self.studentCountLabel.text = [NSString stringWithFormat:@"%i", [school totalStudents]];
	self.teacherCountLabel.text = [NSString stringWithFormat:@"%i", [school totalTeachers]];
	self.classCountLabel.text = [NSString stringWithFormat:@"%i", [school.classes count]];
	
	[self.changeableView addSubview:self.schoolView];
}

- (void)configureClassView {
    self.titleLabel.text = schoolClass.name;
	
	self.studentCounterField.selector = @selector(setStudentCount:);
	self.studentCounterField.text = @"Students";
	self.studentCounterField.count = [schoolClass.studentCount intValue];
	
	self.teacherCounterField.selector = @selector(setTeacherCount:);
	self.teacherCounterField.text = @"Teachers";
	self.teacherCounterField.count = [schoolClass.teacherCount intValue];
	
	[self.changeableView addSubview:self.classView];
}

- (void)setBrotherSisterCount:(NSNumber *)count {
	school.bothersSistersCount = count;
	
	NSError *error = nil;
	[managedObjectContext save:&error];
}

- (void)setStudentCount:(NSNumber *)count {
	schoolClass.studentCount = count;
	
	NSError *error = nil;
	[managedObjectContext save:&error];
}

- (void)setTeacherCount:(NSNumber *)count {
	schoolClass.teacherCount = count;
	
	NSError *error = nil;
	[managedObjectContext save:&error];
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    barButtonItem.title = @"Schools";
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    NSMutableArray *items = [[toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

#pragma mark -
#pragma mark Rotation support

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
	self.popoverController = nil;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {	
    [popoverController release];
    [toolbar release];
	
	[school release];
    
	[super dealloc];
}	

@end
