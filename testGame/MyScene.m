//
//  MyScene.m
//  testGame
//
//  Created by Alex Bechmann on 14/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "MyScene.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        _map = [[Map alloc] init]; 
        TestMap *map = [[TestMap alloc] init];
        _map.rooms = map.rooms;

        NSLog(@"%@", _map.rooms);
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //BACKGROUND
        SKSpriteNode *bgImgView = [SKSpriteNode spriteNodeWithImageNamed:@"stone.png"];
        [self addChild:bgImgView];
        
        //SET PACMAN
        _player = [Player spriteNodeWithImageNamed:@"pacman.png"];
        _player.room = [[_map.rooms objectAtIndex:1]objectAtIndex:1];
        _player.roomColumn = 1;
        _player.roomRow = 1;
        _player.moveSpeed = 7;
        _player.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
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
            _shouldMove = YES;
            
            float xThird = _movementController.frame.size.width / 3;
            float leftEdge = _movementController.position.x - (_movementController.frame.size.width / 2);
            float rightEdge = _movementController.position.x + (_movementController.frame.size.width / 2);
            
            float yThird = _movementController.frame.size.height / 3;
            float bottomEdge = _movementController.position.y - (_movementController.frame.size.height / 2);
            float topEdge = _movementController.position.y + (_movementController.frame.size.height / 2);
            
            
            if (location.x <  _movementController.position.x) {
                _direction = 6;
            }
            if (location.x >  _movementController.position.x) {
                _direction = 2;
            }
            
            if (location.y <  (bottomEdge + yThird)) {
                _direction = 4;
                if (location.x <  (leftEdge + xThird)) {
                    _direction = 5;
                }
                if (location.x >  (rightEdge - xThird)) {
                    _direction = 3;
                }
            }
            if (location.y > (topEdge - yThird)) {
                _direction = 0;
                if (location.x <  (leftEdge + xThird)) {
                    _direction = 7;
                }
                if (location.x >  (rightEdge - xThird)) {
                    _direction = 1;
                }
            }
        }
        
        //NSLog(@"direction: %d", _direction);
        
        if([self nodeAtPoint:location] == _changeWeaponController){
            NSLog(@"change weap");
        }
        if([self nodeAtPoint:location] == _shootController){
            NSLog(@"SHOOT!");
        }
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self analyseTouchesWithArray:touches];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _touches = _touches - (int)[touches count];
   // NSLog(@"Ended %d", _touches);
    if(_touches == 0)
        _shouldMove = NO;
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    //HITS LEFT EDGE
    if(_player.position.x <0){
        _player.roomRow = _player.roomRow -1;
        
        if (_player.roomRow == -1) {
            _player.roomRow = (int)[[_map.rooms objectAtIndex:_player.roomColumn] count] -1;
        }
        _player.position = CGPointMake(self.frame.size.width, _player.position.y);
    }
    
    // HITES RIGHT EDGE
    else if(_player.position.x > self.frame.size.width){
        _player.roomRow = _player.roomRow +1;
         _player.position = CGPointMake(0, _player.position.y);
        
        if (_player.roomRow == (int)[[_map.rooms objectAtIndex:_player.roomColumn] count]) {
            _player.roomRow = 0;
        }
    }
    
    // HITS BOTTOM EDGE
    else if(_player.position.y < 222){
        _player.roomColumn = _player.roomColumn +1;
        _player.position = CGPointMake(_player.position.x, 802);
        
        if (_player.roomColumn == (int)[_map.rooms count]) {
            _player.roomColumn = 0;
        }
    }
    
    // HITS TOP EDGE
    else if(_player.position.y > 802){
        _player.roomColumn = _player.roomColumn -1;
        _player.position = CGPointMake(_player.position.x, 222);
        
        if (_player.roomColumn == -1) {
            _player.roomColumn =(int)[_map.rooms count]-1;
        }
        
    }
    
    _myLabel.text = [NSString stringWithFormat:@"Room:column: %d, row: %d",_player.roomColumn, _player.roomRow];
    
    if (_shouldMove) {
        switch (_direction) {
            case 0: //N
                _player.position = CGPointMake(_player.position.x, (_player.position.y + _player.moveSpeed));
                break;
                
            case 1: //NE
                _player.position = CGPointMake(_player.position.x, (_player.position.y + _player.moveSpeed));
                _player.position = CGPointMake((_player.position.x + _player.moveSpeed), _player.position.y);
                break;
                
            case 2: //E
                _player.position = CGPointMake((_player.position.x + _player.moveSpeed), _player.position.y);
                break;
                
            case 3: //SE
                _player.position = CGPointMake(_player.position.x, (_player.position.y - _player.moveSpeed));
                _player.position = CGPointMake((_player.position.x + _player.moveSpeed), _player.position.y);
                break;
                
            case 4: //S
                _player.position = CGPointMake(_player.position.x, (_player.position.y - _player.moveSpeed));
                break;
                
            case 5: //SW
                _player.position = CGPointMake(_player.position.x, (_player.position.y - _player.moveSpeed));
                _player.position = CGPointMake((_player.position.x - _player.moveSpeed), _player.position.y);
                break;
                
            case 6: //W
                _player.position = CGPointMake((_player.position.x - _player.moveSpeed), _player.position.y);
                break;
                
            case 7: //NW
                _player.position = CGPointMake(_player.position.x, (_player.position.y + _player.moveSpeed));
                _player.position = CGPointMake((_player.position.x - _player.moveSpeed), _player.position.y);
                break;
                
            default:
                break;
        }
    }
}

@end
