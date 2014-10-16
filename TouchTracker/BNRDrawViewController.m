//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by Kevin Candelaria on 10/16/14.
//  Copyright (c) 2014 Kevin Candelaria. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView
{
    self.view = [[BNRDrawView alloc] initWithFrame:CGRectZero];
}

@end
