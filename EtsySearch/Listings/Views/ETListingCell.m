//
//  ETListingCell.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListingCell.h"

@implementation ETListingCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.layer.speed = 1.5;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.mainImageView.image = nil;
}

@end
