//
//  UIColor+ETTheme.m
//  EtsySearch
//
//  Created by Steph Sharp on 8/02/2016.
//  Copyright © 2016 Stephanie Sharp. All rights reserved.
//

#import "UIColor+ETTheme.h"

@implementation UIColor (ETTheme)

// http://stackoverflow.com/questions/3805177/how-to-convert-hex-rgb-color-codes-to-uicolor
+ (UIColor *)et_colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)], [cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)], [cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)], [cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if ([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red = ((baseValue >> 24) & 0xFF) / 255.0f;
    float green = ((baseValue >> 16) & 0xFF) / 255.0f;
    float blue = ((baseValue >> 8) & 0xFF) / 255.0f;
    float alpha = ((baseValue >> 0) & 0xFF) / 255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

// http://stackoverflow.com/a/11598127/1367622
- (UIColor *)lighterColor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MIN(r + 0.05f, 1.0f)
                               green:MIN(g + 0.05f, 1.0f)
                                blue:MIN(b + 0.05f, 1.0f)
                               alpha:a];
    }
    return nil;
}

- (UIColor *)darkerColor
{
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        return [UIColor colorWithRed:MAX(r - 0.05f, 0.0f)
                               green:MAX(g - 0.05f, 0.0f)
                                blue:MAX(b - 0.05f, 0.0f)
                               alpha:a];
    }
    return nil;
}

#pragma mark - Theme colors

+ (UIColor *)et_orangeColor
{
    return [UIColor et_colorFromHexCode:@"FF6816"];
}

+ (UIColor *)et_veryLightGrayColor
{
    return [UIColor et_colorFromHexCode:@"F7F7F7"];
}

+ (UIColor *)et_lightGrayColor
{
    return [UIColor et_colorFromHexCode:@"DBDBDB"];
}

+ (UIColor *)et_darkGrayColor
{
    return [UIColor et_colorFromHexCode:@"575757"];
}

@end
