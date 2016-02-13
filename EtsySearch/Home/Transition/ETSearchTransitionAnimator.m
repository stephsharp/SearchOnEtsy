//
//  ETSearchTransitionAnimator.m
//  EtsySearch
//
//  Created by Steph Sharp on 12/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETSearchTransitionAnimator.h"

@interface ETSearchTransitionAnimator ()

@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation ETSearchTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.presenting) {
        return 0.28;
    }
    return 0.2;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;

    UIView *containerView = [transitionContext containerView];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    // Start appearance transition for source controller because UIKit
    // does not remove views from hierarchy when transition is finished.
    if (self.presenting) {
        [fromVC beginAppearanceTransition:NO animated:YES];
    }
    else {
        [toVC beginAppearanceTransition:YES animated:YES];
    }

    if (self.presenting) {
        containerView.tintColor = fromVC.view.tintColor;
        [containerView addSubview:toVC.view];
        toVC.view.alpha = 0;
        self.toSearchBar.hidden = YES;

        [containerView addSubview:self.fromSearchBar];

        CGRect frame = [self.toSearchBar convertRect:self.toSearchBar.bounds toView:nil];
        [self setupConstraintsOnSearchBar:self.fromSearchBar forFrame:frame];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *view in fromVC.view.subviews) {
                view.alpha = 0;
            }

            toVC.view.alpha = 1;
            [self.fromSearchBar layoutIfNeeded];
        }
        completion:^(BOOL finished) {
             self.fromSearchBar.hidden = YES;
             self.toSearchBar.hidden = NO;
            [self.transitionContext completeTransition:YES];
        }];
    }
    else {
        self.fromSearchBar.hidden = NO;
        [toVC.view addSubview:self.fromSearchBar];
        [self setupOriginalConstraintsOnSearchBar:self.fromSearchBar];
        self.toSearchBar.hidden = YES;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *view in toVC.view.subviews) {
                view.alpha = 1;
            }

            fromVC.view.alpha = 0;
            [self.fromSearchBar layoutIfNeeded];
        }
        completion:^(BOOL finished) {
            [self.transitionContext completeTransition:YES];
        }];
    }
}

- (void)setupConstraintsOnSearchBar:(UIView *)searchBar forFrame:(CGRect)frame
{
    NSDictionary *views = NSDictionaryOfVariableBindings(searchBar);

    NSString *horizontalFormat = [NSString stringWithFormat:@"H:|-%f-[searchBar(%f)]", frame.origin.x, frame.size.width];
    [searchBar.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];

    NSString *verticalFormat = [NSString stringWithFormat:@"V:|-%f-[searchBar(%f)]", frame.origin.y, frame.size.height];
    [searchBar.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:views]];
}

- (void)setupOriginalConstraintsOnSearchBar:(UIView *)searchBar
{
    [searchBar.superview addConstraints:self.fromSearchBarConstraints];
}

@end
