//
//  Player.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "MovingObject.h"
#import "Skin.h"

@interface Player : MovingObject

@property NSString *name;
@property Skin *skin;

@end
