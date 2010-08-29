//
//  InfoView.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 29/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "InfoView.h"

@interface InfoView () {
	UILabel *label;
}
@end

@implementation InfoView

- (void)awakeFromNib {
	self.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:0.6];
	
	label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 550.0f, 100.0f)];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont fontWithName:@"AppleGothic" size:35.0f];
	label.textColor = [UIColor colorWithRed:.4 green:.4 blue:.4 alpha:0.6];
	label.textAlignment = UITextAlignmentCenter;
	[self addSubview:label];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:0.6];
		
		label = [[UILabel alloc] initWithFrame:frame];
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont fontWithName:@"AppleGothic" size:35.0f];
		label.textColor = [UIColor colorWithRed:.4 green:.4 blue:.4 alpha:0.6];
		label.textAlignment = UITextAlignmentCenter;
		[self addSubview:label];
	}
	return self;
}

- (void)setCount:(int)count withText:(NSString *)text {
	label.text = [NSString stringWithFormat:@"%i %@", count, text];
}

@end
