//
//  ETSearchButton.m
//  EtsySearch
//
//  Created by Steph Sharp on 11/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchButton.h"
#import "UIColor+ETTheme.h"

static NSUInteger const ETContentInset = 8;

@implementation ETSearchButton

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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.backgroundColor = self.tintColor;
    self.contentEdgeInsets = UIEdgeInsetsMake(ETContentInset, ETContentInset, ETContentInset, ETContentInset);

    [self setImage:[UIImage imageNamed:@"search-icon"] forState:UIControlStateNormal];
    self.adjustsImageWhenHighlighted = NO;
}

#pragma mark - UIButton

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateButtonColorForCurrentState];
}

- (void)updateButtonColorForCurrentState
{
    if (self.highlighted) {
        self.backgroundColor = [self.tintColor darkerColor];
    }
    else {
        self.backgroundColor = self.tintColor;
    }
}

#pragma mark - UIView

- (void)tintColorDidChange
{
    self.backgroundColor = self.tintColor;
}

@end
