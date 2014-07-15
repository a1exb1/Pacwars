//
//  MyScene.h
//  testGame
//

//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Tools.h"
#import "Map.h"
#import "Player.h"

@interface MyScene : SKScene

@property NSString *direction;
@property bool shouldMove;
@property Player *player;
@property int touches;
@property SKSpriteNode *movementController;
@property SKSpriteNode *shootController;
@property SKSpriteNode *changeWeaponController;

@end
