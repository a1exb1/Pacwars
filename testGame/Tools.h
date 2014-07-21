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
+(NSString *)formatDate:(NSDate *)Date withFormat:(NSString *)format;
+(NSDate *)beginningOfDay:(NSDate *)date;
+(NSDate *)dateAsTimeSpanBetween:(NSDate*)date1 and: (NSDate*)date2;
+(NSDate *)dateFromString:(NSString*)str withFormat: (NSString *)format;
+(NSString*)standardDateFormat;
+(UIImage*)colorAnImage:(UIColor*)color :(UIImage*)image;
@end
