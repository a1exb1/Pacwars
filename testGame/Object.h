//
//  Object.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Room.h"

@interface Object : SKSpriteNode

@property long objectID;
@property Room *room;
@property float xcoord;
@property float ycoord;

@end
