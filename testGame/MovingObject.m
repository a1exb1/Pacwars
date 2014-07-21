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
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    if(self.position.x <0){
        self.roomRow = self.roomRow -1;
        
        if (self.roomRow == -1) {
            self.roomRow = (int)[[session.map.rooms objectAtIndex:self.roomColumn] count] -1;
        }
        self.position = CGPointMake(session.sceneFrame.size.width, self.position.y);
        self.direction = _direction; // RESETS timestamp + change dir position
    }
    
    // HITES RIGHT EDGE
    else if(self.position.x > session.sceneFrame.size.width){
        self.roomRow = self.roomRow +1;
        self.position = CGPointMake(0, self.position.y);
        
        if (self.roomRow == (int)[[session.map.rooms objectAtIndex:self.roomColumn] count]) {
            self.roomRow = 0;
        }
        self.direction = _direction;
    }
    
    // HITS BOTTOM EDGE
    else if(self.position.y < 0){
        self.roomColumn = self.roomColumn +1;
        self.position = CGPointMake(self.position.x, 768);
        
        if (self.roomColumn == (int)[session.map.rooms count]) {
            self.roomColumn = 0;
        }
        self.direction = _direction;
    }
    
    // HITS TOP EDGE
    else if(self.position.y > 768){
        self.roomColumn = self.roomColumn -1;
        self.position = CGPointMake(self.position.x, 0);
        
        if (self.roomColumn == -1) {
            self.roomColumn =(int)[session.map.rooms count]-1;
        }
        self.direction = _direction;
        
    }
    
    self.moveSpeed = 10;
    
    NSTimeInterval secondsBetween = [session.gameElapsedTime timeIntervalSinceDate:self.changeTimeStamp];
    long distance = secondsBetween * _moveSpeed;
    
    if (_shouldMove) {
//        switch (_direction) {
//            case 0: //N
//                self.position = CGPointMake(self.changeDirectionPosition.x, self.changeDirectionPosition.y + distance);
//                
//                break;
//                
//            case 1: //NE
//                self.position = CGPointMake(self.changeDirectionPosition.x + distance, self.changeDirectionPosition.y + distance);
//                
//                break;
//                
//            case 2: //E
//                self.position = CGPointMake(self.changeDirectionPosition.x + distance, self.changeDirectionPosition.y);
//                break;
//                
//            case 3: //SE
//                self.position = CGPointMake(self.changeDirectionPosition.x + distance, self.changeDirectionPosition.y - distance);
//                break;
//                
//            case 4: //S
//                self.position = CGPointMake(self.changeDirectionPosition.x, self.changeDirectionPosition.y - distance);
//                break;
//                
//            case 5: //SW
//                self.position = CGPointMake(self.changeDirectionPosition.x - distance, self.changeDirectionPosition.y - distance);
//
//                
//                break;
//                
//            case 6: //W
//                self.position = CGPointMake(self.changeDirectionPosition.x - distance, self.changeDirectionPosition.y);
//                break;
//                
//            case 7: //NW
//                self.position = CGPointMake(self.changeDirectionPosition.x  - distance, self.changeDirectionPosition.y + distance);
//                break;
//                
//            default:
//                break;
//        }
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
            //[self send];
        
        self.prevDirection = self.direction;
    }
    
    
    [UIView commitAnimations];
}

-(void)setCannotDie:(int)time{
    self.protection = true;
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stopProtection) userInfo:nil repeats:NO];
}


-(void)stopProtection{
    self.protection = false;
}

-(void)sendWithSocket:(SIOSocket*)socket;
{
//    jsonReader *reader = [[jsonReader alloc] init];
//    reader.delegate = (id)self;
//    reader.task = @"send";
    
    int shouldMoveInt = 2; // stop
    
    if(_shouldMove)
        shouldMoveInt = 1; // move
    
    self.changeDirectionPosition = self.position; //http://www.bechmann.co.uk/pw/s.aspx?s=
    NSString *urlString = [NSString stringWithFormat:@"1,%li,%d,%f,%i,%d,%d,%f,%f,%@", self.objectID, shouldMoveInt, self.moveSpeed, self.direction, self.roomColumn, self.roomRow, self.changeDirectionPosition.x, self.changeDirectionPosition.y, [Tools formatDate:self.changeTimeStamp withFormat:@"dd:MM:yy HH:mm:ss:SSS"]];
    //[reader jsonAsyncRequestWithDelegateAndUrl:urlString];
    //NSLog(@"update position: %@", urlString);
    [socket emit: @"chatmessage", urlString,nil];

}

- (void) finished:(NSString *)task withArray:(NSArray *)array{
    
}


-(void)registerAsPlayer
{
    jsonReader *reader = [[jsonReader alloc] init];
    reader.delegate = (id)self;
    reader.task = @"registerAsPlayer";
    NSString *urlString = @"http://www.bechmann.co.uk/pw/g.aspx?s=getplayerid";
    //[reader jsonAsyncRequestWithDelegateAndUrl:urlString];
    NSArray *returnArr = [jsonReader jsonRequestWithUrl:urlString];
    NSDictionary *dict = [returnArr objectAtIndex:0];
    self.objectID = [[dict objectForKey:@"pid"] intValue];
}


-(void)setDirection:(int)direction{
    self.changeDirectionPosition = self.position;
    self.changeTimeStamp = session.gameElapsedTime;
    _direction = direction;
}

-(void)addUpdateTimer{
    //[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(send) userInfo:nil repeats:YES];
}

-(void)fireFromScene:(id)scene usingSocket:(SIOSocket*)socket{
    NSLog(@"SHOOT!");
    MovingObject *bullet = [MovingObject spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(20, 20)];;
    bullet.moveSpeed = self.weapon.bulletSpeed;
    bullet.position = self.position;
    bullet.direction = 2;
    bullet.roomRow = self.roomRow;
    bullet.roomColumn = self.roomColumn;
    //bullet.timeToLive =
    
    bullet.shouldMove = YES;
    [self setCannotDie:0];
    [session.movingObjects addObject:bullet];
    [scene addChild:bullet];
    
    [socket emit: @"chatmessage", @"2,1",nil];
}

@end
