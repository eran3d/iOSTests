//
//  ViewController.m
//  AnimationTest
//
//  Created by Eran Jalink on 26/01/15.
//  Copyright (c) 2015 eranjalink. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init {
    if (self) {
        View *view = [[View alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        self.view = (UIView *)view;
        
    }
    return self;
}

@end
