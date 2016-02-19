//
//  ETTestURLSession.m
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETTestURLSession.h"

@interface ETTestURLSessionDataTask : NSObject <ETURLSessionDataTask>

@property (nonatomic) NSData *data;
@property (nonatomic) NSURLResponse *response;
@property (nonatomic) NSError *error;
@property (nonatomic, copy) void (^completionHandler)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable);

- (instancetype)initWithData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;

@end

@implementation ETTestURLSession

- (id<ETURLSessionDataTask>)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler
{
    return [[ETTestURLSessionDataTask alloc] initWithData:self.data response:self.response error:self.error completionHandler:completionHandler];
}

@end

@implementation ETTestURLSessionDataTask

- (instancetype)initWithData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler
{
    self = [super init];
    if (self) {
        _data = data;
        _response = response;
        _error = error;
        _completionHandler = [completionHandler copy];
    }
    return self;
}

- (void)resume
{
    self.completionHandler(self.data, self.response, self.error);
}

- (void)cancel
{
}

@end
