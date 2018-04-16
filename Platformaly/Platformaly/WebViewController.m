//
//  WebViewController.m
//  PlatformalyExample
//


#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView* webView;

@end

@implementation WebViewController

- (void)startAuthorization:(NSString *)authorizationURL
{
    NSURL* authUrl = [NSURL URLWithString:authorizationURL];
    NSURLRequest* request = [NSURLRequest requestWithURL:authUrl];
    [self.webView loadRequest:request];
}

#pragma mark - IBactions

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSURL *newURL = [[NSURL alloc] initWithScheme:[url scheme]
                                             host:[url host]
                                             path:[url path]];
    NSString *urlString = [newURL absoluteString];
    if ([urlString isEqualToString:@"https://oauth.platformaly.ru/blank.html"]) {
        
        NSString* redirectedStr = [url absoluteString];
        NSArray* paramsStr = [[[redirectedStr componentsSeparatedByString:@"?"] lastObject] componentsSeparatedByString:@"&"];
        for (NSString* parameterStr in paramsStr) {
            NSArray* parameterArray = [parameterStr componentsSeparatedByString:@"="];
            if ([[parameterArray firstObject] isEqualToString:@"access_token"]) {
                if (self.delegate && [self.delegate respondsToSelector:@selector(webViewController:receivedAuthToken:)]) {
                    [self.delegate webViewController:self receivedAuthToken:[parameterArray lastObject]];
                }
            }
            break;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(webViewWillDissmiss:)]) 
            [self.delegate webViewWillDissmiss:self];

        [self dismissViewControllerAnimated:YES completion:^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidDissmiss:)])
                [self.delegate webViewDidDissmiss:self];
        }];
            
        return NO;
    }
    return YES;
}

@end
