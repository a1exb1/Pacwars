//
//  MovingObject.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Object.h"

@interface MovingObject : Object

@property float direction;
@property bool shouldMove;
@property float moveSpeed;
@property float timeToLive;

@end
