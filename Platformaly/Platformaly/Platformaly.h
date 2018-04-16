//
//  Platformaly.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>
#import "PlatformalyView.h"

@class Platformaly;

@protocol PlatformalyDelegate <NSObject>

@optional
- (void)platformalyWillShowAuthorization:(Platformaly*)platformaly;
- (void)platformalyDidShowAuthorization:(Platformaly *)platformaly;

- (void)platformalyWillDissmisAuthorization:(Platformaly *)platformaly;
- (void)platformalyDidDissmisAuthorization:(Platformaly *)platformaly;

- (void)platformaly:(Platformaly*)platformaly authorizedWithToken:(NSString*)token;
- (void)platformaly:(Platformaly *)platformaly failedWithError:(NSError*)error;

@end

@interface Platformaly : NSObject

@property (weak, nonatomic) id<PlatformalyDelegate> delegate;
@property (strong, nonatomic) UIViewController* parentViewController;
@property (copy, nonatomic) NSString* clientID;

+ (instancetype)sharedInstace;
- (void)configurePlaytformalyView:(PlatformalyView*)platformalyView;

@end
