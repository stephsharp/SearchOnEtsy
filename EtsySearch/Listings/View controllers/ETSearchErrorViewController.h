//
//  ETSearchErrorViewController.h
//  EtsySearch
//
//  Created by Steph Sharp on 17/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETSearchErrorViewController;

@protocol ETSearchErrorViewControllerDelegate <NSObject>

- (void)searchViewControllerShouldPerformAction:(ETSearchErrorViewController *)searchErrorViewController;

@end

typedef NS_ENUM(NSInteger, ETSearchErrorViewControllerType) {
    ETSearchErrorViewControllerTypeDefault = 0,
    ETSearchErrorViewControllerTypeNoResults = 1,
};

@interface ETSearchErrorViewController : UIViewController

@property (weak, nonatomic) id<ETSearchErrorViewControllerDelegate> delegate;

@property (nonatomic) ETSearchErrorViewControllerType type;
@property (nonatomic) NSString *errorTitle;
@property (nonatomic) NSString *errorDescription;
@property (nonatomic) NSString *errorButtonTitle;

+ (ETSearchErrorViewController *)errorViewControllerWithTitle:(NSString *)title
                                                  description:(NSString *)description
                                                  buttonTitle:(NSString *)buttonTitle;
+ (ETSearchErrorViewController *)errorViewControllerWithDescription:(NSString *)description;
+ (ETSearchErrorViewController *)noResultsErrorViewControllerWithDescription:(NSString *)description;

@end
