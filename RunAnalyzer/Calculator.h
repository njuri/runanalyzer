//
//  Calculator.h
//  RunAnalyzer
//
//  Created by Juri Noga on 26.06.14.
//
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

-(double)calculateSpeedUsingDistance:(double)distance andTime:(long)seconds withMode:(long)mode kilometers:(BOOL)km;
-(double)calculateDistanceUsingSpeed:(double)speed andTime:(long)seconds withMode:(long)mode kilometers:(BOOL)km;
-(NSArray*)calculateTimeUsingSpeed:(double)speed andDistance:(double)distance withMode:(long)mode kilometers:(BOOL)km;

@end
