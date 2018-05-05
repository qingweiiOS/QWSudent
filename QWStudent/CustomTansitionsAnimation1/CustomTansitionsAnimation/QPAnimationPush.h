//
//  QPAnimationPush.h
//  自定义转场动画
//
//  Created by qingweiqw on 16/12/14.
//  Copyright © 2016年 qingweiqw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,transType)
{
    PUSH,
    POP
} ;
@interface QPAnimationPush : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) transType transTypes;
-(instancetype)initWithTransType:(transType)transType;
@end
