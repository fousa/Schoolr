//
//  ClassViewController.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "ClassViewController.h"
#import "RootViewController.h"

@implementation ClassViewController

- (void)viewWillAppear:(BOOL)animated {
	self.rootViewController.classActive = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Classes";
	
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	
	managedObjectContext = [(SchoolsPicsAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
}

- (void)setSchool:(School *)mySchool {
	school = [mySchool retain];
	
	classes = [[NSMutableArray arrayWithArray:[[[school mutableSetValueForKey:@"classes"] allObjects] sortedArrayUsingSelector:@selector(compare:)]] retain];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [classes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    SchoolCell *cell = (SchoolCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SchoolCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)insertClassWithName:(NSString *)name andStudentCount:(NSString *)studentCount {
    NSIndexPath *currentSelection = [self.tableView indexPathForSelectedRow];
	if (currentSelection != nil) {
		[self.tableView deselectRowAtIndexPath:currentSelection animated:NO];
	}    

	NSManagedObjectContext *context = managedObjectContext;
	SchoolClass *classObject = (SchoolClass *)[NSEntityDescription insertNewObjectForEntityForName:@"Class" inManagedObjectContext:context];
	   
	classObject.name = name;
	classObject.school = school;
	classObject.realStudentCount = studentCount;
	
	[[school mutableSetValueForKey:@"classes"] addObject:classObject];
	   
	NSError *error = nil;
	if ([context save:&error]) {
		[detailViewController setSchoolItem:school];
		
		unsigned indexOfObject = [classes indexOfObject:classObject inArraySortedBy:@selector(compare:)];
		if ([classes count] == 0 || indexOfObject >= [classes count]) {
			unsigned insertIndex = [classes indexOfObject:classObject whenAddingToArraySortedBy:@selector(compare:)];
			[classes addObject:classObject intoArraySortedBy:@selector(compare:)];
			[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:insertIndex inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
		}

		return YES;
	} else {
		NSLog(@"error: %@", [error description]);
		return NO;
	}
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the managed object.
        SchoolClass *objectToDelete = (SchoolClass *)[classes objectAtIndex:indexPath.row];
        
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:objectToDelete];
        
        NSError *error;
        if ([context save:&error]) {
			unsigned indexOfObject = [classes indexOfObject:objectToDelete];
			[classes removeObject:objectToDelete];
			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexOfObject inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
		} else {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SchoolClass *class = (SchoolClass *)[classes objectAtIndex:indexPath.row];
	
	detailViewController.classViewController = self;
	[self.detailViewController setClassItem:class];
	
	//[self.navigationController pushViewController:classViewController animated:YES];
    //detailViewController.detailItem = selectedObject;    
	
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)configureCell:(SchoolCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    SchoolClass *managedObject = (SchoolClass *)[classes objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryNone;
	[cell setName:managedObject.name andNumber:[NSString stringWithFormat:@"%@ Students", managedObject.realStudentCount]];
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *classDescription = [NSEntityDescription entityForName:@"Class" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:classDescription];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameSortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Roots"];
    self.fetchedResultsController.delegate = self;
    
    [fetchRequest release];
    [nameSortDescriptor release];
    [sortDescriptors release];
    
    return fetchedResultsController;
}

@end

