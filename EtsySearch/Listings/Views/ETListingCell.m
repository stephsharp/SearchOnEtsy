//
//  ETListingCell.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETListingCell.h"
#import "UIColor+ETTheme.h"

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

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self sharedInit];
}

- (void)sharedInit
{
    self.layer.speed = 1.5;

    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [UIColor et_lightGrayColor].CGColor;

    self.mainImageView.backgroundColor = [UIColor et_lightGrayColor];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.mainImageView.image = nil;
}

@end
