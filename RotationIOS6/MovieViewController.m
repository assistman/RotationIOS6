//
//  MovieViewController.m
//  RotationIOS6
//
//  Created by Stas on 3/11/13.
//  Copyright (c) 2013 Videal. All rights reserved.
//

#import "MovieViewController.h"

@implementation MovieViewController


- (BOOL)shouldAutorotate {
    NSLog(@"shouldAutorotate called");
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    NSLog(@"supported called in movie");
    return UIInterfaceOrientationMaskPortrait;
}

//This runs the view in landscape mode but the above two methods allow rotation
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    NSLog(@"preferred called in movie");
    return UIInterfaceOrientationPortrait;
}

@end
