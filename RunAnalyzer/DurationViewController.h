//
//  DurationViewController.h
//  RunAnalyzer
//
//  Created by Juri Noga on 29.06.14.
//
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
@class SettingsViewController;

@interface DurationViewController : UIViewController

@property (strong,nonatomic) SLComposeViewController *slComposeViewController;

-(void)loadUnits:(SettingsViewController*)svc;

@end
