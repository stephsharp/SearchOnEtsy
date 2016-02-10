//
//  UIColor+ETTheme.h
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ETTheme)

+ (UIColor *)et_colorFromHexCode:(NSString *)hexString;

- (UIColor *)lighterColor;
- (UIColor *)darkerColor;

+ (UIColor *)et_lightGrayColor;
+ (UIColor *)et_darkGrayColor;
+ (UIColor *)et_orangeColor;

@end
