//
//  ViewController.h
//  RunAnalyzer
//
//  Created by Juri Noga on 25.06.14.
//
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property NSString *distanceFormat;
@property NSString *speedFormat;
@property long speedMode;
@property BOOL kilometersOrMiles;

-(void)sendSettings;

@end
