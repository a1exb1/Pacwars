//
//  Session.h
//  testGame
//
//  Created by Alex Bechmann on 16/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"

@protocol gameTimeDelegate <NSObject>

-(void)tick;

@end

@interface Session : NSObject

@property Map *map;
@property CGRect sceneFrame;
@property NSMutableArray *movingObjects;
@property NSMutableArray *deletionQueue;
@property float gameTime;
@property NSString *gameTimeString;

-(void)startGame;

@property id<gameTimeDelegate>delegate;

@end
