//
//  MovingObject.m
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "MovingObject.h"

@implementation MovingObject

extern Session *session;

//-(id)init{
//    if(self = [super init]) {
//        //self.map = session.map;
//        self.speed = 7;
//    }
//    return self;
//}

-(void)Frame{
    //HITS LEFT EDGE
    if(self.position.x <0){
        self.roomRow = self.roomRow -1;
        
        if (self.roomRow == -1) {
            self.roomRow = (int)[[_map.rooms objectAtIndex:self.roomColumn] count] -1;
        }
        self.position = CGPointMake(self.frameP.size.width, self.position.y);
    }
    
    // HITES RIGHT EDGE
    else if(self.position.x > self.frameP.size.width){
        self.roomRow = self.roomRow +1;
        self.position = CGPointMake(0, self.position.y);
        
        if (self.roomRow == (int)[[_map.rooms objectAtIndex:self.roomColumn] count]) {
            self.roomRow = 0;
        }
    }
    
    // HITS BOTTOM EDGE
    else if(self.position.y < 0){
        self.roomColumn = self.roomColumn +1;
        self.position = CGPointMake(self.position.x, 768);
        
        if (self.roomColumn == (int)[_map.rooms count]) {
            self.roomColumn = 0;
        }
    }
    
    // HITS TOP EDGE
    else if(self.position.y > 768){
        self.roomColumn = self.roomColumn -1;
        self.position = CGPointMake(self.position.x, 0);
        
        if (self.roomColumn == -1) {
            self.roomColumn =(int)[_map.rooms count]-1;
        }
        
    }
    
    if (_shouldMove) {
        switch (_direction) {
            case 0: //N
                self.position = CGPointMake(self.position.x, (self.position.y + self.moveSpeed));
                break;
                
            case 1: //NE
                self.position = CGPointMake(self.position.x, (self.position.y + self.moveSpeed));
                self.position = CGPointMake((self.position.x + self.moveSpeed), self.position.y);
                break;
                
            case 2: //E
                self.position = CGPointMake((self.position.x + self.moveSpeed), self.position.y);
                break;
                
            case 3: //SE
                self.position = CGPointMake(self.position.x, (self.position.y - self.moveSpeed));
                self.position = CGPointMake((self.position.x + self.moveSpeed), self.position.y);
                break;
                
            case 4: //S
                self.position = CGPointMake(self.position.x, (self.position.y - self.moveSpeed));
                break;
                
            case 5: //SW
                self.position = CGPointMake(self.position.x, (self.position.y - self.moveSpeed));
                self.position = CGPointMake((self.position.x - self.moveSpeed), self.position.y);
                break;
                
            case 6: //W
                self.position = CGPointMake((self.position.x - self.moveSpeed), self.position.y);
                break;
                
            case 7: //NW
                self.position = CGPointMake(self.position.x, (self.position.y + self.moveSpeed));
                self.position = CGPointMake((self.position.x - self.moveSpeed), self.position.y);
                break;
                
            default:
                break;
        }
    }
    
    
}

@end
