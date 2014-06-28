//
//  SpeedViewController.m
//  RunAnalyzer
//
//  Created by Juri Noga on 27.06.14.
//
//

#import "SpeedViewController.h"
#import "SettingsViewController.h"
#import "Calculator.h"

@interface SpeedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *speedUnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceUnitLabel;
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *minutesLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UIButton *calcButton;

@end

@implementation SpeedViewController

NSString *distanceFormat = @"km";
NSString *speedFormat = @"km/h";
NSArray *timesArray,*labelArray,*fields,*pickerdata;
BOOL kilometersOrMiles;
long totalSeconds = 0;
long mode;
double speed;
int columns = 3;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialLoad];
    [self loadData];
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [_distanceUnitLabel setText:distanceFormat];
    [_distanceField setKeyboardType:UIKeyboardTypeDecimalPad];
    speed = 0;
    [_calcButton sendActionsForControlEvents: UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Load settings
-(void)loadUnits:(SettingsViewController *)svc{
    distanceFormat = svc.distanceFormat;
    speedFormat = svc.speedFormat;
    NSLog(@"Speed format: %@",speedFormat);
    mode = svc.speedMode;
    kilometersOrMiles = svc.kilometersOrMiles;
}

// Auto-hide while field loses focus
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

// Speed calculation
- (IBAction)calculate:(id)sender {
    Calculator *calc = [[Calculator alloc]init];
    if(_distanceField.text.length>0){
        double distance = [[_distanceField text] doubleValue];
        long hours = [[_hoursLabel text] integerValue];
        long minutes = [[_minutesLabel text] integerValue];
        long seconds = [[_secondsLabel text] integerValue];
        totalSeconds = hours*3600+minutes*60+seconds;
        if (!(totalSeconds ==0||distance==0)) {
            speed = [calc calculateSpeedUsingDistance:distance andTime:totalSeconds withMode:mode kilometers:kilometersOrMiles];
            NSLog(@"Calculating distance: %f and seconds %ld",distance,totalSeconds);
            [_speedUnitLabel setText:[NSString stringWithFormat:@"%.2f %@",speed,speedFormat]];
        }
        else{
            [_speedUnitLabel setText:@"0 values"];
        }
    }
}

// The number of columns of data
- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return columns;
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

//Load data
-(void)loadData{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"Speed"]||[defaults objectForKey:@"Distance"]){
        NSLog(@"loading");
        self.distanceField.text = [defaults valueForKey:@"Distance"];
        self.speedUnitLabel.text  = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"Speed"]];
        self.hoursLabel.text = [defaults valueForKey:@"Time1"];
        self.minutesLabel.text = [defaults valueForKey:@"Time2"];
        self.secondsLabel.text = [defaults valueForKey:@"Time3"];
    }
}

//Save data
- (IBAction)saveCalculationsState:(id)sender {
    NSLog(@"saving");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:speed forKey:@"Speed"];
    [defaults setValue:_distanceField.text forKey:@"Distance"];
    [defaults setValue:_hoursLabel.text forKey:@"Time1"];
    [defaults setValue:_minutesLabel.text forKey:@"Time2"];
    [defaults setValue:_secondsLabel.text forKey:@"Time3"];
}

@end
