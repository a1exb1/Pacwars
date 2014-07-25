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
#import "SIOSocket.h"

@protocol gameTimeDelegate <NSObject>

-(void)tick;
-(void)moveSelf:(NSArray*)array;

@end

@interface Session : NSObject

@property Map *map;
@property Room *currentRoom;

@property CGRect sceneFrame;
@property NSMutableArray *movingObjects;
@property NSMutableArray *deletionQueue;
@property NSDate *gameStartTimeStamp;
@property NSDate *gameElapsedTime;
@property NSDate *gameCurrentAdjustedTime;

@property  NSMutableIndexSet *discardedItems;

@property id<gameTimeDelegate>delegate;
@property long ping;
-(void)startGame;

@property NSMutableArray *taskLog;
@property NSMutableArray *taskDeletionQueue;
@property NSMutableDictionary *movingObjectsDictionary;
@property long activePlayerID;

@property SIOSocket *socket;
@property long c;

@property id activePlayer;
@property int currentRoomColumn;
@property int currentRoomRow;

@end
