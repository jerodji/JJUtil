//
//  AFBaseNetwork.m
//  AFBaseNetwork
//
//  Created by Jerod on 2018/1/20.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "AFBaseNetwork.h"
#import "AFNetworking.h"
//#import <AFHTTPSessionManager.h>

@interface AFBaseNetwork()
@property (nonatomic,strong) AFHTTPSessionManager * sessionManager;
@end

@implementation AFBaseNetwork

- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[AFHTTPSessionManager alloc] init];
        NSMutableSet *acceptSet = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [acceptSet addObject:@"text/plain"];
        [acceptSet addObject:@"text/html"];
        
        _sessionManager.requestSerializer.timeoutInterval = 15;
        _sessionManager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        _sessionManager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        _sessionManager.responseSerializer.acceptableContentTypes = [acceptSet copy];
    }
    return _sessionManager;
}


+ (AFBaseNetwork *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[AFBaseNetwork alloc] init];
    });
    return _sharedObject;
}

- (void)GET:(NSString*)_urlHead API:(NSString*)_urlFunc params:(NSDictionary*)_parameters success:(SUCC)_success fail:(FAIL)_failure
{
    
}

- (void)POST:(NSString*)_urlHead API:(NSString*)_urlFunc params:(NSDictionary*)_parameters success:(SUCC)_success fail:(FAIL)_failure
{
    
}


- (void)request:(NetType)_type
        URLHead:(NSString*)_urlHead
        URLFunc:(NSString*)_urlFunc
         params:(NSDictionary*)_parameter
        success:(void (^)(id responseObject))_success
           fail:(void (^)(NSError *error))_failure
{
    if (nil==_urlHead || _urlHead.length==0) {
        NSLog(@"_urlHead is nil or empty");
        return;
    }
    if ( (nil == _urlFunc) || (_urlFunc.length == 0) ) {
        NSLog(@" _urlFunc is nil or empty");
        return;
    }
    
    // fullURL
    NSString * fullURL = [NSString stringWithFormat:@"%@/%@", _urlHead, _urlFunc];
    NSLog(@"fullURL >> %@",fullURL);
    
    if (_type == POST)
    {
        [self.sessionManager POST:fullURL parameters:_parameter progress:nil success:^(NSURLSessionDataTask* Task,id responseObject){
            
            //if ([responseObject[@"status"] isEqualToString:@"200"]){
                NSLog(@"MGJ又有刁民想害朕:%@ %@", _urlHead, _parameter);
                _success(responseObject);
            //} else {
                //NSLog(@"状态不对, what fuck!!");
            //}
            
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            NSLog(@"%@ \nTASK: %@ \nERROR: %@",fullURL,task,error);
            _failure(error);
        }];
    }
    else
    {
        [self.sessionManager GET:fullURL parameters:_parameter progress:nil success:^(NSURLSessionDataTask* Task,id responseObject){
            
            //if ([responseObject[@"status"] isEqualToString:@"200"]){
                NSLog(@"MGJ又有刁民想害朕:%@ %@", _urlHead, _parameter);
                _success(responseObject);
            //} else {
            //    NSLog(@"状态不对, what fuck!!");
            //}
            
        } failure:^(NSURLSessionDataTask* Task, NSError* Err){
            NSLog(@"%@ \nTASK: %@ \nERROR: %@",fullURL,Task,Err);
            _failure(Err);
        }];
    }
    
}

@end
