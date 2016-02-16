//
//  ETURLSession.h
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ETURLSessionDataTask <NSObject>

- (void)resume;
- (void)cancel;

@end

@protocol ETURLSession <NSObject>

- (nonnull id<ETURLSessionDataTask>)dataTaskWithURL:(nonnull NSURL *)url completionHandler:(nonnull void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

@end
