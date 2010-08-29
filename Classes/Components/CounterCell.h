//
//  CounterCell.h
//  SchoolsPics
//
//  Created by Jelle Vandebeeck on 26/08/10.
//  Copyright 2010 10to1. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InfoView.h"

@interface CounterCell : UIView {
	int count;
}

@property (nonatomic) int count;
@property (nonatomic, retain) NSString *singleText;
@property (nonatomic, retain) NSString *multipleText;
@property (nonatomic) SEL selector;
@property (nonatomic, retain) IBOutlet id delegate;

@end
