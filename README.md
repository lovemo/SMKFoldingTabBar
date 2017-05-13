# SMKFoldingTabBar
SMKFoldingTabBar - An Awesome Folding Custom View

![image](https://github.com/lovemo/SMKFoldingTabBar/raw/master/demo.gif)

---

#### usage:
```ruby
  pod 'SMKFoldingTabBar'
```

### Code
```objc
typedef struct {
    
    // 按钮收缩动画周期
    CFTimeInterval animationForCenterButtonCollapseDuration;
    
    // 按钮展开动画周期
    CFTimeInterval animationForCenterButtonExpandDuration;
    
    // 其他按钮展开动画周期
    CFTimeInterval animationForExtraItemShowDuration;
    
    // 其他按钮缩放动画周期
    CFTimeInterval animationForExtraItemScaleDuration;
    
    // 其他按钮抖动动画周期
    CFTimeInterval animationForExtraItemRotationDuration;

} SMKAnimationParameters;


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

// ......

@end
```

### Demo
```objc
    SMKFoldingTabBar *foldingTabBar = [SMKFoldingTabBar foldingTabBar];
    [self.view addSubview:foldingTabBar];
    [foldingTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
        make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
    }];
    
    foldingTabBar.animationParameters = (SMKAnimationParameters) {
        .animationForCenterButtonExpandDuration = 0.4,
        .animationForCenterButtonCollapseDuration = 0.4,
        .animationForExtraItemShowDuration = 0.3,
    };
    
    foldingTabBar.leftItemLength = foldingTabBar.rightItemLength
                                 = foldingTabBar.leftButtonHeight
                                 = foldingTabBar.rightButtonHeight
                                 = 36;
    foldingTabBar.leftImagesArray = @[
                                      @"new_umsocial_sina",
                                      @"new_umsocial_wechat",
                                      @"new_umsocial_wechat_timeline"
                                      ];
    foldingTabBar.rightImagesArray = @[
                                       @"new_umsocial_qq",
                                       @"new_umsocial_qzone",
                                       @"new_umsocial_wechat_favorite"
                                       ];
    
    foldingTabBar.centerButtonText = @"分享";
    foldingTabBar.centerButtonTextFont = [UIFont systemFontOfSize:16];
    foldingTabBar.centerButtonBackColor = [UIColor blackColor];
    foldingTabBar.centerButtonTextColor = [UIColor colorWithRed:255/255.f 
                                                   green:208/255.f 
                                                   blue:2/255.f 
                                                   alpha:1.f];
    foldingTabBar.centerButtonWidth = 454 * 0.5;
    foldingTabBar.isRoundCenterButton = YES;
    foldingTabBar.centerButtonHeight = 44;
    foldingTabBar.leftBackColor = foldingTabBar.rightBackColor = [UIColor blackColor];
    foldingTabBar.isRoundExtraItem = YES;
    
    NSLog(@"%zd", foldingTabBar.state);
    
    [foldingTabBar setDidSelectCenterItemBlock:^(UIButton * _Nonnull button) {
        self.showTextLabel.text = [NSString stringWithFormat:@"我是中心按钮"];
    }];
    
    [foldingTabBar setDidSelectLeftItemBlock:^(NSUInteger index) {
        self.showTextLabel.text = [NSString stringWithFormat:@"我是左边第 %zd 个", index];
        NSLog(@"%zd", index);
    }];
    
    [foldingTabBar setDidSelectRightItemBlock:^(NSUInteger index) {
        self.showTextLabel.text = [NSString stringWithFormat:@"我是右边第 %zd 个", index];
        NSLog(@"%zd", index);
    }];

```

---

### Contributing to SMKFoldingTabBar
Welcome to [report Issues](https://github.com/lovemo/SMKFoldingTabBar/issues) or [pull requests](https://github.com/lovemo/SMKFoldingTabBar/pulls) to SMKFoldingTabBar.

## License

SMKFoldingTabBar is released under the MIT license. See LICENSE for details.
