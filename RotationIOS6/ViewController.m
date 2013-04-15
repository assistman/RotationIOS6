//
//  ViewController.m
//  RotationIOS6
//
//  Created by Stas on 3/11/13.
//  Copyright (c) 2013 Videal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentAlert:(id)sender {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"Press \"End\" to terminate this session or \"Exit\" to close it, with the option to later resume it. By hitting the \"End\" button you will not be able to resume it." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"End", @"Exit", nil];
    
    [alert show];
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
        CGRect newFrame = CGRectMake(90, 10, 300, 300);
        [alertView setFrame:newFrame];
        NSArray * subviews = alertView.subviews;
        for (UIView * view in subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton * button = (UIButton *)view;
                CGRect newButtonFrame = CGRectMake(alertView.frame.size.width/2 - button.frame.size.width/2, button.frame.origin.y + 55, button.frame.size.width, button.frame.size.height);
                [button setFrame:newButtonFrame];
            }
            else {
                if ([view isKindOfClass:[UITextView class]] || (view.frame.size.width != alertView.frame.size.width && view.frame.size.height != alertView.frame.size.height)) {
                    view.hidden = YES;
                }
                if ([view isKindOfClass:[UILabel class]]) {
                    view.alpha = 1.0;
                    view.hidden = NO;
                    CGRect newLabelFrame = CGRectMake(alertView.frame.size.width/2 - view.frame.size.width/2, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
                    [view setFrame:newLabelFrame];
                }
            }
        }
    }
    else {
        NSLog(@"is portrait, frame not changed");
    }
}

@end
