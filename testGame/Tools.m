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

+(NSString *)formatDate:(NSDate *)Date withFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *stringFromDate = [formatter stringFromDate:Date];
    return stringFromDate;
}

+(NSDate *)beginningOfDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    return [calendar dateFromComponents:comp];
}

+(NSDate *)dateAsTimeSpanBetween:(NSDate*)date1 and: (NSDate*)date2{
    float secondsBetween = -[date1 timeIntervalSinceDate:date2];
    NSDate *beginnningOfDay = [[self beginningOfDay:date1] dateByAddingTimeInterval:secondsBetween];
    return [beginnningOfDay dateByAddingTimeInterval:secondsBetween]; // - PING?
}

+(NSDate *)dateFromString:(NSString *)str withFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
    return [dateFormatter dateFromString: str];
}

+(NSString *)standardDateFormat{
    return @"dd:MM:yy HH:mm:ss:SSS";
}

@end
