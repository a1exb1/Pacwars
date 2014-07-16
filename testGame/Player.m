//
//  Player.m
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Player.h"

@implementation Player

-(void)playerFrame
{
    if (self.shouldMove) {
        switch (self.direction) {
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
