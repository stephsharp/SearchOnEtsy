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

@property (nonatomic) NSArray *tempSearchBarConstraints;
@property (nonatomic) UIView *originalSearchBarSuperview;

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

        self.originalSearchBarSuperview = self.fromSearchBar.superview;
        [containerView addSubview:self.fromSearchBar];
        self.tempSearchBarConstraints = [self constrainView:self.fromSearchBar toPositionAndSizeOfView:self.toSearchBar];

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
        if (![self superviewHasConstraintsForView:self.fromSearchBar]) {
            self.tempSearchBarConstraints = [self constrainView:self.fromSearchBar toPositionAndSizeOfView:self.toSearchBar];
            [self.fromSearchBar.superview layoutIfNeeded];
        }

        self.fromSearchBar.hidden = NO;
        [self.fromSearchBar.superview removeConstraints:self.tempSearchBarConstraints];
        [containerView addSubview:self.fromSearchBar];
        [self setupOriginalConstraintsOnSearchBar:self.fromSearchBar withNewSuperview:containerView];
        self.toSearchBar.hidden = YES;

        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            for (UIView *view in toVC.view.subviews) {
                view.alpha = 1;
            }

            fromVC.view.alpha = 0;
            [self.fromSearchBar layoutIfNeeded];
        }
        completion:^(BOOL finished) {
            [toVC.view addSubview:self.fromSearchBar];
            [self setupOriginalConstraintsOnSearchBar:self.fromSearchBar withNewSuperview:nil];
            [self.transitionContext completeTransition:YES];
        }];
    }
}

- (NSArray *)constrainView:(UIView *)fromView toPositionAndSizeOfView:(UIView *)toView
{
    NSLayoutConstraint *leading = [fromView.leadingAnchor constraintEqualToAnchor:toView.leadingAnchor];
    NSLayoutConstraint *top = [fromView.topAnchor constraintEqualToAnchor:toView.topAnchor];
    NSLayoutConstraint *width = [fromView.widthAnchor constraintEqualToAnchor:toView.widthAnchor];
    NSLayoutConstraint *height = [fromView.heightAnchor constraintEqualToAnchor:toView.heightAnchor];

    NSArray *constraints = @[leading, top, width, height];
    [fromView.superview addConstraints:constraints];

    return constraints;
}

- (void)setupOriginalConstraintsOnSearchBar:(UIView *)searchBar withNewSuperview:(UIView *)newSuperview
{
    NSArray *constraintsToAdd;

    if (!newSuperview) {
        constraintsToAdd = self.fromSearchBarConstraints;
    }
    else {
        NSMutableArray *newConstraints = [NSMutableArray array];

        for (NSLayoutConstraint *constraint in self.fromSearchBarConstraints) {
            UIView *firstItem = constraint.firstItem;
            UIView *secondItem = constraint.secondItem;

            if (firstItem == self.originalSearchBarSuperview) {
                firstItem = newSuperview;
            }
            if (secondItem == self.originalSearchBarSuperview) {
                secondItem = newSuperview;
            }

            NSLayoutConstraint *newConstraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                             attribute:constraint.firstAttribute
                                                                             relatedBy:constraint.relation
                                                                                toItem:secondItem
                                                                             attribute:constraint.secondAttribute
                                                                            multiplier:constraint.multiplier
                                                                              constant:constraint.constant];
            [newConstraints addObject:newConstraint];
        }
        constraintsToAdd = [newConstraints copy];
    }

    [searchBar.superview addConstraints:constraintsToAdd];
}

- (BOOL)superviewHasConstraintsForView:(UIView *)view
{
    for (NSLayoutConstraint *constraint in view.superview.constraints) {
        if (constraint.firstItem == view || constraint.secondItem == view) {
            return YES;
        }
    }
    return NO;
}

@end
