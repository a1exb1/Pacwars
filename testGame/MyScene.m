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
        self.map.backgroundNodes = map.backgroundNodes;        
        
        session.map = self.map;
        session.sceneFrame = self.frame;
        [session startGame];
        session.delegate = self;
        //self.frame = self.view.frame;
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //BACKGROUND
        for (NSMutableArray *row in session.map.rooms){
            for (Room *room in row){
                room.bgNode.hidden = YES;
                [self addChild:room.bgNode];
                
                for (Object *obj in room.objects){
                    [self addChild:obj];
                    obj.hidden = YES;
                }
            }
        }
        
        //SET PACMAN
        UIImage *img = [Tools colorAnImage:[UIColor yellowColor] :[UIImage imageNamed:@"pacman.png"]];
        SKTexture *texture = [SKTexture textureWithImage:img];
        _player = [MovingObject spriteNodeWithTexture:texture];
        [_player registerAsPlayer];
        session.activePlayerID = _player.objectID;
        _player.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
        _player.roomColumn = 1;
        _player.roomRow = 1;
        _player.moveSpeed = 7;
        _player.isAlive = YES;
        _player.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        _player.canShoot = YES;
        _player.ShootDirection = 2;
        _player.type = @"player";
        //[_player addUpdateTimer];
        
        Weapon *weapon = [[Weapon alloc] init];
        weapon.bulletSpeed = 25;
        weapon.fireRate = 0.8;
        _player.weapon = weapon;
        //[self addChild:_player];
        session.activePlayer = _player;
        
        //CONTROLS
        _shootController = [SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(100, 100)];
        _shootController.position = CGPointMake(self.size.width - 50, 300);
        [self addChild:_shootController];
        _shootController.zPosition = 5;
        _shootController.alpha = 0.5;
        
        _changeWeaponController = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(100, 100)];
        _changeWeaponController.position = CGPointMake(self.size.width - 50, 200);
        [self addChild:_changeWeaponController];
        _changeWeaponController.zPosition = 5;
        _changeWeaponController.alpha = 0.5;
        
        
        _movementController = [SKSpriteNode spriteNodeWithImageNamed:@"movement1.png"];
        _movementController.position = CGPointMake(150, 225);
        [self addChild:_movementController];
        _movementController.zPosition = 5;
        _movementController.alpha = 0.4;
        
        //OPACITY
        _myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _myLabel.fontSize = 30;
        _myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       self.frame.size.height - 50);
        //_myLabel.tex
        
        [self addChild:_myLabel];
        
        //SOCKET
        [SIOSocket socketWithHost: @"http://217.155.211.203:3000" response: ^(SIOSocket *socket) //http://pwserver.nodejitsu.com:80
         
         
         {
             session.socket = socket;
             //__weak typeof(self) weakSelf = self;
             session.socket.onConnect = ^()
             {
                 //weakSelf.socketIsConnected = YES;
                 NSLog(@"connected");
                 NSString *urlString = [NSString stringWithFormat:@"4,%li", self.player.objectID];
                 [socket emit:@"chatmessage", urlString, nil];
             };
             
             [session.socket on: @"chatmessage" do: ^(id msg)
              {
                  //NSData* data = [msg dataUsingEncoding:NSUTF8StringEncoding];
                
                  NSString *arrayString = msg;
                  NSArray *list = [arrayString componentsSeparatedByString:@","];
                  
                  //[weakSelf moveSelf:list];
                  [session.taskLog addObject:list];
                  
                  //NSLog(@"message: %@", msg);
                  
                  for (NSArray *array in session.taskLog) {
                      //NSString *a = [NSString stringWithFormat:@"%ld", _player.objectID];
                      long objid = [[array objectAtIndex:1] intValue];
                      int tasktype = [[array objectAtIndex:0] intValue];
                      
                      if ((int)_player.objectID != objid) {
                          
                          if( ![session.movingObjectsDictionary objectForKey:[array objectAtIndex:1]]) // IF OBJECT ID DOESNT EXIST
                          {
                              UIImage *img = [Tools colorAnImage:[UIColor redColor] :[UIImage imageNamed:@"pacman.png"]];
                              SKTexture *texture = [SKTexture textureWithImage:img];
                              MovingObject *obj = [MovingObject spriteNodeWithTexture:texture];
                              
                              obj.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
                              obj.roomColumn = 1;
                              obj.roomRow = 1;
                              obj.moveSpeed = 11; // ??
                              //[obj registerAsPlayer];
                              obj.objectID = objid;
                              obj.isAlive = YES;
                              obj.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
                              obj.type = @"player";
                              obj.objectKey = [NSString stringWithFormat:@"%ld", obj.objectID];
                              [self addChild:obj];
                              
                              Weapon *weapon = [[Weapon alloc] init];
                              weapon.bulletSpeed = 25;
                              obj.weapon = weapon;
                              
                              [session.movingObjects addObject:obj];
                              [session.movingObjectsDictionary setValue:obj forKey:obj.objectKey];
                              _c++;
                          }
                          
                          else{

                              //float secondsBetween = [[Tools dateFromString:[array objectAtIndex:7] withFormat:[Tools standardDateFormat]] timeIntervalSinceDate:session.gameElapsedTime];
                              //NSLog(@"%f", secondsBetween);
                              //if (secondsBetween < 0.01 || secondsBetween > -0.01) {
                              
                              //NSDictionary *dict = session.movingObjectsDictionary;
                              
                              MovingObject *obj = [session.movingObjectsDictionary objectForKey:[NSString stringWithFormat:@"%ld", objid]];
                              switch (tasktype) {
                                  case 1:
                                      obj.moveSpeed = [[array objectAtIndex:3] intValue];
                                      obj.direction = [[array objectAtIndex:4] intValue];
                                      obj.roomColumn = [[array objectAtIndex:5] intValue];
                                      obj.roomRow = [[array objectAtIndex:6] intValue];
                                      obj.changeDirectionPosition = CGPointMake([[array objectAtIndex:7] intValue], [[array objectAtIndex:8] intValue]);
                                      obj.position = obj.changeDirectionPosition;
                                      //obj.changeTimeStamp = [Tools dateFromString:[array objectAtIndex:9] withFormat:[Tools standardDateFormat]];

                                      //NSLog(@"%@", [array objectAtIndex:2]);
                                      
                                      if ([[array objectAtIndex:2] isEqualToString:@"1"])
                                          obj.shouldMove = YES;
                                      
                                      else{
                                          obj.shouldMove = NO;
                                      }
                                      
                                      break;
                                      
                                  case 2:
                                      obj.ShootDirection = [[array objectAtIndex:4]intValue];
                                      [obj fireFromScene:self andPosition:CGPointMake([[array objectAtIndex:2]intValue], [[array objectAtIndex:3]intValue])];

                                      break;
                                      
                                  case 3:
                                      NSLog(@"%li %li", objid, self.player.objectID);
                                      if ([[array objectAtIndex:2]intValue] == (int)self.player.objectID){
                                          self.player.points++;
                                      }

                                  default:
                                      break;
                              }
                              
                              [session.taskDeletionQueue addObject:array];
                              
                              //NSLog(@"%f, %f", obj.position.x, obj.position.y);
                              
                              // [UIView commitAnimations];
                              //}
                              
                          }
                          
                          
                      }
                      else{
                          int tasktype = [[array objectAtIndex:0] intValue];
                          
                          switch (tasktype) {
                              case 3:
                                  if ([[array objectAtIndex:2]intValue] != (int)self.player.objectID && tasktype ==3){
                                      self.player2Score++;
                                  }
                                  break;
                                  
                              case 4:
                                  [self addChild:_player];
                                  break;
                                  
                              default:
                                  break;
                          }
                          
                          
                          
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
    //for (UITouch *touch in touches) {
    
    UITouch *touch = [touches anyObject];
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
        [_player sendWithSocket:session.socket];

    if([self nodeAtPoint:location] == _changeWeaponController){
        NSLog(@"change weap");
        //[session.movingObjects removeObjectsAtIndexes:session.discardedItems];
        
        //use index's instead.
        for( int i = (int)[session.movingObjects count]-1; i >=0; --i)
        {
            MovingObject *obj = [session.movingObjects objectAtIndex:i];
            if( obj.isDead )
            {
                [session.movingObjects removeObjectAtIndex:i];
            }
        }
        //
        
    }
    if([self nodeAtPoint:location] == _shootController){
        if (self.player.canShoot) {
            [self.player fireToSocket:session.socket];
            [self.player fireFromScene:self andPosition:self.player.position];
        }
        
    }
    //}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self analyseTouchesWithArray:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    _touches = _touches - (int)[touches count];
    
   // NSLog(@"Ended %d", _touches);
    if(_touches == 0)
        _player.shouldMove = NO;
    
    [_player sendWithSocket:session.socket];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [_player drawFrame];
    
    //MAP (ROOM)
    if (session.currentRoomColumn != self.player.roomColumn ||
        session.currentRoomRow != self.player.roomRow) {
        //[_bgImgView removeFromParent];
        
        for (NSMutableArray *row in session.map.rooms){
            for (Room *room in row){
                room.bgNode.hidden = YES;
                
                for (Object *obj in room.objects){
                    obj.hidden = YES;
                }
            }
        }
        
        Room *newRoom = [[session.map.rooms objectAtIndex:self.player.roomColumn]objectAtIndex:self.player.roomRow];
        newRoom.bgNode.zPosition = -2;
        newRoom.bgNode.hidden = NO;
        
        for (Object *obj in newRoom.objects){
            obj.hidden = NO;
        }
        
        session.currentRoomColumn = self.player.roomColumn;
        session.currentRoomRow = self.player.roomRow;
        session.currentRoom = newRoom;

    }
    
    for (MovingObject *obj in session.movingObjects) // CHANGE TO DICT
    {
        [obj drawFrame];
        if (obj.roomRow == self.player.roomRow && obj.roomColumn == self.player.roomColumn)
            obj.hidden = NO;
        
        else
            obj.hidden = YES;
        
        
        if ([obj.type isEqualToString:@"bullet"]) {
//            if(obj.roomRow == self.player.roomRow && obj.roomColumn == self.player.roomColumn)
//            { // IS IN SAME ROOM
//                if (obj.position.x - self.player.position.x < self.player.frame.size.width &&
//                    obj.position.x - self.player.position.x > -self.player.frame.size.width &&
//                    obj.position.y - self.player.position.y < self.player.frame.size.height &&
//                    obj.position.y - self.player.position.y > -self.player.frame.size.height &&
//                    !self.player.protection && self.player.isAlive) {
//                    
//                    //self.player.isAlive = NO;
//                    //if (![obj.type isEqualToString:@"player"]) {
//                    [obj remove];
//                    [session.deletionQueue addObject:obj];
//                    [obj dieToSocket:self.socket];
//                    self.player2Score++;
//                    //}
//                }
//            }
        }
    }
    
    //NSLog(@"%@", session.discardedItems);
    //[session.movingObjects removeObjectsInArray:session.deletionQueue];
    //[session.movingObjects removeObjectsAtIndexes:session.discardedItems];
    
    
    // not wokring
//    for (MovingObject *obj in session.deletionQueue){
//        
//        
//        for (MovingObject *obj2 in session.movingObjects){
//            if(obj.objectID == obj2.objectID){
//                [session.movingObjects removeObject:obj2];
//            }
//        }
//        
//        [session.movingObjects removeObject:obj];
//        [session.deletionQueue removeObject:obj];
//        
    //}
    
    for( int i = (int)[session.movingObjects count]-1; i >=0; --i)
    {
        MovingObject *obj = [session.movingObjects objectAtIndex:i];
        if( obj.isDead )
        {
            [session.movingObjects removeObjectAtIndex:i];
        }
    }
    
    
}

-(void)moveSelf:(NSArray*)array{ // move obj actually
    
}

-(void)tick{
    //NSLog(@"tick: %@", session.gameTimeString);
    
    _myLabel.text = [NSString stringWithFormat:@"time: %@ | You: %li, Player2: %li", [Tools formatDate:session.gameElapsedTime withFormat:@"mm:ss"], self.player.points, _player2Score]; //HH:
    
}

@end
