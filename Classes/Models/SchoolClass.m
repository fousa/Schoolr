//
//  SchoolClass.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "SchoolClass.h"

@implementation SchoolClass

@dynamic name;
@dynamic studentCount;
@dynamic teacherCount;
@dynamic comment;
@dynamic realStudentCount;

- (NSComparisonResult)compare:(SchoolClass *)myClass {
    return [self.name compare:myClass.name];
}

- (BOOL)empty {
	return self.comment == nil || [self.comment length] == 0;
}

@end
