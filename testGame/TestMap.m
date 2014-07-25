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
        //NSMutableArray *nodeRow = [[NSMutableArray alloc] init];
        SKSpriteNode *node;
        
        Room *room = [[Room alloc] init];
        
        //0 - 0
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_0.png"];
        room.bgNode = node;
        [row addObject:room];
        
        //0 - 1
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_1.png"];
         room.bgNode = node;
        [row addObject:room];
        
        //0 - 2
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"0_2.png"];
         room.bgNode = node;
        [row addObject:room];
        
        [rooms addObject:row];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        
        //1 - 0
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_0.png"];
        room.bgNode = node;
        [row addObject:room];
        
        //1 - 1
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_1.png"];

        //objects
        Object *obj = [Tools textureNodeWithImageString:@"box1.png" andHeight:200 Width:200];
        obj.position = CGPointMake(200, 500);
        [room.objects addObject:obj];
        
        obj = [Tools textureNodeWithImageString:@"box1.png" andHeight:200 Width:200];
        obj.position = CGPointMake(200, 300);
        [room.objects addObject:obj];
        
        obj = [Tools textureNodeWithImageString:@"box1.png" andHeight:100 Width:100];
        obj.position = CGPointMake(600, 300);
        [room.objects addObject:obj];
        
        obj = [Tools textureNodeWithImageString:@"box1.png" andHeight:100 Width:100];
        obj.position = CGPointMake(700, 100);
        [room.objects addObject:obj];
        
        room.bgNode = node;
        [row addObject:room];
        
        
        // 1 - 2
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"1_2.png"];
        room.bgNode = node;
        [row addObject:room];
        
        [rooms addObject:row];
        
        //NEW ROW
        row = [[NSMutableArray alloc] init];
        
        // 2 - 0
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_0.png"];
        room.bgNode = node;
        [row addObject:room];
        
        
        // 2 - 1
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_1.png"];
        room.bgNode = node;
        [row addObject:room];
        
        
        // 2 - 2
        room = [[Room alloc] init];
        node = [SKSpriteNode spriteNodeWithImageNamed:@"2_2.png"];
        room.bgNode = node;
        [row addObject:room];
        
        [rooms addObject:row];
        
        self.rooms = rooms;
        self.backgroundNodes = nodes;

    }
    return self;
}

@end
