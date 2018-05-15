//
//  UIColor+HexString.h
//  B2C_iPhone_V4
//
//  Created by JimBo on 15/6/26.
//  Copyright (c) 2015年 updown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
