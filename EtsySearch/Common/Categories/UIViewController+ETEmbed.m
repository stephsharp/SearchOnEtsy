//
//  UIViewController+ETEmbed.m
//  EtsySearch
//
//  Created by Steph Sharp on 18/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIViewController+ETEmbed.h"

@implementation UIViewController (ETEmbed)

static NSTimeInterval const ETDefaultDuration = 0.1;

- (void)et_embedViewController:(UIViewController *)viewController useLayoutGuides:(BOOL)useLayoutGuides animated:(BOOL)animated
{
    UIView *subview = viewController.view;

    [self addChildViewController:viewController];
    [self.view addSubview:subview];
    [viewController didMoveToParentViewController:self];

    [self et_addContainerConstraintsToSubview:subview useLayoutGuides:useLayoutGuides];

    if (animated) {
        subview.alpha = 0;
        [UIView animateWithDuration:ETDefaultDuration animations:^{
            subview.alpha = 1;
        }];
    }
}

- (void)et_addContainerConstraintsToSubview:(UIView *)subview useLayoutGuides:(BOOL)useLayoutGuides
{
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = NSDictionaryOfVariableBindings(subview);

    if (useLayoutGuides) {
        [self.view addConstraint:[subview.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor]];
        [self.view addConstraint:[subview.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor]];
    }
    else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views]];
    }

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subview]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
}

- (void)et_removeFromParentViewControllerAnimated:(BOOL)animated
{
    NSTimeInterval duration = animated ? ETDefaultDuration : 0;

    [self willMoveToParentViewController:nil];

    [UIView animateWithDuration:duration animations:^{
        self.view.alpha = 0;
    }
    completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

@end
