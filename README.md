# SMKFoldingTabBar
SMKFoldingTabBar - A Awesome Folding Custom View

---

![image](https://github.com/lovemo/SMKFoldingTabBar/raw/master/test.gif)

---

```objc
SMKFoldingTabBar *foldingTabBar = [SMKFoldingTabBar foldingTabBar];
    [self.view addSubview:foldingTabBar];
    [foldingTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
        make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
    }];
    
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
    foldingTabBar.centerButtonTextColor = [UIColor colorWithRed:255/255.f green:208/255.f blue:2/255.f alpha:1.f];
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

## 期待
* 如果在使用过程中遇到BUG，希望你能Issues我，谢谢（或者尝试下载最新的代码看看BUG修复没有）
* 如果在使用过程中发现功能不够用，希望你能Issues我，我非常想为这个框架增加更多好用的功能，谢谢
