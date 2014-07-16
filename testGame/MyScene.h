//
//  MyScene.h
//  testGame
//

//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Session.h"
#import "Tools.h"
#import "TestMap.h"
#import "Player.h"
#import "Room.h"
#import "Weapon.h"

@protocol frameDelegate <NSObject>

-(void)frame;

@end

@interface MyScene : SKScene <gameTimeDelegate>

@property Map *map;
//@property int direction;
//@property bool shouldMove;
@property Player *player;
@property Player *player2;
@property int touches;
@property SKSpriteNode *movementController;
@property SKSpriteNode *shootController;
@property SKSpriteNode *changeWeaponController;

@property SKLabelNode *myLabel;
@property id<frameDelegate>delgate;

@property int c;

@end
