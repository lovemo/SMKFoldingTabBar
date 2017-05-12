//
//  ViewController.m
//  testCirButton
//
//  Created by Mac on 17/5/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "SMKFoldingTabBar.h"
#import "Masonry.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *showTextLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
}


@end
