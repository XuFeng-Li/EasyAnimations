//
//  CXPopViewController.m
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import "CXPopViewController.h"
#import "EasyTransition.h"

@interface CXPopViewController ()

@property (nonatomic, weak) CXPopPresentationController *popPresentationController;

@end

@implementation CXPopViewController

- (instancetype)initWithAnimationStyle:(CXTransitionAnimationStyle)style {
    if (self = [self init]) {
        self.style = style;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        _style = CXTransitionAnimationStyleDefault;
        _dimming = YES;
        _shouldDismissWhenTap = YES;
//        self.view.layer.drawsAsynchronously = YES;
    }
    return self;
}

- (void)setStyle:(CXTransitionAnimationStyle)style {
    _style = style;
    switch (style) {
        case CXTransitionAnimationStyleFade:
            self.animator = [CXTransitionAnimatorFade new];
            return;
        case CXTransitionAnimationStyleFromBottom:
            self.animator = [CXTransitionAnimatorFromBottom new];
            return;
        case CXTransitionAnimationStyleFromRight:
            self.animator = [CXTransitionAnimatorFromRight new];
            return;
        default:
            self.animator = [CXTransitionAnimatorDefault new];
            return;
    }
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        _style = CXTransitionAnimationStyleDefault;
        _dimming = YES;
        _shouldDismissWhenTap = YES;
    }
    return self;
}
- (void)setDimming:(BOOL)dimming {
    _dimming = dimming;
    [_popPresentationController setDimming:dimming];
}

- (void)setShouldDismissWhenTap:(BOOL)shouldDismissWhenTap {
    _shouldDismissWhenTap = shouldDismissWhenTap;
    [_popPresentationController setShouldDismissWhenTap:shouldDismissWhenTap];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    if (!_popPresentationController) {
        CXPopPresentationController * popPresentationController = [[CXPopPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
        popPresentationController.popPresentationDelegate = self;
        popPresentationController.dimming = _dimming;
        popPresentationController.shouldDismissWhenTap = _shouldDismissWhenTap;
        return _popPresentationController = popPresentationController;
    }
    return _popPresentationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.animator;
}
-(void)presentationDidDismissed:(CXPopPresentationController *)presentationController{
    if (self.tapDismissBlock) {
        self.tapDismissBlock();
    }
}
@end
