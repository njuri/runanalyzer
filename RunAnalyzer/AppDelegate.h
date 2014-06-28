//
//  AppDelegate.h
//  RunAnalyzer
//
//  Created by Juri Noga on 25.06.14.
//
//

#import <UIKit/UIKit.h>
@class TableViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) TableViewController *vController;

@end
