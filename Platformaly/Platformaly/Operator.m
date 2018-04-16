//
//  Operator.m
//  PlatformalyExample
//


#import "Operator.h"

@implementation Operator

- (instancetype)initWithImage:(UIImage *)image altImage:(UIImage*)altImage type:(OperatorType)type
{
    self = [super init];
    if (self) {
        _image = image;
        _type  = type;
        _altImage = altImage;
    }
    return self;
}

+ (Operator*)mts
{
    Operator* mts = [[Operator alloc] initWithImage:[UIImage imageNamed:@"mts_icon"] altImage:[UIImage imageNamed:@"mts_alt"] type:MTS];
    return mts;
}

+ (Operator*)tele2
{
    Operator* tele2    = [[Operator alloc] initWithImage:[UIImage imageNamed:@"tele2_icon"] altImage:[UIImage imageNamed:@"tele2_alt"] type:TELE2];
    return tele2;
}

+ (Operator*)megafon
{
    Operator* megafone = [[Operator alloc] initWithImage:[UIImage imageNamed:@"megafon_icon"] altImage:[UIImage imageNamed:@"megafon_alt"] type:MEGAFONE];
    return megafone;
}

+ (Operator*)beeline
{
    Operator* beeline  = [[Operator alloc] initWithImage:[UIImage imageNamed:@"beeline_icon"] altImage:[UIImage imageNamed:@"beeline_alt"] type:BEELINE];
    return beeline;
}


+ (Operator*)operatorByName:(NSString*)operatorName;
{
    OperatorType type = UnknowOperator;
    NSString* iconName = [operatorName stringByAppendingString:@"_icon"];
    NSString* iconAltName = [operatorName stringByAppendingString:@"_alt"];
    UIImage* icon = [UIImage imageNamed:iconName];
    UIImage* iconAlt = [UIImage imageNamed:iconAltName];
    if ([operatorName isEqualToString:@"mts"]) {
        type = MTS;
    } else if ([operatorName isEqualToString:@"tele2"]) {
        type = TELE2;
    } else if ([operatorName isEqualToString:@"megafon"]) {
        type = MEGAFONE;
    } else if ([operatorName isEqualToString:@"beeline"]) {
        type = BEELINE;
    }
    
    Operator* operator = nil;
    if (operatorName.length == 0) {
        operator = nil;
    } else {
        operator = [[Operator alloc] initWithImage:icon altImage:iconAlt type:type];
    }
    return operator;
}

+ (NSString*)operatorName:(OperatorType)type
{
    NSString* operatorName = @"";
    switch (type) {
        case MTS:
            operatorName = @"mts";
            break;
        case TELE2:
            operatorName = @"tele2";
            break;
        case MEGAFONE:
            operatorName = @"megafon";
            break;
        case BEELINE:
            operatorName = @"beeline";
            break;
        default:
            break;
    }
    return operatorName;
}


@end
