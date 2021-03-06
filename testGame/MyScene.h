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
#import "SIOSocket.h"
#import "Object.h"

@interface MyScene : SKScene <gameTimeDelegate>

@property Map *map;
@property MovingObject *player;
@property int touches;
@property SKSpriteNode *movementController;
@property SKSpriteNode *shootController;
@property SKSpriteNode *changeWeaponController;

@property SKLabelNode *myLabel;
@property int c;

//@property SIOSocket *socket;

@property int player1Score;
@property long player2Score;
@property Room *currentRoom;


@end
