//
//  UINavigationBar+ShadowColor.m
//  IgorBizi@mail.ru
//
//  Created by IgorBizi@mail.ru on 12/12/15.
//  Copyright © 2015 IgorBizi@mail.ru. All rights reserved.
//

#import "UINavigationBar+ShadowColor.h"


@implementation UINavigationBar (ShadowColor)


- (void)setBottomBorderColor:(UIColor *)color height:(CGFloat)height
{
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[UIView alloc] initWithFrame:bottomBorderRect];
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

@end
