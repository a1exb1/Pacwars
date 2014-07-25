//
//  Room.m
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Room.h"

@implementation Room

-(id)init{
    if(self = [super init]) {
        //self.map = session.map;
        self.objects = [[NSMutableArray alloc] init];
        self.movingObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
