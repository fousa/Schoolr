//
//  ClassFormController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "ClassFormController.h"

@implementation ClassFormController

#pragma mark -
#pragma mark Button actions

- (IBAction)save:(id)sender {
	if ([self.classViewController insertClassWithName:self.nameField.text]) {
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
