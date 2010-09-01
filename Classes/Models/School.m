//
//  School.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "School.h"

@implementation School

@dynamic name;
@dynamic number;
@dynamic contractNumber;
@dynamic classes;
@dynamic bothersSistersCount;

- (int)totalStudents {
	int total = 0;
	for (SchoolClass *schoolClass in self.classes) {
		total += [schoolClass.studentCount intValue];
	}
	return total;
}

- (int)totalTeachers {
	int total = 0;
	for (SchoolClass *schoolClass in self.classes) {
		total += [schoolClass.teacherCount intValue];
	}
	return total;
}

@end
