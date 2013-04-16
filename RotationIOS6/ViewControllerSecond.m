//
//  ViewControllerSecond.m
//  RotationIOS6
//
//  Created by Stas on 3/11/13.
//  Copyright (c) 2013 Videal. All rights reserved.
//

#import "ViewControllerSecond.h"
#import "MovieViewController.h"

@interface ViewControllerSecond ()

@end

@implementation ViewControllerSecond

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem * item =  [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneclick:)];
    [self.navigationItem setRightBarButtonItem:item];
    //[[UIDevice currentDevice] setOrientation:UIInterfaceOrientationPortrait];
//    UIDeviceOrientation devOrient = [UIDevice currentDevice].orientation;
//    if (devOrient != UIInterfaceOrientationPortrait) {
//        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
//    }
	// Do any additional setup after loading the view.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateView) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)doneclick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    NSLog(@"supported called in red");
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    NSLog(@"preferred called in red");
    return UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rotateView {
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    
    // Calculate rotation angle
    CGFloat angle;
    switch (deviceOrientation) {
        case UIDeviceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIDeviceOrientationLandscapeLeft:
            angle = M_PI_2;
            break;
        case UIDeviceOrientationLandscapeRight:
            angle = - M_PI_2;
            break;
        default:
            angle = 0;
            break;
    }
    // Apply rotation
    static NSTimeInterval animationDuration = 0.3;
    [UIView animateWithDuration:animationDuration animations:^{
        alert.transform = CGAffineTransformMakeRotation(angle);
    }];
    //alert.transform = CGAffineTransformMakeRotation(angle);
}

- (IBAction)presentMovie:(id)sender {
    //NSString * path = [[NSBundle mainBundle] pathForResource:@"bikes" ofType:@"flv"];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"Motion16" ofType:@"wmv"];
    NSLog(@"path is: %@", path);
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"file exists!");
    }
    //NSURL * url = [NSURL URLWithString:@"http://www.youtube.com/watch?v=1yA7l4Mm6gM"];
    NSURL * url = [NSURL URLWithString:@"http://vodios-testing.meeton.com/meeton-vod-demo/76/video_360_300k.mp4/playlist.m3u8?amf=demoamf.meeton.com&token=TUJNrDtHzdIOrqaUDpbmmojIfnblCUc10NUYXQGW4QfAeupmn3hfJezbDNklMBnvV0uqSHv9_zEmQePtPWUD15qyH8N9TohWRvAuQgLaJ759sKhBQMpGWgFDyAG-Pb7lc-yRWMvzZiCjR-Dl4YXytJ8t9wv4WvbvGvv03wfyLKDhN_Rsmltj7It35V5yvyF5"];
    NSLog(@"url is: %@", url);
    UIGraphicsBeginImageContext(CGSizeMake(1,1));
    MovieViewController * moviePlayer = [[MovieViewController alloc] initWithContentURL:url];
    UIGraphicsEndImageContext();
    [moviePlayer setWantsFullScreenLayout:YES];
    [moviePlayer.moviePlayer prepareToPlay];
    [self.navigationController presentMoviePlayerViewControllerAnimated:moviePlayer];

    [moviePlayer.moviePlayer play];
}

- (IBAction)presentAlert:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Hello" delegate:self cancelButtonTitle:@"dismiss" otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(rotateView) withObject:nil afterDelay:0.5];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
