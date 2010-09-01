//
//  CommentController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 01/09/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "CommentController.h"

@implementation CommentController

- (void)viewDidLoad {
	if (self.schoolClass == nil) {
		self.commentField.text = self.school.comment;
	} else {
		self.commentField.text = self.schoolClass.comment;
	}
	
	[self.commentField becomeFirstResponder];
}

#pragma mark -
#pragma mark Button actions

- (IBAction)save:(id)sender {
	[self.delegate performSelector:@selector(insertComment:) withObject:self.commentField.text];
	[self dismissModalViewControllerAnimated:YES];
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
