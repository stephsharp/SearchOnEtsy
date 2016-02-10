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

    [self setButtonImage];
    self.adjustsImageWhenHighlighted = NO;
}

- (void)setButtonImage
{
    NSBundle *bundleForClass = [NSBundle bundleForClass:[self class]];
    UIImage *searchIcon = [UIImage imageNamed:@"search-icon" inBundle:bundleForClass compatibleWithTraitCollection:self.traitCollection];

    [self setImage:searchIcon forState:UIControlStateNormal];
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
