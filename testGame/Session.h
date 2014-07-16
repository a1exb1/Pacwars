//
//  Session.h
//  testGame
//
//  Created by Alex Bechmann on 16/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"

@interface Session : NSObject

@property Map *map;
@property CGRect sceneFrame;

@end
