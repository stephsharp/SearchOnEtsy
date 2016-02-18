//
//  ETGhostButton.m
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETGhostButton.h"

@implementation ETGhostButton

#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults
{
    self.cornerRadius = 8.0f;
    self.borderWidth = 2.0f;
    self.highlightedOpacity = 0.05;
    self.selectedOpacity = 0.15;

    [self updateButtonColorForCurrentState];
}

#pragma mark - Properties

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

#pragma mark - UIView

- (void)tintColorDidChange
{
    [self updateButtonColorForCurrentState];
}

#pragma mark - UIButton

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateButtonColorForCurrentState];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateButtonColorForCurrentState];
}

#pragma mark -

- (void)updateButtonColorForCurrentState
{
    self.layer.borderColor = self.tintColor.CGColor;
    [self setTitleColor:self.tintColor forState:UIControlStateNormal];

    if (self.highlighted) {
        self.backgroundColor = [self.tintColor colorWithAlphaComponent:self.highlightedOpacity];
    }
    else if (self.selected) {
        self.backgroundColor = [self.tintColor colorWithAlphaComponent:self.selectedOpacity];
    }
    else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
