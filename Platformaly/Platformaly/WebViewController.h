//
//  WebViewController.h
//  PlatformalyExample
//


#import <UIKit/UIKit.h>
#import "Operator.h"

@class WebViewController;

@protocol WebViewControllerDelegate <NSObject>

- (void)webViewController:(WebViewController*)webViewController receivedAuthToken:(NSString*)token;
- (void)webViewWillDissmiss:(WebViewController*)webViewController;
- (void)webViewDidDissmiss:(WebViewController*)webViewController;

@end

@interface WebViewController : UIViewController

@property (weak, nonatomic) id<WebViewControllerDelegate> delegate;

- (void)startAuthorization:(NSString*)authorizationURL;

@end
