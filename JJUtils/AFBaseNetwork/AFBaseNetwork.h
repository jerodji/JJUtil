//
//  AFBaseNetwork.h
//  AFBaseNetwork
//
//  Created by Jerod on 2018/1/20.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetType) {
    GET,
    POST
};

typedef void (^SUCC)(id responseObject);
typedef void (^FAIL)(NSError* error);

@interface AFBaseNetwork : NSObject

+ (AFBaseNetwork*)sharedInstance;

- (void)GET:(NSString*)_urlHead API:(NSString*)_urlFunc params:(NSDictionary*)_parameters success:(SUCC)_success fail:(FAIL)_failure;

- (void)POST:(NSString*)_urlHead API:(NSString*)_urlFunc params:(NSDictionary*)_parameters success:(SUCC)_success fail:(FAIL)_failure;


- (void)request:(NetType)_type
        URLHead:(NSString*)_urlHead
        URLFunc:(NSString*)_urlFunc
         params:(NSDictionary*)_parameter
        success:(void (^)(id responseObject))_success
           fail:(void (^)(NSError *error))_failure;

@end
