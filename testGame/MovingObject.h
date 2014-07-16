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

@import SpriteKit;

@interface MovingObject : Object

@property int direction;
@property bool shouldMove;
@property float moveSpeed;
@property float timeToLive;
@property int roomRow;
@property int roomColumn;

//@property CGRect frameP;
//@property Map *map;

-(void)Frame;

@end
