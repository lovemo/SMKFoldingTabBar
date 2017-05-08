# SMKFoldingTabBar
SMKFoldingTabBar - A Awesome Folding Custom View

---

![image](https://github.com/lovemo/SMKFoldingTabBar/raw/master/demo.gif)

---

```objc
    SMKFoldingTabBar *foldingTabBar = [SMKFoldingTabBar foldingTabBar];
    foldingTabBar.backgroundColor = [UIColor colorWithRed:72.f/255.f green:211.f/255.f blue:178.f/255.f alpha:1.f];
    
    foldingTabBar.leftTitlesArray = @[
                                      @"One",
                                      @"Two",
                                      @"Thr"
                                      ];
    foldingTabBar.rightTitlesArray = @[
                                       @"One",
                                       @"Two",
                                       @"Thr"
                                       ];
    [self.view addSubview:foldingTabBar];
    [foldingTabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(self.view);
    }];
    
    foldingTabBar.centerButtonText = @"中心";
    foldingTabBar.leftTextColor = [UIColor whiteColor];
    foldingTabBar.rightTextColor = [UIColor whiteColor];
    foldingTabBar.centerButtonWidth = 180;
    foldingTabBar.isRoundCenterButton = YES;
    foldingTabBar.centerButtonHeight = 40;
    foldingTabBar.leftBackColor = [UIColor colorWithRed:103.f/255.f green:71.f/255.f blue:153.f/255.f alpha:1.f];
    foldingTabBar.rightBackColor = [UIColor colorWithRed:103.f/255.f green:71.f/255.f blue:153.f/255.f alpha:1.f];
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
