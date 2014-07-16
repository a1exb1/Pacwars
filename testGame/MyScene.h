//
//  MyScene.h
//  testGame
//

//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
//#import "Session.h"
#import "Tools.h"
#import "TestMap.h"
#import "Player.h"
#import "Room.h"
#import "Weapon.h"

@interface MyScene : SKScene

@property Map *map;
@property int direction;
@property bool shouldMove;
@property Player *player;
@property int touches;
@property SKSpriteNode *movementController;
@property SKSpriteNode *shootController;
@property SKSpriteNode *changeWeaponController;

@property SKLabelNode *myLabel;

@end
