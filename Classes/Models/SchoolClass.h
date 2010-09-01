//
//  SchoolClass.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <CoreData/CoreData.h>

@class School;

@interface SchoolClass : NSManagedObject

- (BOOL)empty;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) School *school;
@property (nonatomic, retain) NSNumber *teacherCount;
@property (nonatomic, retain) NSNumber *studentCount;
@property (nonatomic, retain) NSString *realStudentCount;

@end
