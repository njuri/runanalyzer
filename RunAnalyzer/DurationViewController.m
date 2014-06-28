//
//  DurationViewController.m
//  RunAnalyzer
//
//  Created by Juri Noga on 29.06.14.
//
//

#import "DurationViewController.h"
#import "SettingsViewController.h"
#import "Calculator.h"
@interface DurationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *speedUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceUnitLabel;
@property (weak, nonatomic) IBOutlet UITextField *speedField;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UIButton *calcButton;

@end

@implementation DurationViewController

NSString *distanceFormat3 = @"km";
NSString *speedFormat3 = @"km/h";
BOOL kilometersOrMiles;
long mode;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [_speedUnitLabel setText:speedFormat3];
    [_distanceUnitLabel setText:distanceFormat3];
    [_speedField setKeyboardType:UIKeyboardTypeDecimalPad];
    [_distanceField setKeyboardType:UIKeyboardTypeDecimalPad];
    [_calcButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}


//Load settings
-(void)loadUnits:(SettingsViewController *)svc{
    distanceFormat3 = svc.distanceFormat;
    speedFormat3 = svc.speedFormat;
    mode = svc.speedMode;
    kilometersOrMiles = svc.kilometersOrMiles;
}

- (IBAction)calculateDuration:(id)sender {
    Calculator *calc = [[Calculator alloc]init];
    if (_distanceField.text.length>0) {
        double distance = [_distanceField.text doubleValue];
        double speed = [_speedField.text doubleValue];
        if (!(distance==0||speed==0)){
            NSArray *ar = [calc calculateTimeUsingSpeed:speed andDistance:distance withMode:mode kilometers:kilometersOrMiles];
            [_hoursLabel setText:[NSString stringWithFormat:@"%@",[ar objectAtIndex:0]]];
            [_minutesLabel setText:[NSString stringWithFormat:@"%@",[ar objectAtIndex:1]]];
            [_secondsLabel setText:[NSString stringWithFormat:@"%@",[ar objectAtIndex:2]]];
        }

    }
}


//Load data
-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Speed3"]||[defaults objectForKey:@"Distance3"]){
        NSLog(@"loading");
        self.speedField.text = [defaults valueForKey:@"Speed3"];
        self.distanceField.text = [defaults valueForKey:@"Distance3"];
        self.hoursLabel.text = [defaults valueForKey:@"Time111"];
        self.minutesLabel.text = [defaults valueForKey:@"Time222"];
        self.secondsLabel.text = [defaults valueForKey:@"Time333"];
    }
}

//Save data
- (IBAction)saveCalculationsState:(id)sender {
    NSLog(@"saving");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:_distanceField.text forKey:@"Distance3"];
    [defaults setValue:_speedField.text forKey:@"Speed3"];
    [defaults setValue:_hoursLabel.text forKey:@"Time111"];
    [defaults setValue:_minutesLabel.text forKey:@"Time222"];
    [defaults setValue:_secondsLabel.text forKey:@"Time333"];
}

@end
