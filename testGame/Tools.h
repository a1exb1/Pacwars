//
//  Tools.h
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "jsonReader.h"

@interface Tools : NSObject

+(bool)string: (NSString*) str containsString:(NSString*)containStr;

@end
