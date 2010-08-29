//
//  ClassViewController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "RootViewController.h"
#import "SchoolClass.h"
#import "School.h"
#import "JAVBinarySearchAdditions.h"

#import "DetailViewController.h"

@interface ClassViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
	School *school;
	NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	
	DetailViewController *detailViewController;
	
	NSMutableArray *classes;
}

@property (nonatomic, retain) RootViewController *rootViewController;
@property (nonatomic, retain) DetailViewController *detailViewController;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)setSchool:(School *)mySchool;

- (BOOL)insertClassWithName:(NSString *)name;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
