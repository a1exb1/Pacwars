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
        NSMutableArray *nodes = [[NSMutableArray alloc] init];
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        NSMutableArray *nodeRow = [[NSMutableArray alloc] init];
        
        NSString *mapStr;
        SKSpriteNode *node;
        
        Room *room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_0.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_1.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_2.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        [rooms addObject:row];
        [nodes addObject:nodeRow];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        nodeRow = [[NSMutableArray alloc] init];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_0.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_1.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_2.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        [rooms addObject:row];
        [nodes addObject:nodeRow];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        nodeRow = [[NSMutableArray alloc] init];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_0.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_1.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_2.png"];
        [nodeRow addObject:node];
        [row addObject:room];
        
        [rooms addObject:row];
        [nodes addObject:nodeRow];
        
        self.rooms = rooms;
        self.backgroundNodes = nodes;

    }
    return self;
}

@end
