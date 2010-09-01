//
//  School.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "SchoolClass.h"

@class SchoolClass;

@interface School : NSManagedObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *number;
@property (nonatomic, retain) NSString *contractNumber;
@property (nonatomic, retain) NSSet *classes;
@property (nonatomic, retain) NSNumber *bothersSistersCount;

- (int)totalStudents;
- (int)totalTeachers;
@end

@interface School (SchoolClassMethods)
- (void)addSchoolClassObject:(SchoolClass *)value;
- (void)removeSchoolClassObject:(SchoolClass *)value;
@end