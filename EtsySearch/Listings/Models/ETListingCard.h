//
//  ETListingCard.h
//  EtsySearch
//
//  Created by Steph Sharp on 10/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETListing.h"

@interface ETListingCard : NSObject

@property (nonatomic, readonly) ETListing *listing;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSURL *mainImageURL;
@property (nonatomic, readonly) UIColor *mainImageColor;
@property (nonatomic, readonly) NSString *shopName;
@property (nonatomic, readonly) NSString *formattedPrice;

- (instancetype)initWithListing:(ETListing *)listing NS_DESIGNATED_INITIALIZER;
- (instancetype)init __unavailable;

@end
