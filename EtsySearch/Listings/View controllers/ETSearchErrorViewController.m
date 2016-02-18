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
@property (weak, nonatomic) IBOutlet UIButton *errorButton;

@end

@implementation ETSearchErrorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.errorTitleLabel.text = self.errorTitle;
    self.errorDescriptionLabel.text = self.errorDescription;
    [self.errorButton setTitle:self.errorButtonTitle forState:UIControlStateNormal];
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

- (void)setErrorButtonTitle:(NSString *)errorButtonTitle
{
    _errorButtonTitle = errorButtonTitle;
    [self.errorButton setTitle:self.errorButtonTitle forState:UIControlStateNormal];
}

#pragma mark - Actions

- (IBAction)performAction:(UIButton *)sender
{
    [self.delegate searchViewControllerShouldPerformAction:self];
}

#pragma mark - Factory methods

+ (ETSearchErrorViewController *)errorViewControllerWithTitle:(NSString *)title description:(NSString *)description buttonTitle:(NSString *)buttonTitle
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ETSearchErrorViewController *errorVC = [mainStoryboard instantiateViewControllerWithIdentifier:ETSearchErrorViewControllerIdentifer];

    errorVC.errorTitle = title;
    errorVC.errorDescription = description;
    errorVC.errorButtonTitle = buttonTitle;

    return errorVC;
}

@end
