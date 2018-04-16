//
//  PlatformalyData.h
//  PlatformalyExample
//
//  Created by Nikita Demidov on 29/04/16.
//  Copyright © 2016 Nikita Demidov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Operator.h"

@interface PlatformalyData : NSObject

@property (copy, nonatomic) NSString* phone;
@property (copy, nonatomic) NSString* userIP;
@property (copy, nonatomic) NSString* accessMethod;
@property (copy, nonatomic) NSString* mnc;
@property (copy, nonatomic) NSString* tmpCode;
@property (strong, nonatomic) Operator* operator;
@property (nonatomic) BOOL authed;

- (instancetype)initWithDict:(NSDictionary*)dict;
- (NSString*)platformalyData;

@end
