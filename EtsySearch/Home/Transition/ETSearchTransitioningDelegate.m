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
    UIViewController<ETSearchTransitionViewController> *toVC;
    UIViewController<ETSearchTransitionViewController> *fromVC;

    if ([presented.et_contentViewController conformsToProtocol:@protocol(ETSearchTransitionViewController)]) {
        toVC = (UIViewController<ETSearchTransitionViewController> *)presented.et_contentViewController;
        [toVC.view layoutIfNeeded];
    }

    if ([source conformsToProtocol:@protocol(ETSearchTransitionViewController)]) {
        fromVC = (UIViewController<ETSearchTransitionViewController> *)source;
    }

    if (toVC && fromVC) {
        return [self animatorWithPresentedViewController:toVC sourceViewController:fromVC presenting:YES];
    }

    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    UIViewController<ETSearchTransitionViewController> *dismissedVC;

    if ([dismissed.et_contentViewController conformsToProtocol:@protocol(ETSearchTransitionViewController)]) {
        dismissedVC = (UIViewController<ETSearchTransitionViewController> *)dismissed.et_contentViewController;
    }

    if (dismissedVC) {
        return [self animatorWithPresentedViewController:dismissedVC sourceViewController:nil presenting:NO];
    }

    return nil;
}

- (ETSearchTransitionAnimator *)animatorWithPresentedViewController:(UIViewController<ETSearchTransitionViewController> *)presentedVC
                                               sourceViewController:(UIViewController<ETSearchTransitionViewController> *)sourceVC
                                                         presenting:(BOOL)presenting
{
    self.animator.presenting = presenting;
    self.animator.toSearchBar = presentedVC.transitioningSearchBar;

    if (presenting) {
        NSMutableArray *mutableConstraints = [NSMutableArray new];

        for (NSLayoutConstraint *c in sourceVC.transitioningSearchBar.superview.constraints) {
            if (c.firstItem == sourceVC.transitioningSearchBar || c.secondItem == sourceVC.transitioningSearchBar) {
                [mutableConstraints addObject:c];
            }
        }

        self.animator.fromSearchBar = sourceVC.transitioningSearchBar;
        self.animator.fromSearchBarConstraints = [mutableConstraints copy];
    }

    return self.animator;
}

@end
