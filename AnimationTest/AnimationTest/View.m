//
//  View.m
//  AnimationTest
//
//  Created by Eran Jalink on 26/01/15.
//  Copyright (c) 2015 eranjalink. All rights reserved.
//

#import "View.h"

@implementation View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}


- (void)buildView {
    [self setBackgroundColor:[UIColor blueColor]];
}

@end
