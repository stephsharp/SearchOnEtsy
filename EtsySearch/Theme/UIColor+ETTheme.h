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

+ (UIColor *)et_lightGrayColor;

@end
