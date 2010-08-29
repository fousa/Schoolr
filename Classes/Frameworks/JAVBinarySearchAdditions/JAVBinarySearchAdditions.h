//
//  JAVBinarySearchAdditions.h
//
//  Created by JAV on Sat Jan 29 2005.
//  Copyright (c) 2005 John A. Vink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (JAVBinarySearchAdditions)

- (unsigned) indexOfObject:(id)object whenAddingToArraySortedBy:(SEL)compareSelector;
- (void) addObject:(id)object intoArraySortedBy:(SEL)compareSelector;
- (unsigned) indexOfObject:(id)object inArraySortedBy:(SEL)compareSelector;

@end

@interface NSArray (JAVBinarySearchAdditions)

- (unsigned) indexOfObject:(id)object inArraySortedBy:(SEL)compareSelector;

@end