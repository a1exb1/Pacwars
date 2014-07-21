//
//  MyScene.m
//  testGame
//
//  Created by Alex Bechmann on 14/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

extern Session *session;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.map = [[Map alloc] init];
        TestMap *map = [[TestMap alloc] init];
        self.map.rooms = map.rooms;

        session.map = self.map;
        session.sceneFrame = self.frame;
        [session startGame];
        session.delegate = self;
        //self.frame = self.view.frame;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //BACKGROUND
        SKSpriteNode *bgImgView = [SKSpriteNode spriteNodeWithImageNamed:@"stone.png"];
        [self addChild:bgImgView];
        
        
        //SET PACMAN
        _player = [MovingObject spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(20, 20)];
        [_player registerAsPlayer];
        session.activePlayerID = _player.objectID;
        _player.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
        _player.roomColumn = 1;
        _player.roomRow = 1;
        _player.moveSpeed = 400;
        _player.isAlive = YES;
        _player.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        _player.type = @"player";
        //[_player addUpdateTimer];
        
        Weapon *weapon = [[Weapon alloc] init];
        weapon.bulletSpeed = 700;
        _player.weapon = weapon;
        [self addChild:_player];
        
        //CONTROLS
        _shootController = [SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(100, 100)];
        _shootController.position = CGPointMake(self.size.width - 50, 600);
        [self addChild:_shootController];
        
        _changeWeaponController = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(100, 100)];
        _changeWeaponController.position = CGPointMake(self.size.width - 50, 500);
        [self addChild:_changeWeaponController];
        
        _movementController = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(200, 200)];
        _movementController.position = CGPointMake(100, 450);
        [self addChild:_movementController];
        
        //OPACITY
        _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel.fontSize = 30;
        _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        //_myLabel.tex
        
        [self addChild:_myLabel];
        
        //SOCKET
        [SIOSocket socketWithHost: @"http://pwserver.nodejitsu.com:80" response: ^(SIOSocket *socket)
         {
             self.socket = socket;
             __weak typeof(self) weakSelf = self;
             self.socket.onConnect = ^()
             {
                 //weakSelf.socketIsConnected = YES;
                 NSLog(@"connected");
             };
             
             [self.socket on: @"chatmessage" do: ^(id msg)
              {
                  //NSData* data = [msg dataUsingEncoding:NSUTF8StringEncoding];
                
                  NSString *arrayString = msg;
                  NSArray *list = [arrayString componentsSeparatedByString:@","];
                  
                  NSLog(@"update %@", msg);
                  //[weakSelf moveSelf:list];
                  [session.taskLog addObject:list];
                  
                  for (NSArray *array in session.taskLog) {
                      //NSString *a = [NSString stringWithFormat:@"%ld", _player.objectID];
                      long objid = [[array objectAtIndex:9] intValue];
                      if ((int)_player.objectID != objid) {
                          
                          if( _c == 0) // IF OBJECT ID DOESNT EXIST
                          {
                              MovingObject *obj = [Player spriteNodeWithImageNamed:@"pacman.png"];
                              obj.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
                              obj.roomColumn = 1;
                              obj.roomRow = 1;
                              obj.moveSpeed = 11; // ??
                              obj.isAlive = YES;
                              obj.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
                              obj.type = @"player";
                              obj.objectKey = @"1";
                              [self addChild:obj];
                              [session.movingObjects addObject:obj];
                              [session.movingObjectsDictionary setValue:obj forKey:obj.objectKey];
                              _c++;
                          }
                          
                          else{
                              //[UIView beginAnimations:nil context:nil];
                              //[UIView setAnimationDuration:0.1];
                              float secondsBetween = [[Tools dateFromString:[array objectAtIndex:7] withFormat:[Tools standardDateFormat]] timeIntervalSinceDate:session.gameElapsedTime];
                              //NSLog(@"%f", secondsBetween);
                              //if (secondsBetween < 0.01 || secondsBetween > -0.01) {
                              MovingObject *obj = [session.movingObjectsDictionary objectForKey:@"1"];
                              obj.moveSpeed = [[array objectAtIndex:2] intValue];
                              obj.direction = [[array objectAtIndex:3] intValue];
                              obj.roomColumn = [[array objectAtIndex:4] intValue];
                              obj.roomRow = [[array objectAtIndex:5] intValue];
                              obj.changeDirectionPosition = CGPointMake([[array objectAtIndex:6] intValue], [[array objectAtIndex:7] intValue]);
                              obj.position = obj.changeDirectionPosition;
                              obj.changeTimeStamp = [Tools dateFromString:[array objectAtIndex:8] withFormat:[Tools standardDateFormat]];
                              [session.taskDeletionQueue addObject:array];
                              
                              if ([[array objectAtIndex:1] isEqualToString:@"1"])
                                  obj.shouldMove = YES;
                              
                              else{
                                  obj.shouldMove = NO;
                              }
                              
                              //NSLog(@"%f, %f", obj.position.x, obj.position.y);
                              
                              // [UIView commitAnimations];
                              //}
                              
                          }
                          
                          
                      }
                      else{
                          [session.taskDeletionQueue addObject:array];
                      }
                  }
                  
                  for (NSArray *task in session.taskDeletionQueue){
                      [session.taskLog removeObject:task];
                  }
                  
                  
                  //NSLog(@"%li, %li", [session.taskLog count], session.taskDeletionQueue.count);
                  session.taskDeletionQueue = [[NSMutableArray alloc] init];
                  
              }];
         }];
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [self analyseTouchesWithArray:touches];
    
    _touches = _touches + (int)[touches count];
    //NSLog(@"started %d", _touches);
}

-(void)analyseTouchesWithArray:(NSSet *)touches{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        int prevDir = _player.direction;
        
        //NSString *yCoord = @"";
        if([self nodeAtPoint:location] == _movementController ){
            _player.shouldMove = YES;
            
            float xThird = _movementController.frame.size.width / 3;
            float leftEdge = _movementController.position.x - (_movementController.frame.size.width / 2);
            float rightEdge = _movementController.position.x + (_movementController.frame.size.width / 2);
            
            float yThird = _movementController.frame.size.height / 3;
            float bottomEdge = _movementController.position.y - (_movementController.frame.size.height / 2);
            float topEdge = _movementController.position.y + (_movementController.frame.size.height / 2);
            
            
            if (location.x <  _movementController.position.x) {
                _player.direction = 6;
            }
            if (location.x >  _movementController.position.x) {
                _player.direction = 2;
            }
            
            if (location.y <  (bottomEdge + yThird)) {
                _player.direction = 4;
                if (location.x <  (leftEdge + xThird)) {
                    _player.direction = 5;
                }
                if (location.x >  (rightEdge - xThird)) {
                    _player.direction = 3;
                }
            }
            if (location.y > (topEdge - yThird)) {
                _player.direction = 0;
                if (location.x <  (leftEdge + xThird)) {
                    _player.direction = 7;
                }
                if (location.x >  (rightEdge - xThird)) {
                    _player.direction = 1;
                }
            }
            
        }
        
        if(_player.direction != prevDir)
            [_player sendWithSocket:self.socket];

        if([self nodeAtPoint:location] == _changeWeaponController){
            NSLog(@"change weap");
        }
        if([self nodeAtPoint:location] == _shootController){
            [self fire];
        }
        
    }
}

-(void)fire{
    NSLog(@"SHOOT!");
    MovingObject *bullet = [MovingObject spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(20, 20)];;
    bullet.moveSpeed = _player.weapon.bulletSpeed;
    bullet.position = _player.position;
    bullet.direction = 2;
    bullet.roomRow = self.player.roomRow;
    bullet.roomColumn = self.player.roomColumn;
    //bullet.timeToLive =
    
    bullet.shouldMove = YES;
    [self.player setCannotDie:0];
    [session.movingObjects addObject:bullet];
    [self addChild:bullet];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self analyseTouchesWithArray:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _touches = _touches - (int)[touches count];
    
   // NSLog(@"Ended %d", _touches);
    if(_touches == 0)
        _player.shouldMove = NO;
    
    [_player sendWithSocket:self.socket];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [_player drawFrame];
    for (MovingObject *obj in session.movingObjects) // CHANGE TO DICT
    {
        [obj drawFrame];
        if (obj.roomRow == self.player.roomRow && obj.roomColumn == self.player.roomColumn)
            obj.hidden = NO;
        
        else
            obj.hidden = YES;
        
        if(obj.roomRow == self.player.roomRow && obj.roomColumn == self.player.roomColumn)
        { // IS IN SAME ROOM
            if (obj.position.x - self.player.position.x < self.player.frame.size.width &&
                obj.position.x - self.player.position.x > -self.player.frame.size.width &&
                obj.position.y - self.player.position.y < self.player.frame.size.height &&
                obj.position.y - self.player.position.y > -self.player.frame.size.height &&
                !self.player.protection && self.player.isAlive) {
                
//                self.player.isAlive = NO;
                if (![obj.type isEqualToString:@"player"]) {
                    NSLog(@"DEAD");
                    [obj removeFromParent];
                    [session.deletionQueue addObject:obj];
                }
                
            }
        }
    }
    
    for (MovingObject *obj in session.deletionQueue){
        [session.movingObjects removeObject:obj];
        [session.deletionQueue removeObject:obj];
    }
}

-(void)moveSelf:(NSArray*)array{ // move obj actually
    
}

-(void)tick{
    //NSLog(@"tick: %@", session.gameTimeString);
    
    _myLabel.text = [NSString stringWithFormat:@"column: %d, row: %d, time: %@",_player.roomColumn, _player.roomRow, [Tools formatDate:session.gameElapsedTime withFormat:@"mm:ss"]]; //HH:
    
}

@end
