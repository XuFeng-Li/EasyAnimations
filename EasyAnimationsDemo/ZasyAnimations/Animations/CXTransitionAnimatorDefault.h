//
//  CXTransitionAnimatorDefault.h
//  ZasyAnimations
//
//  Created by 李旭峰 on 3/26/20.
//  Copyright © 2020 李旭峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXTransitionAnimatorDefault : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat scale;

@end

NS_ASSUME_NONNULL_END
