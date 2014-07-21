//
//  MovingObject.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Object.h"
#import "Session.h"
#import "Map.h"
#import "Skin.h"
#import "Weapon.h"
#import "SIOSocket.h"

@import SpriteKit;

@interface MovingObject : Object

@property (nonatomic) int direction;
@property int prevDirection;
@property bool shouldMove;
@property float moveSpeed;
@property float timeToLive;
@property int roomRow;
@property int roomColumn;
@property bool isAlive;
@property bool protection;
@property NSString *type;
@property NSString *objectKey;
@property long ownerID;
@property long points;

@property CGPoint changeDirectionPosition;
@property NSDate *changeTimeStamp;


-(void)drawFrame;
-(void)setCannotDie:(int)time;
-(void)stopProtection;
-(void)sendWithSocket:(SIOSocket*)socket;
-(void)registerAsPlayer;
-(void)addUpdateTimer;
-(void)fireToSocket:(SIOSocket*)socket;
-(void)fireFromScene:(id)scene;
-(void)dieToSocket:(SIOSocket*)socket;
-(void)remove;
//-(void)startTimeToLiveTimer;

// PLAYER
@property NSString *name;
@property Skin *skin;
@property Weapon *weapon;

@end
