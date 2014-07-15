//
//  TestMap.m
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "TestMap.h"

@implementation TestMap

-(id)init
{
    self = [super init];
    if (self) {
        NSMutableArray *rooms = [[NSMutableArray alloc] init];
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        Room *room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        [rooms addObject:row];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        [rooms addObject:row];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        room = [[Room alloc] init];
        [row addObject:room];
        
        [rooms addObject:row];
        
        self.rooms = rooms;

    }
    return self;
}

@end
