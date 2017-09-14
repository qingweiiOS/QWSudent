//
//  UIView+Extension.h
//  Trembling
//
//  Created by qingweiqw on 17/2/10.
//  Copyright © 2017年 qingweiqw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
/**
 *  切圆角
 *
 *  @param corner       圆角位置
 *  @param cornerRadius 圆角数值
 */
- (void)clipsRectCorner:(UIRectCorner )corner cornerRadius:(CGFloat)cornerRadius;

@end
