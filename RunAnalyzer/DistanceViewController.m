//
//  DistanceViewController.m
//  RunAnalyzer
//
//  Created by Juri Noga on 28.06.14.
//
//

#import "DistanceViewController.h"
#import "SettingsViewController.h"
#import "Calculator.h"

@interface DistanceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *speedUnitLabel;
@property (weak, nonatomic) IBOutlet UITextField *speedField;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *calcButton;

@end

@implementation DistanceViewController

NSString *distanceFormat2 = @"km";
NSString *speedFormat2 = @"km/h";
NSArray *timesArray,*labelArray,*fields,*pickerdata;
BOOL kilometersOrMiles;
long totalSeconds2 = 0;
long mode;
double distance;
int columns2 = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialLoad];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [_speedUnitLabel setText:speedFormat2];
    [_speedField setKeyboardType:UIKeyboardTypeDecimalPad];
    distance = 0;
    [_calcButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

//Load settings
-(void)loadUnits:(SettingsViewController *)svc{
    distanceFormat2 = svc.distanceFormat;
    speedFormat2 = svc.speedFormat;
    mode = svc.speedMode;
    kilometersOrMiles = svc.kilometersOrMiles;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Calculate distance
- (IBAction)calculateDistance:(id)sender {
    Calculator *calc = [[Calculator alloc]init];
    if(_speedField.text.length>0){
        double speed = [[_speedField text] doubleValue];
        long hours = [[_hoursLabel text] integerValue];
        long minutes = [[_minutesLabel text] integerValue];
        long seconds = [[_secondsLabel text] integerValue];
        totalSeconds2 = hours*3600+minutes*60+seconds;
        if (!(totalSeconds2 ==0||speed==0)) {
            distance = [calc calculateDistanceUsingSpeed:speed andTime:totalSeconds2 withMode:mode kilometers:kilometersOrMiles];
            NSLog(@"Calculating distance: %f and seconds %ld",speed,totalSeconds2);
            [_resultLabel setText:[NSString stringWithFormat:@"%.2f %@",distance,distanceFormat2]];
        }
        else{
            [_resultLabel setText:@"0 values"];
        }
    }
}

// Auto-hide while field loses focus
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//Initial load
-(void)initialLoad{
    _secondsArray = [[NSMutableArray alloc]init];
    _minutesArray = [[NSMutableArray alloc]init];
    _hoursArray = [[NSMutableArray alloc]init];
    for(int i = 0;i<60;i++){
        [_secondsArray addObject:[NSString stringWithFormat:@"%i",i]];
        [_minutesArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    for(int i = 0;i<24;i++){
        [_hoursArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    timesArray = [[NSArray alloc] initWithObjects:_hoursArray,_minutesArray,_secondsArray, nil];
    labelArray = [[NSArray alloc] initWithObjects:_hoursLabel,_minutesLabel,_secondsLabel, nil];
}

// The number of columns of data
- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return columns2;
}
// Set number of rows in each column
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [[timesArray objectAtIndex:component] count];
}

// Set data in picker
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([[[timesArray objectAtIndex:component] objectAtIndex:row]integerValue ]<10){
        return [NSString stringWithFormat:@"0%@",[[timesArray objectAtIndex:component] objectAtIndex:row]];
    }
    else{
        return [[timesArray objectAtIndex:component] objectAtIndex:row];
    }
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([[[timesArray objectAtIndex:component] objectAtIndex:row]integerValue ]<10){
        UILabel *label = [labelArray objectAtIndex:component];
        [label setText:[NSString stringWithFormat:@"0%@",[[timesArray objectAtIndex:component] objectAtIndex:row]]];
    }
    else{
        UILabel *label = [labelArray objectAtIndex:component];
        [label setText:[[timesArray objectAtIndex:component] objectAtIndex:row]];
    }
    [self saveCalculationsState:self.picker];
}

//Load data
-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Speed2"]||[defaults objectForKey:@"Distance2"]){
        NSLog(@"loading");
        self.speedField.text = [defaults valueForKey:@"Speed2"];
        self.hoursLabel.text = [defaults valueForKey:@"Time11"];
        self.minutesLabel.text = [defaults valueForKey:@"Time22"];
        self.secondsLabel.text = [defaults valueForKey:@"Time33"];
    }
}

//Save data
- (IBAction)saveCalculationsState:(id)sender {
    NSLog(@"saving");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:distance forKey:@"Distance2"];
    [defaults setValue:_speedField.text forKey:@"Speed2"];
    [defaults setValue:_hoursLabel.text forKey:@"Time11"];
    [defaults setValue:_minutesLabel.text forKey:@"Time22"];
    [defaults setValue:_secondsLabel.text forKey:@"Time33"];
}

@end
