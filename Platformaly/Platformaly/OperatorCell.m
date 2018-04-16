//
//  OperatorCell.m
//  PlatformalyExample
//


#import "OperatorCell.h"

@implementation OperatorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureWithOperator:(Operator *)operator
{
    self.operatorImageView.image = operator.image;
}

@end
