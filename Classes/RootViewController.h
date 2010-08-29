//
//  RootViewController.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 10to1 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "SchoolsPicsAppDelegate.h"
#import "SchoolCell.h"
#import "ClassViewController.h"
#import "School.h"

@class DetailViewController;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    
    DetailViewController *detailViewController;
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) School *currentSchool;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic) BOOL classActive;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (BOOL)insertSchoolWithName:(NSString *)name andNumber:(NSString *)number;

@end
