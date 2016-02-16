//
//  ETTestURLSession.m
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETTestURLSession.h"

@interface ETTestURLSessionDataTask : NSObject <ETURLSessionDataTask>
@property (nonatomic, copy) void (^completionHandler)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);
- (instancetype)initWithCompletionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
@end

@implementation ETTestURLSession

- (id<ETURLSessionDataTask>)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler
{
    return [[ETTestURLSessionDataTask alloc] initWithCompletionHandler:completionHandler];
}

@end

@implementation ETTestURLSessionDataTask

- (instancetype)initWithCompletionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler
{
    self = [super init];
    if (self) {
        _completionHandler = [completionHandler copy];
    }
    return self;
}

- (void)resume
{
    self.completionHandler(nil, nil, [NSError new]);
}

- (void)cancel
{
}

@end
