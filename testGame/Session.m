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
    self.ping = 0.2;
    self.gameStartTimeStamp = [[NSDate alloc] init];
    NSLog(@"start time original%@", [Tools formatDate:self.gameStartTimeStamp withFormat:@"HH:mm:ss:SSS"]);
    self.gameStartTimeStamp = [self.gameStartTimeStamp dateByAddingTimeInterval:(self.ping)];
    NSLog(@"tweaked start time: %@", [Tools formatDate:self.gameStartTimeStamp withFormat:@"HH:mm:ss:SSS"]);
}
     
-(void)updateClock:(NSTimer*)timer{
    float secondsBetween = -[self.gameStartTimeStamp timeIntervalSinceNow];
    
    self.gameElapsedTime = [[Tools beginningOfDay:self.gameStartTimeStamp] dateByAddingTimeInterval:secondsBetween];
    
    self.gameCurrentAdjustedTime = [self.gameElapsedTime dateByAddingTimeInterval:secondsBetween - self.ping];
    [self.delegate tick];
}



@end
