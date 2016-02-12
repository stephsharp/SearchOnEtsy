//
//  ETNavigationControllerDelegate.m
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchTransitioningDelegate.h"
#import "ETSearchTransitionAnimator.h"
#import "UIViewController+ETContentViewController.h"

@interface ETSearchTransitioningDelegate ()

@property (nonatomic) ETSearchTransitionAnimator *animator;

@end

@implementation ETSearchTransitioningDelegate

- (ETSearchTransitionAnimator *)animator
{
    if (!_animator) {
        _animator = [ETSearchTransitionAnimator new];
    }
    return _animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    UIViewController *presentedVC = presented.et_contentViewController;
    [presentedVC.view layoutIfNeeded];

    return [self animatorWithViewController:presentedVC presenting:YES];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    UIViewController *dismissedContentViewController = dismissed.et_contentViewController;

    return [self animatorWithViewController:dismissedContentViewController presenting:NO];
}

- (ETSearchTransitionAnimator *)animatorWithViewController:(UIViewController *)viewController presenting:(BOOL)presenting
{
    if ([viewController conformsToProtocol:@protocol(ETSearchTransitionPresentedViewController)]) {
        UIViewController<ETSearchTransitionPresentedViewController> *presentedVC = (UIViewController<ETSearchTransitionPresentedViewController> *)viewController;

        self.animator.presenting = presenting;
        self.animator.toSearchBar = presentedVC.toSearchBar;
        self.animator.fromSearchBar = self.fromSearchBar;

        if (presenting) {
            // Only get constraints that have either item1 or item2 as self.fromSearhBar
            NSMutableArray *mutableConstraints = [NSMutableArray new];

            for (NSLayoutConstraint *c in self.fromSearchBar.superview.constraints) {
                if (c.firstItem == self.fromSearchBar || c.secondItem == self.fromSearchBar) {
                    [mutableConstraints addObject:c];
                }
            }

            self.animator.fromSearchBarConstraints = [mutableConstraints copy];
        }
    }
    
    return self.animator;
}

@end
