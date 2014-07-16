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
//        self.isAlive = YES;
//    }
//    return self;
//}

-(void)drawFrame{
    //HITS LEFT EDGE
    if(self.position.x <0){
        self.roomRow = self.roomRow -1;
        
        if (self.roomRow == -1) {
            self.roomRow = (int)[[session.map.rooms objectAtIndex:self.roomColumn] count] -1;
        }
        self.position = CGPointMake(session.sceneFrame.size.width, self.position.y);
    }
    
    // HITES RIGHT EDGE
    else if(self.position.x > session.sceneFrame.size.width){
        self.roomRow = self.roomRow +1;
        self.position = CGPointMake(0, self.position.y);
        
        if (self.roomRow == (int)[[session.map.rooms objectAtIndex:self.roomColumn] count]) {
            self.roomRow = 0;
        }
    }
    
    // HITS BOTTOM EDGE
    else if(self.position.y < 0){
        self.roomColumn = self.roomColumn +1;
        self.position = CGPointMake(self.position.x, 768);
        
        if (self.roomColumn == (int)[session.map.rooms count]) {
            self.roomColumn = 0;
        }
    }
    
    // HITS TOP EDGE
    else if(self.position.y > 768){
        self.roomColumn = self.roomColumn -1;
        self.position = CGPointMake(self.position.x, 0);
        
        if (self.roomColumn == -1) {
            self.roomColumn =(int)[session.map.rooms count]-1;
        }
        
    }
    
    //NSLog(@"%f %d", self.moveSpeed, self.direction);
    
    
    
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
        
        if (self.prevDirection != self.direction)
            [self send];
        
        self.prevDirection = self.direction;
        
    }
    
    
}

-(void)setCannotDie:(int)time{
    self.protection = true;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stopProtection) userInfo:nil repeats:NO];
}


-(void)stopProtection{
    self.protection = false;
}

-(void)send
{
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    NSString *urlString = [NSString stringWithFormat:@"http://www.bechmann.co.uk/pw/s.aspx?s=%d,%d,%f,%i", self.roomColumn, self.roomRow, self.moveSpeed, self.direction];
    [reader jsonAsyncRequestWithDelegateAndUrl:urlString];
    
    
}

- (void) finished:(NSString *)status withArray:(NSArray *)array
{
    NSLog(@"%@", array);
}


@end
