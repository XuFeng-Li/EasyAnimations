//
//  CXPopPresentationController.m
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import "CXPopPresentationController.h"

@interface CXPopPresentationController ()

@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation CXPopPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    if (self.popPresentationDelegate && [self.popPresentationDelegate respondsToSelector:@selector(frameOfPresentedViewForPresentationController:)]) {
        return [self.popPresentationDelegate frameOfPresentedViewForPresentationController:self];
    }
    return CGRectInset(self.containerView.bounds, 20, 80);
}

- (void)presentationTransitionWillBegin {
    self.presentedView.layer.shouldRasterize = YES;
    self.presentedView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if (_dimming || _shouldDismissWhenTap) {
        _dimmingView = [UIView new];
        _dimmingView.frame = self.containerView.bounds;
        [self.containerView insertSubview:_dimmingView atIndex:0];
    } else {
        self.containerView.userInteractionEnabled = NO;
    }
    
//    if (_shouldDismissWhenTap) {
//    }
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_dimmingView addGestureRecognizer:tapGesture];
    
    if (_dimming) {
        _dimmingView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _dimmingView.alpha = 0;
    }
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_dimmingView.alpha = 1;
        } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self.presentedView.layer.shouldRasterize = NO;
        }];
    } else {
        _dimmingView.alpha = 1;
        self.presentedView.layer.shouldRasterize = NO;
    }
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    if (!completed) {
        [_dimmingView removeFromSuperview];
    }
}

- (void)dismissalTransitionWillBegin {
    self.presentedView.layer.shouldRasterize = YES;
    self.presentedView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    id<UIViewControllerTransitionCoordinator> coordinator = self.presentedViewController.transitionCoordinator;
    if (coordinator) {
        [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            self->_dimmingView.alpha = 0;
        } completion:nil];
    } else {
        _dimmingView.alpha = 0;
    }
}

- (void)dismissalTransitionDidEnd:(BOOL)completed {
    if (completed) {
        [_dimmingView removeFromSuperview];
    }
}

#pragma mark - Utils

/**
 *  dismiss when tapping dimming background.
 */
- (void)dismiss {
    if (!self.shouldDismissWhenTap) {
        return;
    }
    if (self.popPresentationDelegate && [self.popPresentationDelegate respondsToSelector:@selector(presentationWillDismiss:)]) {
        [self.popPresentationDelegate presentationWillDismiss:self];
    }
    [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
        if (self.popPresentationDelegate && [self.popPresentationDelegate respondsToSelector:@selector(presentationDidDismissed:)]) {
            [self.popPresentationDelegate presentationDidDismissed:self];
        }
    }];
}

@end
