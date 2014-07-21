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
    //is hit?
    
    for (MovingObject *obj in session.movingObjects){
        if(obj.roomRow == self.roomRow && obj.roomColumn == self.roomColumn)
        { // IS IN SAME ROOM
            if (obj.position.x - self.position.x < self.frame.size.width &&
                obj.position.x - self.position.x > -self.frame.size.width &&
                obj.position.y - self.position.y < self.frame.size.height &&
                obj.position.y - self.position.y > -self.frame.size.height &&
                !self.protection && self.isAlive &&
                [obj.type isEqualToString:@"bullet"]) {
                
                MovingObject *activePlayer = (MovingObject*)session.activePlayer;
                NSLog(@"dead %li, %li", obj.ownerID, activePlayer.objectID);
                
                //self.player.isAlive = NO;
                //if (![obj.type isEqualToString:@"player"]) {
                [obj remove];
                //[session.deletionQueue addObject:self];
                
                if (obj.ownerID != activePlayer.objectID){
                    [self dieToSocket:session.socket andBulletOwner:obj.ownerID];
                
                    //self.points++;
                }
                //}
            }
        }

    }
    
    //HITS LEFT EDGE
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
    
    //self.moveSpeed = 9;
    
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
    NSString *urlString = [NSString stringWithFormat:@"1,%li,%d,%f,%i,%d,%d,%f,%f", self.objectID, shouldMoveInt, self.moveSpeed, self.direction, self.roomColumn, self.roomRow, self.changeDirectionPosition.x, self.changeDirectionPosition.y]; // , [Tools formatDate:self.changeTimeStamp withFormat:@"dd:MM:yy HH:mm:ss:SSS"]
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

-(void)fireToSocket:(SIOSocket*)socket{
    NSLog(@"SHOOT!");
    NSString *url = [NSString stringWithFormat:@"2, %ld, %f, %f", self.objectID, self.position.x, self.position.y];
    [socket emit: @"chatmessage", url ,nil];
}

-(void)fireFromScene:(id)scene andPosition:(CGPoint)shotPosition{
    MovingObject *bullet = [MovingObject spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(20, 20)];;
    bullet.moveSpeed = self.weapon.bulletSpeed;
    bullet.position = shotPosition;
    bullet.direction = 2;
    bullet.roomRow = self.roomRow;
    bullet.roomColumn = self.roomColumn;
    bullet.timeToLive = 2;
    bullet.ownerID = self.objectID;
    bullet.shouldMove = YES;
    bullet.type = @"bullet";
    [self setCannotDie:0]; // should only take into account your own bullets.....
    [session.movingObjects addObject:bullet];
    [scene addChild:bullet];
    [bullet startTimeToLiveTimer];
}

-(void)dieToSocket:(SIOSocket*)socket andBulletOwner:(long)bulletOwnerID{
    if ([self.type isEqualToString:@"player"]) {
        NSString *url = [NSString stringWithFormat:@"3,%ld,%li", self.objectID, bulletOwnerID];
        [socket emit: @"chatmessage", url ,nil];
    }
}

-(void)startTimeToLiveTimer{
    if (self.timeToLive != 0) {
        [NSTimer scheduledTimerWithTimeInterval:self.timeToLive target:self selector:@selector(remove) userInfo:nil repeats:YES];
    }
}

-(void)remove{
    [self removeFromParent];
    [session.deletionQueue addObject:self];
    self.position = CGPointMake(9999, 9999);
    self.roomRow = 0;
    self.roomColumn = 0;
}

@end
