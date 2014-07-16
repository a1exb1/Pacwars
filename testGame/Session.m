//
//  Session.m
//  testGame
//
//  Created by Alex Bechmann on 16/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Session.h"

@implementation Session

-(void)startGame{
    [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(updateClock:) userInfo:nil repeats:YES];
    self.gameTime = self.gameTime - 100;
}
     
-(void)updateClock:(NSTimer*)timer{
    
    self.gameTime++;
    
    NSString *actDate = [NSString stringWithFormat:@"/Date(%f)/", self.gameTime];
    NSString *nDate = [[[[actDate componentsSeparatedByString:@"("] objectAtIndex:1] componentsSeparatedByString:@")"] objectAtIndex:0];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([nDate doubleValue] / 1000)];
    //[date dateByAddingTimeInterval:3600];
    NSDateFormatter *dtfrm = [[NSDateFormatter alloc] init];
    [dtfrm setDateFormat:@"MM/dd/yyyy hh:mm:ss"]; // :SSS
    nDate = [dtfrm stringFromDate:date];
    self.gameTimeString = nDate;
    [self.delegate tick];
    //NSLog(@"%@", self.gameTimeString);
    
}

@end
