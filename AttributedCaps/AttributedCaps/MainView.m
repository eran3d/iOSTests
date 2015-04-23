//
//  MainView.m
//  AttributedCaps
//
//  Created by Eran Jalink on 23/04/15.
//  Copyright (c) 2015 Eran Jalink. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    [self setBackgroundColor:[UIColor whiteColor]];
}

@end
