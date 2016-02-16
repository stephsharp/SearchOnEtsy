//
//  ETSearchBar.m
//  EtsySearch
//
//  Created by Steph Sharp on 10/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchBar.h"
#import "ETSearchButton.h"
#import "UIColor+ETTheme.h"

static NSInteger const ETHorizontalPadding = 8;

@interface ETSearchBar () <UITextFieldDelegate>

@property (nonatomic) UITextField *textField;
@property (nonatomic) UIButton *searchButton;

@end

@implementation ETSearchBar

#pragma mark - Initializers

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
    [self configureTextField];
    [self configureSearchButton];
    [self setupConstraints];

    self.layer.cornerRadius = 4.0f;
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = self.tintColor.CGColor;

    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
}

#pragma mark - Setup

- (void)configureTextField
{
    self.textField = [UITextField new];
    self.textField.textColor = [UIColor et_darkGrayColor];
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.delegate = self;

    [self addSubview:self.textField];
}

- (void)configureSearchButton
{
    self.searchButton = [ETSearchButton buttonWithType:UIButtonTypeCustom];
    [self.searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.searchButton];
}

- (void)setupConstraints
{
    UITextField *textField = self.textField;
    UIButton *button = self.searchButton;

    textField.translatesAutoresizingMaskIntoConstraints = NO;
    button.translatesAutoresizingMaskIntoConstraints = NO;

    NSDictionary *views = NSDictionaryOfVariableBindings(textField, button);

    NSString *horizontalFormat = [NSString stringWithFormat:@"H:|-%ld-[textField]-%ld-[button]|", (long)ETHorizontalPadding, (long)ETHorizontalPadding];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraint:[NSLayoutConstraint constraintWithItem:button
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:button
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1
                                                      constant:0]];
}

#pragma mark - Properties

- (void)setTextColor:(UIColor *)textColor
{
    self.textField.textColor = textColor;
}

- (UIColor *)textColor
{
    return self.textField.textColor;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.textField.placeholder = placeholder;
}

- (NSString *)placeholder
{
    return self.textField.placeholder;
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
}

- (NSString *)text
{
    return self.textField.text;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setFont:(UIFont *)font
{
    self.textField.font = font;
}

- (UIFont *)font
{
    return self.textField.font;
}

- (BOOL)isEmpty
{
    return self.text.length == 0;
}

#pragma mark - UIView

- (void)tintColorDidChange
{
    self.layer.borderColor = self.tintColor.CGColor;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.delegate searchBarSearchButtonClicked:self];

    return YES;
}

#pragma mark - UIResponder

- (BOOL)resignFirstResponder
{
    [self.textField resignFirstResponder];

    return YES;
}

- (BOOL)isFirstResponder
{
    return [self.textField isFirstResponder];
}

#pragma mark - Actions

- (IBAction)search
{
    [self.delegate searchBarSearchButtonClicked:self];
}

@end
