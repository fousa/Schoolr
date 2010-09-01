//
//  SchoolCell.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "SchoolCell.h"

@interface SchoolCell () {
	NSString *name;
	NSString *number;
}
@end

@implementation SchoolCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        //nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
		//nameLabel.font = [UIFont boldSystemFontOfSize:24.0f];
		//[self addSubview:nameLabel];
		
		//numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 27, 300, 20)];
		//numberLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		//numberLabel.textColor = [UIColor grayColor];
		//[self addSubview:numberLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rectangle {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *backgroundImage = [UIImage imageNamed:@"cell-background.png"];
	
	UIColor *backgroundColor = [UIColor whiteColor];
	UIColor *titleColor = [UIColor blackColor];
	UIColor *authorsColor = [UIColor grayColor];
	UIFont *titleFont = [UIFont boldSystemFontOfSize:20];
	UIFont *authorsFont = [UIFont systemFontOfSize:14];
	
//	if (self.selected) {
//		backgroundColor = [UIColor clearColor];
//		titleColor = [UIColor whiteColor];
//		authorsColor = [UIColor whiteColor]; 
//		backgroundImage = nil;
//	}
	CGPoint point = CGPointMake(1, 2);
	
	if ([self viewWithTag:999]) {
		[[self viewWithTag:999] removeFromSuperview];
	}
		
	// Set background
	[backgroundColor set];
	CGContextFillRect(context, rectangle);

	[backgroundImage drawInRect:CGRectMake(point.x, point.y + 49, 320, 10)];

	// Draw title
	[titleColor set];
	point.x += 7;
	point.y += 7;
	CGSize size = [name drawAtPoint:point forWidth:230 withFont:titleFont lineBreakMode:UILineBreakModeTailTruncation];
	
	[authorsColor set];
	point.y += size.height;
	[number drawAtPoint:point forWidth:229 withFont:authorsFont lineBreakMode:UILineBreakModeTailTruncation];
}

- (void)setName:(NSString *)myName andNumber:(NSString *)myNumber {
	name = myName;
	number = [myNumber retain];
	[self setNeedsDisplay]; 
}

@end
