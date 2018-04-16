//
//  Operator.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UnknowOperator = 0,
    MTS      = 1,
    TELE2    = 2,
    MEGAFONE = 3,
    BEELINE  = 4
} OperatorType;

@interface Operator : NSObject

@property (strong, nonatomic) UIImage* image;
@property (strong, nonatomic) UIImage* altImage;
@property (nonatomic) OperatorType type;

+ (Operator*)operatorByName:(NSString*)operatorName;
+ (NSString*)operatorName:(OperatorType)type;

+ (Operator*)mts;
+ (Operator*)tele2;
+ (Operator*)megafon;
+ (Operator*)beeline;


- (instancetype)initWithImage:(UIImage *)image altImage:(UIImage*)altImage type:(OperatorType)type;

@end
