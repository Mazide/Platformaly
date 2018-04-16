//
//  PlatformalyData.m
//  PlatformalyExample
//
//  Created by Nikita Demidov on 29/04/16.
//  Copyright © 2016 Nikita Demidov. All rights reserved.
//

#import "PlatformalyData.h"
#import "NSDictionary+SafeAccess.h"

@implementation PlatformalyData

- (instancetype)initWithDict:(NSDictionary *)dict
{
    NSLog(@"dict %@", dict);
    self = [super init];
    if (self) {
        Class stringClass = [NSString class];
        _phone        = [dict valueForKey:@"twoDigits" ifKindOf:stringClass defaultValue:@""];
        _userIP       = [dict valueForKey:@"userIp" ifKindOf:stringClass defaultValue:@""];
        _accessMethod = [dict valueForKey:@"accessMethod" ifKindOf:stringClass defaultValue:@""];
        _mnc          = [dict valueForKey:@"mnc" ifKindOf:stringClass defaultValue:@""];
        _tmpCode      = [dict valueForKey:@"tmpCode" ifKindOf:stringClass defaultValue:@""];
        
        NSString* operatorName = [dict valueForKey:@"operator" ifKindOf:stringClass defaultValue:@""];
        _operator = [Operator operatorByName:operatorName];
    }
    return self;
}

- (NSString *)platformalyData
{
    NSString* operatorName = [Operator operatorName:self.operator.type];
    NSString* fast = self.authed ? @"true" : @"false";
    NSString *data_str = [NSString stringWithFormat:@"operator=%@\r\nfast=%@\r\nremember=true", operatorName, fast];
    NSString *data = [self encodeStringTo64:data_str];
    return data;
}

- (BOOL)authed
{
    return _phone.length != 0;
}

- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = nil;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    }
    
    return base64String;
}

@end
