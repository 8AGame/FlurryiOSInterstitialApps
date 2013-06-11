//
//  ViewController.m
//  FlurryiOSInterstitialAdsSample
//
//  Created by Bisera Ferrero on 6/3/13.
//  Copyright (c) 2013 Flurry. All rights reserved.
//

#import "ViewController.h"
#import "FlurryAdDelegate.h"
#import "FlurryAds.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Register yourself as a delegate for ad callbacks
    [FlurryAds setAdDelegate:self];
    
    // Fetch fullscreen ads early when a later display is likely. For
    // example, at the beginning of a level.
    [FlurryAds fetchAdForSpace:@"Takeover"
                         frame:self.view.frame size:FULLSCREEN];
    self->displayAdz.titleLabel.text =   @"Fetching...";
    
    
}

-(void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // Reset delegate
    [FlurryAds setAdDelegate:nil];    
}


/**
 *  Invoke a takeover at a natural pause in your app. For example, when a
 *  level is completed, an article is read or a button is pressed.
 */
- (IBAction)displayAd:(UIButton *)sender forEvent:(UIEvent *)event {
    // Check if ad is ready. If so, display the ad
    if ([FlurryAds adReadyForSpace:@"Takeover"]) {
        [FlurryAds displayAdForSpace:@"Takeover"
                              onView:self.view];
        
    } else {
        // Fetch an ad
        [FlurryAds fetchAdForSpace:@"Takeover"
                             frame:self.view.frame size:FULLSCREEN];
        
    }
    
}


/*
 *  It is recommended to pause app activities when an interstitial is shown.
 *  Listen to should display delegate.
 */
- (BOOL) spaceShouldDisplay:(NSString*)adSpace interstitial:(BOOL)
interstitial {
    if (interstitial) {
        NSLog(@"Pause app state now");
        
    }
    
    // Continue ad display
    return YES;
}

/*
 *  Resume app state when the interstitial is dismissed.
 */
- (void)spaceDidDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    if (interstitial) {
        NSLog(@"Resume app state here");
    }
}

- (void)spaceDidReceiveAd:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Receive Ad ================ ", adSpace);
    self->displayAdz.titleLabel.text =   @"Display";
    
}

- (void)spaceDidFailToReceiveAd:(NSString *)adSpace error:(NSError *)error {
    NSLog(@"=========== Ad Space [%@] Did Fail to Receive Ad with error [%@] ================ ", adSpace, error);
    self->displayAdz.titleLabel.text =   @"Fetch";
    
}

- (void) videoDidFinish:(NSString *)adSpace{
    NSLog(@"=========== Ad Space [%@] Video Did Finish  ================ ", adSpace);
}


- (void)spaceWillDismiss:(NSString *)adSpace interstitial:(BOOL)interstitial {
    NSLog(@"=========== Ad Space [%@] Will Dismiss for interstitial [%d] ================ ", adSpace, interstitial);
    self->displayAdz.titleLabel.text =   @"Fetch";
}


- (void)spaceWillLeaveApplication:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Will Leave Application ================ ", adSpace);
}

- (void) spaceDidFailToRender:(NSString *) adSpace error:(NSError *)error {
    NSLog(@"=========== Ad Space [%@] Did Fail to Render with error [%@] ================ ", adSpace, error);
}

- (void) spaceDidReceiveClick:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Receive Click ================ ", adSpace);
}

- (void)spaceWillExpand:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Will Expand ================ ", adSpace);
}

- (void)spaceDidCollapse:(NSString *)adSpace {
    NSLog(@"=========== Ad Space [%@] Did Collapse ================ ", adSpace);
}


- (void)dealloc {
    [displayAdz release];
    [super dealloc];
}
@end
