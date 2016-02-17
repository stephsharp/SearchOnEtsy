//
//  ETSearchErrorViewController.m
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchErrorViewController.h"

static NSString *const ETSearchErrorViewControllerIdentifer = @"SearchErrorViewController";

@interface ETSearchErrorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *errorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *retryButton;

@end

@implementation ETSearchErrorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.errorTitleLabel.text = self.errorTitle;
    self.errorDescriptionLabel.text = self.errorDescription;
    [self.retryButton setTitle:self.retryButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Properties

- (void)setErrorTitle:(NSString *)errorTitle
{
    _errorTitle = errorTitle;
    self.errorTitleLabel.text = errorTitle;
}

- (void)setErrorDescription:(NSString *)errorDescription
{
    _errorDescription = errorDescription;
    self.errorDescriptionLabel.text = errorDescription;
}

- (void)setRetryButtonTitle:(NSString *)retryButtonTitle
{
    _retryButtonTitle = retryButtonTitle;
    [self.retryButton setTitle:self.retryButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)retry:(UIButton *)sender
{
    [self.delegate searchViewControllerShouldRetry:self];
}

#pragma mark - Factory methods

+ (ETSearchErrorViewController *)errorViewControllerWithTitle:(NSString *)title description:(NSString *)description buttonTitle:(NSString *)buttonTitle
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ETSearchErrorViewController *errorVC = [mainStoryboard instantiateViewControllerWithIdentifier:ETSearchErrorViewControllerIdentifer];

    errorVC.errorTitle = title;
    errorVC.errorDescription = description;
    errorVC.retryButtonTitle = buttonTitle;

    return errorVC;
}

@end
