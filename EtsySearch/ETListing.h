//
//  ETListing.h
//  EtsySearch
//
//  Created by Steph Sharp on 7/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETListing : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *mainImageURL;

- (instancetype)initWithTitle:(NSString *)title mainImageURLString:(NSString *)urlString NS_DESIGNATED_INITIALIZER;

@end
