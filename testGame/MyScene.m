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
        _player = [MovingObject spriteNodeWithImageNamed:@"pacman.png"];
        _player.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
        _player.roomColumn = 1;
        _player.roomRow = 1;
        _player.moveSpeed = 11;
        _player.isAlive = YES;
        _player.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        _player.type = @"player";
        
        //_player.map = self.map;
        //_player.frameP = self.frame;
        
        Weapon *weapon = [[Weapon alloc] init];
        weapon.bulletSpeed = 15;
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
            
            _player.changeDirectionPosition = _player.position;
            _player.changeTimeStamp = session.gameElapsedTime;
        }

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
    bullet.direction = 2;
    bullet.roomRow = self.player.roomRow;
    bullet.roomColumn = self.player.roomColumn;
    //bullet.timeToLive =
    bullet.position = _player.position;
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
                 NSLog(@"DEAD");
//                self.player.isAlive = NO;
//                if (![obj.type isEqualToString:@"player"]) {
//                    [obj removeFromParent];
//                    [session.deletionQueue addObject:obj];
//                }
                
            }
        }
    }
    
    for (MovingObject *obj in session.deletionQueue){
        [session.movingObjects removeObject:obj];
        [session.deletionQueue removeObject:obj];
    }
}

-(void)moveSelf:(NSArray*)array{
    for (NSArray *array in session.taskLog) {
        
        if( _c == 0 ) // IF OBJECT ID DOESNT EXIST
        {
            MovingObject *obj = [Player spriteNodeWithImageNamed:@"pacman.png"];
            obj.room = [[self.map.rooms objectAtIndex:1]objectAtIndex:1];
            obj.roomColumn = 1;
            obj.roomRow = 1;
            obj.moveSpeed = 11;
            obj.isAlive = YES;
            obj.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
            obj.type = @"player";
            [self addChild:obj];
            [session.movingObjects addObject:obj];
            [session.movingObjectsDictionary setValue:obj forKey:@"1"];
            _c++;
        }
        
        else{
            MovingObject *obj = [session.movingObjectsDictionary objectForKey:@"1"];
            obj.room = [array objectAtIndex:0];
            obj.moveSpeed = [[array objectAtIndex:1] intValue];
            obj.direction = [[array objectAtIndex:2] intValue];
            obj.roomColumn = [[array objectAtIndex:3] intValue];
            obj.roomRow = [[array objectAtIndex:4] intValue];
            obj.shouldMove = YES;
            [session.taskDeletionQueue addObject:array];
            NSLog(@"perform task");
        }
    }
    
    for (NSArray *task in session.taskDeletionQueue){
        [session.taskLog removeObject:task];
    }
}

-(void)tick{
    //NSLog(@"tick: %@", session.gameTimeString);
    
    _myLabel.text = [NSString stringWithFormat:@"column: %d, row: %d, time: %@",_player.roomColumn, _player.roomRow, [Tools formatDate:session.gameElapsedTime withFormat:@"mm:ss"]]; //HH:
    
}

@end
