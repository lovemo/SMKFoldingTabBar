//
//  SMKFoldingTabBar.h
//  testCirButton
//
//  Created by Mac on 17/5/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SEKExtension.h"


@class SMKFoldingTabBar;

NS_ASSUME_NONNULL_BEGIN

@protocol SMKFoldingTabBarDelegate <NSObject>

@optional

- (void)tabBarWillCollapse:(SMKFoldingTabBar *)tabBar;
- (void)tabBarWillExpand:(SMKFoldingTabBar *)tabBar;

- (void)tabBarDidCollapse:(SMKFoldingTabBar *)tabBar;
- (void)tabBarDidExpand:(SMKFoldingTabBar *)tabBar;

- (void)tabBarDidSelectCenterItem:(SMKFoldingTabBar *)tabBar;

- (void)tabBar:(SMKFoldingTabBar *)tabBar didSelectLeftItemAtIndex:(NSUInteger)index;
- (void)tabBar:(SMKFoldingTabBar *)tabBar didSelectRightItemAtIndex:(NSUInteger)index;


@end

typedef NS_ENUM(NSUInteger, SMKFoldingTabBarState) {
    SMKFoldingTabBarStateExpanded,
    SMKFoldingTabBarStateCollapsed
};


@interface SMKFoldingTabBar : UIView


/**
 *  中间按钮宽度
 */
@property (nonatomic, assign) CGFloat  centerButtonWidth;
/**
 *  中间按钮高度
 */
@property (nonatomic, assign) CGFloat  centerButtonHeight;
/**
 *  中间按钮圆角
 */
@property (nonatomic, assign) CGFloat  centerButtonCornerRadius;
/**
 *  中间按钮圆角矩形
 */
@property (nonatomic, assign) BOOL  isRoundCenterButton;
/**
 *  中间按钮背景颜色
 */
@property (nonatomic, strong) UIColor *centerButtonBackColor;
/**
 *  中间按钮文字颜色
 */
@property (nonatomic, strong) UIColor *centerButtonTextColor;
/**
 *  中间按钮文字大小
 */
@property (nonatomic, strong) UIFont *centerButtonTextFont;
/**
 *  中间按钮文字
 */
@property (nonatomic, copy) NSString *centerButtonText;
/**
 *  中间按钮图片
 */
@property (nonatomic, strong) UIImage *centerButtonImage;

/**
 *  左边标题数组
 */
@property (nonatomic, copy) NSArray *leftTitlesArray;
/**
 *  左边图片数组
 */
@property (nonatomic, copy) NSArray *leftImagesArray;
/**
 *  左边按钮背景颜色
 */
@property (nonatomic, strong) UIColor *leftBackColor;
/**
 *  左边文字颜色
 */
@property (nonatomic, strong) UIColor *leftTextColor;
/**
 *  左边按钮高度
 */
@property (nonatomic, assign) CGFloat  leftButtonHeight;
/**
 *  左间距设置
 */
@property (nonatomic, assign) CGFloat  leftItemLength;
@property (nonatomic, assign) CGFloat  leftLeadSpacing;
@property (nonatomic, assign) CGFloat  leftTailSpacing;

/**
 *  右边标题数组
 */
@property (nonatomic, copy) NSArray *rightTitlesArray;
/**
 *  右边图片数组
 */
@property (nonatomic, copy) NSArray *rightImagesArray;
/**
 *  右边按钮背景颜色
 */
@property (nonatomic, strong) UIColor *rightBackColor;
/**
 *  右边文字颜色
 */
@property (nonatomic, strong) UIColor *rightTextColor;
/**
 *  右边按钮高度
 */
@property (nonatomic, assign) CGFloat  rightButtonHeight;
/**
 *  右间距设置
 */
@property (nonatomic, assign) CGFloat  rightItemLength;
@property (nonatomic, assign) CGFloat  rightLeadSpacing;
@property (nonatomic, assign) CGFloat  rightTailSpacing;

/**
 *  文字大小
 */
@property (nonatomic, strong) UIFont *textFont;
/**
 *  其他按钮是否圆角矩形
 */
@property (nonatomic, assign) BOOL  isRoundExtraItem;
/**
 *  tabbar状态
 */
@property (nonatomic, assign) SMKFoldingTabBarState state;
/**
 *  代理
 */
@property (nonatomic, weak, nullable) id<SMKFoldingTabBarDelegate> delegate;

/**
 *  触摸中间按钮
 */
@property (nonatomic, copy) void(^didSelectCenterItemBlock)(UIButton *button);
/**
 *  触摸左边按钮
 */
@property (nonatomic, copy) void(^didSelectLeftItemBlock)(NSUInteger index);
/**
 *  触摸右边按钮
 */
@property (nonatomic, copy) void(^didSelectRightItemBlock)(NSUInteger index);


/**
 *  初始化
 */
+ (instancetype)foldingTabBar;

@end

NS_ASSUME_NONNULL_END
