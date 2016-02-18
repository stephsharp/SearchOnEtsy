//
//  ETFlatButton.m
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETFlatButton.h"

@implementation ETFlatButton

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

#pragma mark - Setup

- (void)setupDefaults
{
    self.filled = NO;
    self.layer.cornerRadius = 8.0f;
    self.layer.borderWidth = 2.0f;
    self.highlightedColor = self.tintColor;
    self.selectedColor = self.tintColor;
    self.disabledColor = [UIColor lightGrayColor];
    self.disabledSelectedColor = self.disabledColor;
    self.filledTitleColor = [UIColor whiteColor];
    self.disabledSelectedTitleColor = self.filledTitleColor;
}

#pragma mark - Properties

- (void)setFilled:(BOOL)filled
{
    _filled = filled;
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

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

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

- (void)setHighlightedColor:(UIColor *)highlightedColor
{
    _highlightedColor = highlightedColor;
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

- (void)setDisabledColor:(UIColor *)disabledColor
{
    // TODO: compare colours with == ??
    if (self.disabledSelectedColor == _disabledColor) {
        self.disabledSelectedColor = disabledColor;
    }

    _disabledColor = disabledColor;
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

- (void)setDisabledSelectedColor:(UIColor *)disabledSelectedColor
{
    _disabledSelectedColor = disabledSelectedColor;
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

- (void)setFilledTitleColor:(UIColor *)filledTitleColor
{
    if (self.disabledSelectedTitleColor == _filledTitleColor) {
        self.disabledSelectedTitleColor = filledTitleColor;
    }

    _filledTitleColor = filledTitleColor;
    [self updateTitleColor];
}

- (void)setDisabledSelectedTitleColor:(UIColor *)disabledSelectedTitleColor
{
    _disabledSelectedTitleColor = disabledSelectedTitleColor;
    [self updateTitleColor];
}

#pragma mark - UIButton methods

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateButtonColorForCurrentState];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
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
    UIColor *currentColor = self.tintColor;
    BOOL fill = (self.selected || self.highlighted) ? YES : self.isFilled;

    if (!self.enabled) {
        currentColor = self.selected ? self.disabledSelectedColor : self.disabledColor;
    }
    else if (self.highlighted) {
        currentColor = self.highlightedColor;
    }
    else if (self.selected) {
        currentColor = self.selectedColor;
    }

    self.backgroundColor = fill ? currentColor : [UIColor clearColor];
    //self.layer.borderColor = fill ? [UIColor clearColor].CGColor : currentColor.CGColor;
    self.layer.borderColor = fill ? self.tintColor.CGColor : currentColor.CGColor;
}

- (void)updateTitleColor
{
    UIColor *normalTitleColor = self.isFilled ? self.filledTitleColor : self.tintColor;
    UIColor *disabledTitleColor = self.isFilled ? self.filledTitleColor : self.disabledColor;

    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
    [self setTitleColor:self.filledTitleColor forState:UIControlStateHighlighted];
    [self setTitleColor:self.filledTitleColor forState:UIControlStateSelected];
    [self setTitleColor:self.disabledSelectedTitleColor forState:(UIControlStateSelected | UIControlStateDisabled)];
}

#pragma mark - Interface Builder

- (void)prepareForInterfaceBuilder
{
    [self updateButtonColorForCurrentState];
    [self updateTitleColor];
}

@end
