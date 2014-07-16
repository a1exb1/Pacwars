//
//  Weapon.h
//  testGame
//
//  Created by Alex Bechmann on 16/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Skin.h"

@interface Weapon : NSObject

@property Skin *skin;
@property NSString *name;
@property float fireRate;
@property float ammo;
@property float maxAmmo;
@property float bulletSpeed;

@end
