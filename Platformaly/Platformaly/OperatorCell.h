//
//  OperatorCell.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>
#import "Operator.h"

@interface OperatorCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *operatorImageView;

- (void)configureWithOperator:(Operator*)operator;

@end
