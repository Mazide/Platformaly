//
//  NSDictionary+SafeAccess.h
//  
//
//  http://www.stewgleadow.com/blog/2012/05/18/tolerant-json-parsing-for-ios/
//  
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeAccess)

- (id)valueForKey:(NSString *)key ifKindOf:(Class)class defaultValue:(id)defaultValue;

@end
