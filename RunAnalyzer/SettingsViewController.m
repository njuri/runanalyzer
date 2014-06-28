//
//  ViewController.m
//  RunAnalyzer
//
//  Created by Juri Noga on 25.06.14.
//
//

#import "SettingsViewController.h"
#import "SpeedViewController.h"
#import "DistanceViewController.h"
#import "DurationViewController.h"
@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *speedSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSegment;

@end

@implementation SettingsViewController
- (IBAction)unitSelector:(id)sender {
    UISegmentedControl *segmented = sender;
    NSString *unit = [segmented titleForSegmentAtIndex:segmented.selectedSegmentIndex];
    [_speedSegment setTitle:[NSString stringWithFormat:@"%@/h",unit] forSegmentAtIndex:0];
    [_speedSegment setTitle:[NSString stringWithFormat:@"min/%@",unit] forSegmentAtIndex:1];
    _distanceFormat  = [segmented titleForSegmentAtIndex:segmented.selectedSegmentIndex];
    _speedFormat = [_speedSegment titleForSegmentAtIndex:_speedSegment.selectedSegmentIndex];
    _speedMode = _speedSegment.selectedSegmentIndex;
    if ([unit isEqualToString:@"km"]) {
        _kilometersOrMiles = YES;
    }
    else{
        _kilometersOrMiles = NO;
    }
    SpeedViewController *svc = [[SpeedViewController alloc] init];
    [svc loadUnits:self];
    DistanceViewController *divc = [[DistanceViewController alloc] init];
    [divc loadUnits:self];
    DurationViewController *duvc = [[DurationViewController alloc] init];
    [duvc loadUnits:self];
    
}

- (IBAction)speedSelector:(id)sender {
    _speedFormat = [_speedSegment titleForSegmentAtIndex:_speedSegment.selectedSegmentIndex];
    _speedMode = _speedSegment.selectedSegmentIndex;
    SpeedViewController *svc = [[SpeedViewController alloc] init];
    [svc loadUnits:self];
    DistanceViewController *divc = [[DistanceViewController alloc] init];
    [divc loadUnits:self];
    DurationViewController *duvc = [[DurationViewController alloc] init];
    [duvc loadUnits:self];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"UnitSegment"]||[defaults objectForKey:@"SpeedUnit1"]||[defaults objectForKey:@"SpeedUnit2"]||[defaults objectForKey:@"SpeedSegment"]){
        self.unitSegment.selectedSegmentIndex = [defaults integerForKey:@"UnitSegment"];
        self.speedSegment.selectedSegmentIndex = [defaults integerForKey:@"SpeedSegment"];
        [_speedSegment setTitle:[NSString stringWithFormat:@"%@/h",[defaults valueForKey:@"SpeedUnit"]] forSegmentAtIndex:0];
        [_speedSegment setTitle:[NSString stringWithFormat:@"min/%@",[defaults valueForKey:@"SpeedUnit"]] forSegmentAtIndex:1];
    }
    _distanceFormat  = [_unitSegment titleForSegmentAtIndex:_unitSegment.selectedSegmentIndex];
    _speedFormat = [_speedSegment titleForSegmentAtIndex:_unitSegment.selectedSegmentIndex];
    _speedMode = _speedSegment.selectedSegmentIndex;
    if ([_distanceFormat isEqualToString:@"km"]) {
        _kilometersOrMiles = YES;
    }
    else{
        _kilometersOrMiles = NO;
    }
    SpeedViewController *svc = [[SpeedViewController alloc] init];
    [svc loadUnits:self];
    DistanceViewController *divc = [[DistanceViewController alloc] init];
    [divc loadUnits:self];
    DurationViewController *duvc = [[DurationViewController alloc] init];
    [duvc loadUnits:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveUnitSegmentState:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:_unitSegment.selectedSegmentIndex forKey:@"UnitSegment"];
    [defaults setInteger:_speedSegment.selectedSegmentIndex forKey:@"SpeedSegment"];
    [defaults setValue:[_unitSegment titleForSegmentAtIndex:_unitSegment.selectedSegmentIndex] forKey:@"SpeedUnit"];
}

@end
