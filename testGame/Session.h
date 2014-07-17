//
//  Session.h
//  testGame
//
//  Created by Alex Bechmann on 16/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"
#import "Tools.h"

@protocol gameTimeDelegate <NSObject>

-(void)tick;
-(void)moveSelf:(NSArray*)array;

@end

@interface Session : NSObject

@property Map *map;
@property CGRect sceneFrame;
@property NSMutableArray *movingObjects;
@property NSMutableArray *deletionQueue;
@property NSDate *gameStartTimeStamp;
@property NSDate *gameElapsedTime;
@property NSDate *gameCurrentAdjustedTime;

@property id<gameTimeDelegate>delegate;
@property long ping;
-(void)startGame;

@property NSMutableArray *taskLog;
@property NSMutableArray *taskDeletionQueue;

@property NSMutableDictionary *movingObjectsDictionary;

@end
