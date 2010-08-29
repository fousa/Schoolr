//
//  CounterCell.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "CounterCell.h"

@interface CounterCell () {
	UILabel *countLabel;
	UIButton *addButton;
	UIButton *deleteButton;
}
@end

@interface CounterCell (ButtonActions)
- (void)increaseCounter;
- (void)decreaseCounter;
@end

@implementation CounterCell

- (void)awakeFromNib {
	countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290.0f, 68.0f)];
	countLabel.backgroundColor = [UIColor clearColor];
	countLabel.font = [UIFont fontWithName:@"AppleGothic" size:25.0f];
	countLabel.textAlignment = UITextAlignmentRight;
	[self addSubview:countLabel];
	
	addButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[addButton setTitle:@"+" forState:UIControlStateNormal];
	addButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:50.0f];
	addButton.backgroundColor = [UIColor greenColor];
	addButton.frame = CGRectMake(300.0f, 0, 80.0f, 68.0f);
	[addButton addTarget:self action:@selector(increaseCounter) forControlEvents:UIControlEventTouchDown];
	[self addSubview:addButton];
	
	deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton setTitle:@"-" forState:UIControlStateNormal];
	deleteButton.titleLabel.font = [UIFont fontWithName:@"AppleGothic" size:50.0f];
	deleteButton.backgroundColor = [UIColor redColor];
	deleteButton.frame = CGRectMake(380.0f, 0, 80.0f, 68.0f);
	[deleteButton addTarget:self action:@selector(decreaseCounter) forControlEvents:UIControlEventTouchDown];
	[self addSubview:deleteButton];
}

- (void)setCount:(int)myCount {
	count = myCount;
	
	countLabel.text = [NSString stringWithFormat:@"%i %@", count, self.text];
	[self.delegate performSelector:self.selector withObject:[NSNumber numberWithInt:count]];
}

- (void)increaseCounter {
	[self setCount:count+1];
}

- (void)decreaseCounter {
	if (count > 0) {
		[self setCount:count-1];
	}
}

//- (void)drawRect:(CGRect)rect {
//	CGContextRef context = UIGraphicsGetCurrentContext();
//	
//	CGContextBeginTransparencyLayer(context, NULL);
//	
//    CGContextSetLineWidth(context, 1.0);
//    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.270 green:0.270 blue:0.270 alpha:0.6] CGColor]);
//    
//    CGRect rrect = self.bounds;
//    
//    CGFloat radius = 15.0;
//    CGFloat width = CGRectGetWidth(rrect);
//    CGFloat height = CGRectGetHeight(rrect);
//    
//    // Make sure corner radius isn't larger than half the shorter side
//    if (radius > width/2.0)
//        radius = width/2.0;
//    if (radius > height/2.0)
//        radius = height/2.0;    
//    
//    CGFloat minx = CGRectGetMinX(rrect);
//    CGFloat midx = CGRectGetMidX(rrect);
//    CGFloat maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect);
//    CGFloat midy = CGRectGetMidY(rrect);
//    CGFloat maxy = CGRectGetMaxY(rrect);
//    CGContextMoveToPoint(context, minx, midy);
//    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
//	
//	CGContextEndTransparencyLayer(context);
//}

@end
