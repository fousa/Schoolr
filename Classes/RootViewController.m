//
//  RootViewController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 10to1 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController (Menu)
- (void)configureCell:(SchoolCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

#pragma mark -
#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated {
	self.classActive = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Schools";
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:.067 green:.110 blue:.145 alpha:1.0];
	self.navigationController.delegate = self;
	
	self.classActive = NO;
	
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	managedObjectContext = [(SchoolsPicsAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An error occured!" message:@"There was a problem loading the schools from the database." delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
		[alert show];
		[alert release];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	if ([viewController class] == [self class]) {
		if (self.currentSchool != nil) {
			[detailViewController setSchoolItem:self.currentSchool];
		}
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)configureCell:(SchoolCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    School *schoolObject = (School *)[fetchedResultsController objectAtIndexPath:indexPath];
    
	NSString *number = [NSString stringWithFormat:@"%@ / %@", schoolObject.number, schoolObject.contractNumber];
	
	[cell setName:schoolObject.name andNumber:number];
}

#pragma mark -
#pragma mark Add a new object

- (BOOL)insertSchoolWithName:(NSString *)name andNumber:(NSString *)number andContractNumber:(NSString *)contractNumber {
    NSIndexPath *currentSelection = [self.tableView indexPathForSelectedRow];
    if (currentSelection != nil) {
        [self.tableView deselectRowAtIndexPath:currentSelection animated:NO];
    }    
    
    NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
    NSEntityDescription *school = [[fetchedResultsController fetchRequest] entity];
    School *schoolObject = (School *)[NSEntityDescription insertNewObjectForEntityForName:[school name] inManagedObjectContext:context];
    
    schoolObject.name = name;
	schoolObject.number = number;
	schoolObject.contractNumber = contractNumber;
    
    NSError *error = nil;
    if ([context save:&error]) {
		NSIndexPath *insertionPath = [fetchedResultsController indexPathForObject:schoolObject];
		[self.tableView selectRowAtIndexPath:insertionPath animated:YES scrollPosition:UITableViewScrollPositionNone];
		[detailViewController setSchoolItem:schoolObject];
		
		return YES;
    } else {
		return NO;
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SchoolCell *cell = (SchoolCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object.
        School *objectToDelete = (School *)[fetchedResultsController objectAtIndexPath:indexPath];
        
        NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
        [context deleteObject:objectToDelete];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	self.currentSchool = (School *)[[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	ClassViewController *classViewController = [[ClassViewController alloc] initWithNibName:@"ClassViewController" bundle:[NSBundle mainBundle]];
	[classViewController setSchool:self.currentSchool];
	classViewController.rootViewController = self;
	detailViewController.classViewController = classViewController;
	[detailViewController setSchoolItem:self.currentSchool];
	classViewController.detailViewController = detailViewController;
	
	[self.navigationController pushViewController:classViewController animated:YES];
    //detailViewController.detailItem = selectedObject;    
	
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *school = [NSEntityDescription entityForName:@"School" inManagedObjectContext:self.managedObjectContext];
	[fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"classes"]];
    [fetchRequest setEntity:school];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
	NSSortDescriptor *numberSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"number" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:numberSortDescriptor, nameSortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.fetchedResultsController.delegate = self;
    
    [fetchRequest release];
    [nameSortDescriptor release];
	[numberSortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}    

#pragma mark -
#pragma mark Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(SchoolCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)dealloc {
    [detailViewController release];
    [fetchedResultsController release];
    [managedObjectContext release];
    
    [super dealloc];
}

@end
