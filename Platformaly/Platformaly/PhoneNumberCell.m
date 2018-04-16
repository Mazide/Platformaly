//
//  PhoneNumberCell.m
//  PlatformalyExample
//


#import "PhoneNumberCell.h"

@implementation PhoneNumberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configureWithPlatformalyData:(PlatformalyData*)platformalyData;
{
    NSString* phoneStr = [NSString stringWithFormat:@"+7(***)***-**-%@", platformalyData.phone];
    self.phoneLabel.text = phoneStr;
    self.operatorImageView.image = platformalyData.operator.altImage;
}

@end
