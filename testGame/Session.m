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
    self.ping = 0.1;
    self.gameStartTimeStamp = [[NSDate alloc] init];
    NSLog(@"start time original%@", [Tools formatDate:self.gameStartTimeStamp withFormat:@"HH:mm:ss:SSS"]);
    self.gameStartTimeStamp = [self.gameStartTimeStamp dateByAddingTimeInterval:(self.ping)];
    NSLog(@"tweaked start time: %@", [Tools formatDate:self.gameStartTimeStamp withFormat:@"HH:mm:ss:SSS"]);
    
    self.taskLog = [[NSMutableArray alloc] init];
    self.taskDeletionQueue = [[NSMutableArray alloc] init];
    self.movingObjectsDictionary = [[NSMutableDictionary alloc] init];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getData) userInfo:nil repeats:YES];
    
    //READJUST PING BY SUBTRACTING FROM CURRENT TIME AGAIN.
}

-(void)shouldGetData
{
    if(_c > 500){
        [self getData];
    }
}

-(void)updateClock:(NSTimer*)timer{
    float secondsBetween = -[self.gameStartTimeStamp timeIntervalSinceNow];
    self.gameElapsedTime = [[Tools beginningOfDay:self.gameStartTimeStamp] dateByAddingTimeInterval:secondsBetween];
    self.gameCurrentAdjustedTime = [self.gameElapsedTime dateByAddingTimeInterval:secondsBetween - self.ping]; // subtract ping again here?
    [self.delegate tick];
    _c++;
}

-(void)getData
{
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    NSString *urlString = [NSString stringWithFormat:@"http://www.bechmann.co.uk/pw/g.aspx?s=t&pid=%li", self.activePlayerID];
    [reader jsonAsyncRequestWithDelegateAndUrl:urlString];
}

- (void) finished:(NSString *)task withArray:(NSArray *)array
{
    if ([array count] > 0)
        //NSLog(@"%@", array);
        
    for (int c = 0; c < [array count]; c++) {
        NSDictionary *dict = [array objectAtIndex:0];
        NSString *arrayString =[dict objectForKey:@"t"];
        NSArray *list = [arrayString componentsSeparatedByString:@","];        
        [self.taskLog addObject:list];
        [self.delegate moveSelf:list];
    }
    
    //[self getData];
    
//    NSDictionary *dict = [array objectAtIndex:0];
//
//    
//    NSString *arrayString =[dict objectForKey:@"a"];
//    NSArray *list = [arrayString componentsSeparatedByString:@","];
//    NSLog(@"%@", array);
//    [self.taskLog addObject:list];
//    [self.delegate moveSelf:list];
    
    // CHECK FOR ID OF TASK BEFORE ADDING IT !
    
}

@end
