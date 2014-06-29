//
//  SpeedViewController.h
//  RunAnalyzer
//
//  Created by Juri Noga on 27.06.14.
//
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
@class SettingsViewController;

@interface SpeedViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) NSMutableArray *secondsArray;
@property (strong,nonatomic) NSMutableArray *minutesArray;
@property (strong,nonatomic) NSMutableArray *hoursArray;
@property (strong,nonatomic) SLComposeViewController *slComposeViewController;

-(void)loadUnits:(SettingsViewController*)svc;

@end
