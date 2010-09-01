//
//  CounterCell.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "CounterCell.h"

@interface CounterCell () {
	InfoView *countLabel;
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
	self.backgroundColor = [UIColor clearColor];
	
	countLabel = [[InfoView alloc] initWithFrame:CGRectMake(0, 0, 370.0f, 100.0f)];
	[self addSubview:countLabel];
	
	addButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[addButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
	[addButton setImage:[UIImage imageNamed:@"add-pressed.png"] forState:UIControlStateHighlighted];
	addButton.backgroundColor = [UIColor clearColor];
	addButton.showsTouchWhenHighlighted = YES;
	addButton.frame = CGRectMake(400.0f, 0, 100.0f, 100.0f);
	[addButton addTarget:self action:@selector(increaseCounter) forControlEvents:UIControlEventTouchDown];
	[self addSubview:addButton];
	
	deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[deleteButton setImage:[UIImage imageNamed:@"remove.png"] forState:UIControlStateNormal];
	[deleteButton setImage:[UIImage imageNamed:@"remove-pressed.png"] forState:UIControlStateHighlighted];
	deleteButton.showsTouchWhenHighlighted = YES;
	deleteButton.frame = CGRectMake(510.0f, 0, 100.0f, 100.0f);
	[deleteButton addTarget:self action:@selector(decreaseCounter) forControlEvents:UIControlEventTouchDown];
	[self addSubview:deleteButton];
}

- (void)setCount:(int)myCount {
	count = myCount;
	
	[countLabel setCount:count withText:(count == 1 ? self.singleText : self.multipleText)];
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

@end
