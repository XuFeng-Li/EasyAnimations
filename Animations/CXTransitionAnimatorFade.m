//
//  CXTransitionAnimatorFade.m
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import "CXTransitionAnimatorFade.h"

@implementation CXTransitionAnimatorFade

- (instancetype)init {
    if (self = [super init]) {
        _duration = 0.25;
        _offsetX = 0;
        _offsetY = 30;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    
    BOOL isPresentation = !(toView == nil);
    
    UIViewController *animatedController = isPresentation ? toVC : fromVC;
    UIView *animatedView = isPresentation ? toView : fromView;
    animatedView.frame = [transitionContext finalFrameForViewController:animatedController];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(_offsetX, _offsetY);
    if (isPresentation) {
        [containerView addSubview:animatedView];
        animatedView.alpha = 0;
        animatedView.transform = transform;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        animatedView.transform = isPresentation ? CGAffineTransformIdentity : transform;
        animatedView.alpha = isPresentation ? 1 : 0;
    } completion:^(BOOL finished) {
        if (!isPresentation) {
            [animatedView removeFromSuperview];
        }
        [transitionContext completeTransition:finished];
    }];
};

@end
