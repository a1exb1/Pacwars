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
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        //BACKGROUND
        SKSpriteNode *bgImgView = [SKSpriteNode spriteNodeWithImageNamed:@"stone.png"];
        [self addChild:bgImgView];
        
        //SET PACMAN
        _player = [Player spriteNodeWithImageNamed:@"pacman.png"];
        _player.room = 3;
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
        
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = [NSString stringWithFormat:@"Room: %f", _player.room];
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    _shouldMove = YES;
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //NSString *yCoord = @"";
        if([self nodeAtPoint:location] == _movementController ){
            
            NSString *xDirection = @"";
            NSString *yDirection = @"";
            float xThird = _movementController.frame.size.width / 3;
            float leftEdge = _movementController.position.x - (_movementController.frame.size.width / 2);
            float rightEdge = _movementController.position.x + (_movementController.frame.size.width / 2);
            
            float yThird = _movementController.frame.size.height / 3;
            float bottomEdge = _movementController.position.y - (_movementController.frame.size.height / 2);
            float topEdge = _movementController.position.y + (_movementController.frame.size.height / 2);
            
            
            if (location.x <  _movementController.position.x) {
                 xDirection = @"w";
            }
            if (location.x >  _movementController.position.x) {
                xDirection = @"e";
            }
            
            if (location.y <  (bottomEdge + yThird)) {
                yDirection = @"s";
                xDirection = @"";
                if (location.x <  (leftEdge + xThird)) {
                    xDirection = @"w";
                }
                if (location.x >  (rightEdge - xThird)) {
                    xDirection = @"e";
                }
            }
            if (location.y >  (topEdge - yThird)) {
                yDirection = @"n";
                xDirection = @"";
                if (location.x <  (leftEdge + xThird)) {
                    xDirection = @"w";
                }
                if (location.x >  (rightEdge - xThird)) {
                    xDirection = @"e";
                }
            }
            
            _direction = [NSString stringWithFormat:@"%@%@", yDirection, xDirection];
            NSLog(@"%@", xDirection);
            
        }
        
        
        if([self nodeAtPoint:location] == _changeWeaponController){
            NSLog(@"change weap");
        }
        if([self nodeAtPoint:location] == _shootController){
            NSLog(@"SHOOT!");
        }

        
        
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        //sprite.position = location;
        
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        //[sprite runAction:[SKAction repeatActionForever:action]];
        
        //[self addChild:sprite];
    }
    _touches = _touches + (int)[touches count];
    NSLog(@"started %d", _touches);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //NSString *yCoord = @"";
        if([self nodeAtPoint:location] == _movementController ){
            
            NSString *xDirection = @"";
            NSString *yDirection = @"";
            float xThird = _movementController.frame.size.width / 3;
            float leftEdge = _movementController.position.x - (_movementController.frame.size.width / 2);
            float rightEdge = _movementController.position.x + (_movementController.frame.size.width / 2);
            
            float yThird = _movementController.frame.size.height / 3;
            float bottomEdge = _movementController.position.y - (_movementController.frame.size.height / 2);
            float topEdge = _movementController.position.y + (_movementController.frame.size.height / 2);
            
            
            if (location.x <  _movementController.position.x) {
                xDirection = @"w";
            }
            if (location.x >  _movementController.position.x) {
                xDirection = @"e";
            }
            
            if (location.y <  (bottomEdge + yThird)) {
                yDirection = @"s";
                xDirection = @"";
                if (location.x <  (leftEdge + xThird)) {
                    xDirection = @"w";
                }
                if (location.x >  (rightEdge - xThird)) {
                    xDirection = @"e";
                }
            }
            if (location.y >  (topEdge - yThird)) {
                yDirection = @"n";
                xDirection = @"";
                if (location.x <  (leftEdge + xThird)) {
                    xDirection = @"w";
                }
                if (location.x >  (rightEdge - xThird)) {
                    xDirection = @"e";
                }
            }
            
            _direction = [NSString stringWithFormat:@"%@%@", yDirection, xDirection];
            NSLog(@"%@", xDirection);
            
        }
        
        
        if([self nodeAtPoint:location] == _changeWeaponController){
            NSLog(@"change weap");
        }
        if([self nodeAtPoint:location] == _shootController){
            NSLog(@"SHOOT!");
        }
        
        
        
        
        //SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        //sprite.position = location;
        
        //SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        //[sprite runAction:[SKAction repeatActionForever:action]];
        
        //[self addChild:sprite];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _touches = _touches - (int)[touches count];
    NSLog(@"Ended %d", _touches);
    if(_touches == 0)
        _shouldMove = NO;
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    self.speed = 5;
    NSString *offScreen;
    
    if(_player.position.x <0){
        offScreen = @"w";
    }
    else if(_player.position.x > self.frame.size.width){
        offScreen = @"e";
    }
    else if(_player.position.y <222){
        offScreen = @"s";
    }
    else if(_player.position.y > 802){
        offScreen = @"n";
    }
    
    if (_shouldMove) {
        if([Tools string:_direction containsString:@"e"] && ![offScreen isEqualToString:@"e"]){
            _player.position = CGPointMake((_player.position.x + _player.moveSpeed), _player.position.y);
        }
        else if([Tools string:_direction containsString:@"w"] && ![offScreen isEqualToString:@"w"]){
            _player.position = CGPointMake((_player.position.x - _player.moveSpeed), _player.position.y);
        }
        
        
        if([Tools string:_direction containsString:@"n"] && ![offScreen isEqualToString:@"n"]){
            _player.position = CGPointMake(_player.position.x, (_player.position.y + _player.moveSpeed));
        }
        
        else if([Tools string:_direction containsString:@"s"] && ![offScreen isEqualToString:@"s"]){
            _player.position = CGPointMake(_player.position.x, (_player.position.y - _player.moveSpeed));
        }
    }
}

@end
