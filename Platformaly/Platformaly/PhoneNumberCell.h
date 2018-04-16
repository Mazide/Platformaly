//
//  PhoneNumberCell.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>
#import "PlatformalyData.h"

@interface PhoneNumberCell : UICollectionViewCell

- (void)configureWithPlatformalyData:(PlatformalyData*)platformalyData;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *authByNumberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *operatorImageView;

@end
