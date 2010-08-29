    //
//  SchoolFormController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "SchoolFormController.h"

@implementation SchoolFormController

#pragma mark -
#pragma mark Button actions

- (IBAction)save:(id)sender {
	if ([self.rootViewController insertSchoolWithName:self.nameField.text andNumber:self.numberField.text]) {
		[self dismissModalViewControllerAnimated:YES];
	} 
}

- (IBAction)cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark View setup

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
