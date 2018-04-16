//
//  NSDictionary+SafeAccess.m
//  HotelLook
//


#import "NSDictionary+SafeAccess.h"

@implementation NSDictionary (SafeAccess)

- (id)valueForKey:(NSString *)key ifKindOf:(Class)class defaultValue:(id)defaultValue
{
    id obj = [self objectForKey:key];
    return [obj isKindOfClass:class] ? obj : defaultValue;
}

@end
