//
//  ETSearchURL.h
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSearchURL : NSObject

+ (NSURL *)listingsURLWithKeywords:(NSString *)keywords offset:(NSUInteger)offset;

@end
