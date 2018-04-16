//
//  Platformaly.m
//  PlatformalyExample
//


#import "Platformaly.h"
#import "WebViewController.h"
#import "PlatformalyData.h"

NSString* authUrl     = @"https://demo.platformaly.ru/authws/authorize";
NSString* redirectUrl = @"https://oauth.platformaly.ru/blank.html";
NSString* checkURL    = @"https://demo.platformaly.ru/fast/check";

@interface Platformaly() <PlatformalyViewDelegate, WebViewControllerDelegate>

@property (strong, nonatomic) PlatformalyView* platformalyView;
@property (strong, nonatomic) NSArray* operators;
@property (strong, nonatomic) PlatformalyData* platformaryData;

@end

@implementation Platformaly

#pragma mark - public

+ (instancetype)sharedInstace
{
    static Platformaly *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Platformaly alloc] init];
    });
    return sharedInstance;
}

- (void)configurePlaytformalyView:(PlatformalyView *)platformalyView
{
    self.platformalyView = platformalyView;
    [self checkAuthWithCompletionBlock:^(PlatformalyData *data) {
        self.platformaryData = data;
        
        [self.platformalyView configureWithOperators:self.operators platformalyData:data delegate:self];
    }];
}

- (void)startAuthorizationWithPlatphormalyData:(PlatformalyData*)platformalyData
{
    NSMutableString* authorizationURL = [NSMutableString new];
    [authorizationURL appendString:authUrl];
    [authorizationURL appendString:@"?"];
    [authorizationURL appendString:@"response_type=token"];
    [authorizationURL appendString:[NSString stringWithFormat:@"&client_id=%@", self.clientID]];
    [authorizationURL appendString:[NSString stringWithFormat:@"&redirect_uri=%@", redirectUrl]];
    
    NSString* state = [@(rand()) stringValue];
    [authorizationURL appendString:[NSString stringWithFormat:@"&state=%@", state]];
    [authorizationURL appendString:[NSString stringWithFormat:@"&platformaly_data=%@", [platformalyData platformalyData]]];
    
    UIStoryboard* platformalyStoryBoard = [UIStoryboard storyboardWithName:@"Platformaly" bundle:nil];
    UINavigationController* navVC = [platformalyStoryBoard instantiateInitialViewController];
    WebViewController* webViewController = [[navVC viewControllers] firstObject];
    webViewController.delegate = self;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyWillShowAuthorization:)]) {
        [self.delegate platformalyWillShowAuthorization:self];
    }
    
    [self.parentViewController presentViewController:navVC animated:YES completion:^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyDidShowAuthorization:)]) {
            [self.delegate platformalyDidShowAuthorization:self];
        }
        [webViewController startAuthorization:authorizationURL];
    }];
}

- (void)checkAuthWithCompletionBlock:(void (^)(PlatformalyData* data))completionBlock
{
    NSURL *URL = [NSURL URLWithString:checkURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"en-US;q=1" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary* testDict = @{@"twoDigits" : @"32",
                           @"userIp" : @"192.168.39.101",
                           @"accessMethod" : @"SESSION",
                           @"mnc" : @"213",
                           @"tmpCode" : @"214",
                           @"operator" : @"mts"};
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            PlatformalyData* data = [[PlatformalyData alloc] initWithDict:testDict];
            completionBlock(data);
        });
    }];
    [dataTask resume];
}

#pragma mark - PlatformalyViewDelegate

- (void)platformalyView:(PlatformalyView *)platformalyView didSelectOperator:(Operator *)operator
{
    PlatformalyData* data = [PlatformalyData new];
    data.operator = operator;
    [self startAuthorizationWithPlatphormalyData:data];
}

- (void)platformalyView:(PlatformalyView *)platformalyView didSelectPlatformalyData:(PlatformalyData *)platformalyData
{
    [self startAuthorizationWithPlatphormalyData:platformalyData];
}

#pragma mark - WebViewControllerDelegate

- (void)webViewController:(WebViewController *)webViewController receivedAuthToken:(NSString *)token
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(platformaly:authorizedWithToken:)]) {
        [self.delegate platformaly:self authorizedWithToken:token];
    }
}

- (void)webViewWillDissmiss:(WebViewController*)webViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyWillDissmisAuthorization:)]) {
        [self.delegate platformalyWillDissmisAuthorization:self];
    }
}

- (void)webViewDidDissmiss:(WebViewController*)webViewController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyDidDissmisAuthorization:)]) {
        [self.delegate platformalyDidDissmisAuthorization:self];
    }
}

#pragma mark - lazy init

-(NSArray *)operators
{
    if (_operators)
        return _operators;
    
    Operator* mts      = [Operator mts];
    Operator* tele2    = [Operator tele2];
    Operator* megafone = [Operator megafon];
    Operator* beeline  = [Operator beeline];
    
    _operators = @[mts, tele2, megafone, beeline];
    return _operators;
}


@end
