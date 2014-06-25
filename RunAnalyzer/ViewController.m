//
//  ViewController.m
//  RunAnalyzer
//
//  Created by Juri Noga on 25.06.14.
//
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *distanceField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *speedField;
@property NSString *units;

@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.distanceField.delegate = self;
    _units = @"km";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segment:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    if(selectedSegment == 0){
		_units = @"km";
	}
	if(selectedSegment == 1){
        _units = @"mi";
	}
}

- (IBAction)calculate:(id)sender {
    double distance = [_distanceField.text doubleValue];
    double hours = [_timeField.text doubleValue];
    double speed = distance/hours;
    _speedField.text = [NSString stringWithFormat:@"%.2f %@/h",speed,_units];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if (theTextField == self.distanceField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
