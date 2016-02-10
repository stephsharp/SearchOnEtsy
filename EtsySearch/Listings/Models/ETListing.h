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
@property (nonatomic) NSURL *listingURL;
@property (nonatomic) NSURL *mainImageURL;
@property (nonatomic) NSString *mainImageHexCode;
@property (nonatomic) NSString *shopName;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *currencyCode;

- (instancetype)initWithTitle:(NSString *)title
             listingURLString:(NSString *)listingURLString
           mainImageURLString:(NSString *)mainImageURLString
                     shopName:(NSString *)shopName
                        price:(NSString *)price
                 currencyCode:(NSString *)currencyCode NS_DESIGNATED_INITIALIZER;

@end
