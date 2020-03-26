//
//  CXPopPresentationController.h
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CXPopPresentationController;

@protocol CXPopPresentationDelegate <NSObject>

@optional
/**
 *  Notifies the delegate that the dismissal transition due to tapping dimming are about to start.
 *
 *  @param controller the presentation controller
 */
- (void)presentationWillDismiss:(CXPopPresentationController *)presentationController;

/**
 *  Notifies the delegate that the dismissal transition due to tapping dimming finished.
 *
 *  @param controller the presentation controller
 */
- (void)presentationDidDismissed:(CXPopPresentationController *)presentationController;

/**
 *  ask the delegate for the frame of the presented view
 *
 *  @param controller the presentation controller
 *
 *  @return frame
 */
- (CGRect)frameOfPresentedViewForPresentationController:(CXPopPresentationController *)controller;

@end

@interface CXPopPresentationController : UIPresentationController

@property (nonatomic, weak) id<CXPopPresentationDelegate> popPresentationDelegate;

/*! @brief dimming background or not */
@property (nonatomic, assign) BOOL dimming;

/*! @brief if dismiss when tapping dimming background */
@property (nonatomic, assign) BOOL shouldDismissWhenTap;

@end

NS_ASSUME_NONNULL_END
