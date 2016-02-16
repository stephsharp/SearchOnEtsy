//
//  ETRandomImage.m
//  EtsySearch
//
//  Created by Steph Sharp on 16/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "ETRandomImage.h"
#import "ETStyleKit.h"

@implementation ETRandomImage

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    NSString *selectorString = [NSString stringWithFormat:@"draw%@WithRect:", self.imageName];
    SEL selector = NSSelectorFromString(selectorString);

    if([ETStyleKit respondsToSelector:selector]) {
        NSMethodSignature *methodSignature = [ETStyleKit methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.selector = selector;
        invocation.target = [ETStyleKit class];
        [invocation setArgument:&rect atIndex:2]; //arguments 0 and 1 set by NSInvocation
        [invocation invoke];
    }
}

- (void)fadeToImage:(NSString *)imageName withDuration:(NSTimeInterval)duration
{
    self.imageName = imageName;
    [self setNeedsDisplay];

    [UIView transitionWithView:self
                      duration:duration
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.layer displayIfNeeded];
                    } completion:nil];
}

- (void)prepareForInterfaceBuilder
{
    self.imageName = @"PaintingIcon";
}

@end
