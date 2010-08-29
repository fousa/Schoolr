//
//  SchoolCell.m
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 28/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import "SchoolCell.h"

@interface SchoolCell () {
	UILabel *nameLabel;
	UILabel *numberLabel;
}
@end

@implementation SchoolCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
		nameLabel.font = [UIFont boldSystemFontOfSize:24.0f];
		[self addSubview:nameLabel];
		
		numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 27, 300, 20)];
		numberLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		numberLabel.textColor = [UIColor grayColor];
		[self addSubview:numberLabel];
    }
    return self;
}

- (void)setName:(NSString *)myName {
	nameLabel.text = myName;
}

- (void)setNumber:(NSString *)myNumber {
	numberLabel.text = myNumber;
}

@end
