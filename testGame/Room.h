//
//  Room.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Room : NSObject

@property NSMutableArray *objects;
@property NSMutableArray *movingObjects;
@property UIImage *bgImg;
@property SKSpriteNode *bgNode;
//@property int row;
//@property int column;

@end
