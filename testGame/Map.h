//
//  Map.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Theme.h"
#import "Tools.h"

@interface Map : NSObject

@property Theme *theme;
@property NSMutableArray *rooms;
@property NSMutableArray *backgroundNodes;

@end
