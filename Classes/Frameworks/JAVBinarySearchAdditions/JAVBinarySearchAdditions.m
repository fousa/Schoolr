//
//  JAVBinarySearchAdditions.m
//
//  Created by JAV on Sat Jan 29 2005.
//  Copyright (c) 2005 John A. Vink. All rights reserved.
//

#import "JAVBinarySearchAdditions.h"


@implementation NSMutableArray (JAVBinarySearchAdditions)

- (unsigned) indexOfObject:(id)object whenAddingToArraySortedBy:(SEL)compareSelector {
	int numElements = [self count];
	
	// if there are no objects in this array, we can just
	// add this item
	if (numElements == 0)
	{
		return 0;
	}
	
	// we need to find out where in the array we need to add this item.
	// So, we do a binary search.
	
	// searchRange is the range of items that we need to search.  We initialize it
	// to cover all the items in the array.
	NSRange searchRange = NSMakeRange(0, numElements);
	
	// when the length of our range hits zero, we've found where we need to
	// insert this item. 
	while(searchRange.length > 0)
	{
		// checkIndex in the index of the item in the array that we're going to compare with
		// to find out if the new item needs to be added before or after.  checkIndex is set
		// to be the middle of the search range.
		unsigned int checkIndex = searchRange.location + (searchRange.length / 2);
		
		// checkObject is the object at checkIndex
		id checkObject = [self objectAtIndex:checkIndex];
		
		// we call compare: on the checkObject, passing it the item we want to add.
		NSComparisonResult order = (NSComparisonResult) [checkObject performSelector:compareSelector withObject:object];
		
		switch (order)
		{
			case NSOrderedAscending:
			{
				// the item we want to add to this array appears after the item we checked against.
				// Now, the search range starts with the item after the item we just checked, and ends
				// at the same place as the previous search range.
				
				// end point remains the same, start point moves to next element.
				unsigned int endPoint = searchRange.location + searchRange.length;
				searchRange.location = checkIndex + 1;
				searchRange.length = endPoint - searchRange.location;
				break;
			}
				
			case NSOrderedDescending:
			{
				// the item we want to add to this array appears before the item we checked against.
				// Now, the search range starts at the same place as the previous search range,
				// and ends with the item just before the item we just checked.
				
				// start point remains the same, end point moves to previous element
				searchRange.length = (checkIndex - 1) - searchRange.location + 1;
				break;
			}
				
			case NSOrderedSame:
			{
				NSLog(@"Object already exists in array");
				[[NSException exceptionWithName:@"ElementExists" reason:nil userInfo:nil] raise];
				break;
			}
				
			default:
			{
				// we should never get here.  Freak out if we do.  It means you wrote your compare: method wrong.
				assert(0);
				break;
			}
		}
	}
	
	return searchRange.location;
}

// -------------------------------------------------------------------------------------------
// * addObject:intoArraySortedBy:
// -------------------------------------------------------------------------------------------
- (void) addObject:(id)object intoArraySortedBy:(SEL)compareSelector
{
	int numElements = [self count];
	
	// if there are no objects in this array, we can just
	// add this item
	if (numElements == 0)
	{
		[self addObject:object];
		return;
	}
	
	// we need to find out where in the array we need to add this item.
	// So, we do a binary search.
	
	// searchRange is the range of items that we need to search.  We initialize it
	// to cover all the items in the array.
	NSRange searchRange = NSMakeRange(0, numElements);
	
	// when the length of our range hits zero, we've found where we need to
	// insert this item. 
	while(searchRange.length > 0)
	{
		// checkIndex in the index of the item in the array that we're going to compare with
		// to find out if the new item needs to be added before or after.  checkIndex is set
		// to be the middle of the search range.
		unsigned int checkIndex = searchRange.location + (searchRange.length / 2);

		// checkObject is the object at checkIndex
		id checkObject = [self objectAtIndex:checkIndex];

		// we call compare: on the checkObject, passing it the item we want to add.
		NSComparisonResult order = (NSComparisonResult) [checkObject performSelector:compareSelector withObject:object];
		
		switch (order)
		{
			case NSOrderedAscending:
			{
				// the item we want to add to this array appears after the item we checked against.
				// Now, the search range starts with the item after the item we just checked, and ends
				// at the same place as the previous search range.

				// end point remains the same, start point moves to next element.
				unsigned int endPoint = searchRange.location + searchRange.length;
				searchRange.location = checkIndex + 1;
				searchRange.length = endPoint - searchRange.location;
				break;
			}
				
			case NSOrderedDescending:
			{
				// the item we want to add to this array appears before the item we checked against.
				// Now, the search range starts at the same place as the previous search range,
				// and ends with the item just before the item we just checked.

				// start point remains the same, end point moves to previous element
				searchRange.length = (checkIndex - 1) - searchRange.location + 1;
				break;
			}
				
			case NSOrderedSame:
			{
				NSLog(@"Object already exists in array");
				[[NSException exceptionWithName:@"ElementExists" reason:nil userInfo:nil] raise];
				break;
			}
				
			default:
			{
				// we should never get here.  Freak out if we do.  It means you wrote your compare: method wrong.
				assert(0);
				break;
			}
		}
	}
	
	// now that we have found where in the array to add the item, add it.
	[self insertObject:object atIndex:searchRange.location];
}


// -------------------------------------------------------------------------------------------
// * indexOfObject:inArraySortedBy:
// -------------------------------------------------------------------------------------------
- (unsigned) indexOfObject:(id)object inArraySortedBy:(SEL)compareSelector;
{
	int numElements = [self count];
	// if there are no items in the array, we can just return NSNotFound
	if (numElements == 0)
		return NSNotFound;
		
	// searchRange is the range of items that we need to search.  We initialize it
	// to cover all the items in the array.
	NSRange searchRange = NSMakeRange(0, numElements);
	
	// when the length of our range hits zero, we've found the index of this item. 
	while(searchRange.length > 0)
	{
		// checkIndex in the index of the item in the array that we're going to compare with
		// to find out if the item we're looking for is located before or after.  checkIndex is set
		// to be the middle of the search range.
		unsigned int checkIndex = searchRange.location + (searchRange.length / 2);

		// checkObject is the object at checkIndex
		id checkObject = [self objectAtIndex:checkIndex];

		// we call compare: on the checkObject, passing it the item we're looking for.
		NSComparisonResult order = (NSComparisonResult) [checkObject performSelector:compareSelector withObject:object];
		
		switch (order)
		{
			case NSOrderedAscending:
			{
				// the item we're looking for appears after the item we checked against.
				// Now, the search range starts with the item after the item we just checked, and ends
				// at the same place as the previous search range.

				// end point remains the same, start point moves to next element.
				unsigned int endPoint = searchRange.location + searchRange.length;
				searchRange.location = checkIndex + 1;
				searchRange.length = endPoint - searchRange.location;
				break;
			}
				
			case NSOrderedDescending:
			{
				// the item we're looking for appears before the item we checked against.
				// Now, the search range starts at the same place as the previous search range,
				// and ends with the item just before the item we just checked.

				// start point remains the same, end point moves to previous element
				searchRange.length = (checkIndex - 1) - searchRange.location + 1;
				break;
			}
				
			case NSOrderedSame:
			{
				// we have found the item.  Return the index.
				return checkIndex;
				break;
			}
				
			default:
			{
				// we should never get here.  Freak out if we do.  It means you wrote your compare: method wrong.
				assert(0);
				break;
			}
		}
	}
	
	// If we reach here, we have not found the item.  Return NSNotFound.
	return NSNotFound;
}

@end

@implementation NSArray (JAVBinarySearchAdditions)

// -------------------------------------------------------------------------------------------
// * indexOfObject:inArraySortedBy:
// -------------------------------------------------------------------------------------------
- (unsigned) indexOfObject:(id)object inArraySortedBy:(SEL)compareSelector;
{
	int numElements = [self count];
	// if there are no items in the array, we can just return NSNotFound
	if (numElements == 0)
		return NSNotFound;
	
	// searchRange is the range of items that we need to search.  We initialize it
	// to cover all the items in the array.
	NSRange searchRange = NSMakeRange(0, numElements);
	
	// when the length of our range hits zero, we've found the index of this item. 
	while(searchRange.length > 0)
	{
		// checkIndex in the index of the item in the array that we're going to compare with
		// to find out if the item we're looking for is located before or after.  checkIndex is set
		// to be the middle of the search range.
		unsigned int checkIndex = searchRange.location + (searchRange.length / 2);
		
		// checkObject is the object at checkIndex
		id checkObject = [self objectAtIndex:checkIndex];
		
		// we call compare: on the checkObject, passing it the item we're looking for.
		NSComparisonResult order = (NSComparisonResult) [checkObject performSelector:compareSelector withObject:object];
		
		switch (order)
		{
			case NSOrderedAscending:
			{
				// the item we're looking for appears after the item we checked against.
				// Now, the search range starts with the item after the item we just checked, and ends
				// at the same place as the previous search range.
				
				// end point remains the same, start point moves to next element.
				unsigned int endPoint = searchRange.location + searchRange.length;
				searchRange.location = checkIndex + 1;
				searchRange.length = endPoint - searchRange.location;
				break;
			}
				
			case NSOrderedDescending:
			{
				// the item we're looking for appears before the item we checked against.
				// Now, the search range starts at the same place as the previous search range,
				// and ends with the item just before the item we just checked.
				
				// start point remains the same, end point moves to previous element
				searchRange.length = (checkIndex - 1) - searchRange.location + 1;
				break;
			}
				
			case NSOrderedSame:
			{
				// we have found the item.  Return the index.
				return checkIndex;
				break;
			}
				
			default:
			{
				// we should never get here.  Freak out if we do.  It means you wrote your compare: method wrong.
				assert(0);
				break;
			}
		}
	}
	
	// If we reach here, we have not found the item.  Return NSNotFound.
	return NSNotFound;
}

@end
