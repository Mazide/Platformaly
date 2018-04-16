//
//  SelectOperatorView.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>
#import "Operator.h"
#import "PlatformalyData.h"

IB_DESIGNABLE

@class PlatformalyView;

@protocol PlatformalyViewDelegate <NSObject>

- (void)platformalyView:(PlatformalyView*)platformalyView didSelectOperator:(Operator*)operator;
- (void)platformalyView:(PlatformalyView*)platformalyView didSelectPlatformalyData:(PlatformalyData*)platformalyData;

@end

@interface PlatformalyView : UIView

@property (nonatomic) IBInspectable UIColor* platformalyBackgoundColor;
@property (nonatomic) IBInspectable UIColor* operatorCellBackgroundColor;
@property (nonatomic) IBInspectable UIColor* phoneCellBackgroundColor;
@property (nonatomic) IBInspectable UIColor* changeStateButtonBackgroundColor;
@property (nonatomic) IBInspectable UIColor* changeStateButtonLinesColor;
@property (nonatomic) IBInspectable UIColor* phoneTextColor;
@property (nonatomic) IBInspectable UIColor* phoneLabelTextColor;


- (void)configureWithOperators:(NSArray*)operators platformalyData:(PlatformalyData*)platformalyData delegate:(id<PlatformalyViewDelegate>)delegate;
- (void)orientationChanged;

@end
