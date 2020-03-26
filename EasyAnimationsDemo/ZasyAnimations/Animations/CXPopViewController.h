//
//  CXPopViewController.h
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXPopPresentationController.h"

typedef NS_ENUM(NSInteger, CXTransitionAnimationStyle) {
    CXTransitionAnimationStyleDefault,//底部滑出
    CXTransitionAnimationStyleFade,
    CXTransitionAnimationStyleFromBottom,
    CXTransitionAnimationStyleFromRight
};

NS_ASSUME_NONNULL_BEGIN

@interface CXPopViewController : UIViewController <CXPopPresentationDelegate, UIViewControllerTransitioningDelegate>

/*! @brief animation style */
@property (nonatomic, assign) CXTransitionAnimationStyle style;
@property (nonatomic, assign) BOOL dimming;
@property (nonatomic, assign) BOOL shouldDismissWhenTap;
@property (nonatomic, strong) id<UIViewControllerAnimatedTransitioning> animator;
@property (nonatomic, copy) void(^tapDismissBlock)(void);
- (instancetype)initWithAnimationStyle:(CXTransitionAnimationStyle)style;

@end

NS_ASSUME_NONNULL_END
