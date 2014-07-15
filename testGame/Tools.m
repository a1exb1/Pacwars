//
//  Tools.m
//  testGame
//
//  Created by Alex Bechmann on 15/07/14.
//  Copyright (c) 2014 Bechmann Limited. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(bool)string: (NSString*) str containsString:(NSString*)containStr{
    if ([str rangeOfString:containStr].location != NSNotFound) {
        return true;
    }
    else{
        return false;
    }
}

@end
