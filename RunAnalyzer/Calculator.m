//
//  Calculator.m
//  RunAnalyzer
//
//  Created by Juri Noga on 26.06.14.
//
//

#import "Calculator.h"

@implementation Calculator

-(double)calculateSpeedUsingDistance:(double)distance andTime:(long)seconds withMode:(long)mode kilometers:(BOOL)km{
    double kmh = distance/seconds*3600;
    double mph = kmh * 0.6214;
    if (mode == 0) {
        return kmh;
    }
    else if (mode==1){
        return 60/kmh;
    }
    else if (mode==2){
        if (km) {
            return (60/kmh)/10;
        }
        else{
            return (60/mph)/10;
        }

    }
    else{
        if (km) {
            return (60/kmh)/2;
        }
        else{
            return (60/mph)/2;
        }
    }
}
-(double)calculateDistanceUsingSpeed:(double)speed andTime:(long)seconds withMode:(long)mode kilometers:(BOOL)km{
    if (mode == 0) {
        return speed*(seconds/3600);
    }
    else if (mode == 1){
        return seconds/speed/60;
    }
    else if (mode == 2){
        if (km) {
            return seconds/speed/60/10;
        }
        else{
            return (seconds/speed/60/10)*0.6214;
        }
    }
    else{
        if (km) {
            return seconds/speed/2;
        }
        else{
            return (seconds/speed/2)*0.6214;
        }

        
    }
}
-(NSArray*)calculateTimeUsingSpeed:(double)speed andDistance:(double)distance withMode:(long)mode kilometers:(BOOL)km{
    if (mode == 0) {
        return [self getHoursMinutesSecondsFromSeconds:distance/speed*3600];
    }
    else if (mode == 1){
        return [self getHoursMinutesSecondsFromSeconds:distance*speed*60];
    }
    else{
        return NULL;
    }
}

-(NSArray *)getHoursMinutesSecondsFromSeconds:(int)totalSeconds{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    int hours = totalSeconds / 3600;
    NSLog(@"%i",hours);
    NSArray *ar = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:hours],[NSNumber numberWithInt:minutes],[NSNumber numberWithInt:seconds], nil];
    return ar;
}

@end
