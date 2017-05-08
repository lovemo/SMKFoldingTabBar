//
//  SMKFoldingTabBar.m
//  testCirButton
//
//  Created by Mac on 17/5/6.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "SMKFoldingTabBar.h"
#import "Masonry.h"

@interface SMKFoldingTabBar ()

/**
 *  左边按钮数组
 */
@property (nonatomic, strong) NSMutableArray *leftButtonsArray;
/**
 *  右边按钮数组
 */
@property (nonatomic, strong) NSMutableArray *rightButtonsArray;
/**
 *  中间按钮
 */
@property (nonatomic, strong) UIButton *centerButton;
/**
 *  中间按钮是否选中
 */
@property (nonatomic, assign) BOOL  isSelectedCenterButton;
/**
 *  左边容器视图
 */
@property (nonatomic, strong) UIView *leftContentView;
/**
 *  右边容器视图
 */
@property (nonatomic, strong) UIView *rightContentView;


@end


@implementation SMKFoldingTabBar

#pragma mark --------------------  初始化  --------------------

+ (instancetype)foldingTabBar {
    return [[SMKFoldingTabBar alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self layoutUI];
        [self testUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
    [self layoutUI];
    [self testUI];
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.leftBackColor = self.rightBackColor = [UIColor lightGrayColor];
    self.leftTextColor = self.rightTextColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:13];
    self.centerButtonBackColor = [UIColor orangeColor];
}

- (void)testUI {
//    self.centerButton.backgroundColor = [UIColor orangeColor];
//    self.leftContentView.backgroundColor = [UIColor greenColor];
//    self.rightContentView.backgroundColor = [UIColor brownColor];
}

#pragma mark --------------------  事件  --------------------

- (void)centerButtonTouchAction:(UIButton *)button {

    if (self.isSelectedCenterButton) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarWillCollapse:)]) {
            [self.delegate tabBarWillCollapse:self];
        }
        
        [self hideExtraLeftItem];
        [self hideExtraRighttem];
        [self animationForCenterButtonExpand:nil];

        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidCollapse:)]) {
            [self.delegate tabBarDidCollapse:self];
        }
        
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarWillExpand:)]) {
            [self.delegate tabBarWillExpand:self];
        }
        
        [self animateCenterButtonCollapse:^{
            [self showExtraLeftItem];
            [self showExtraRightItem];
        }];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidExpand:)]) {
            [self.delegate tabBarDidExpand:self];
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidSelectCenterItem:) ]) {
        [self.delegate tabBarDidSelectCenterItem:self];
    }
    !self.didSelectCenterItemBlock ?: self.didSelectCenterItemBlock(button);
}

- (void)leftButtonTouchAction:(UIButton *)button {
    
    NSUInteger index = [self.leftButtonsArray indexOfObject:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectLeftItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectLeftItemAtIndex:index];
    }
    !self.didSelectLeftItemBlock ?: self.didSelectLeftItemBlock(index);
}

- (void)rightButtonTouchAction:(UIButton *)button {
    NSUInteger index = [self.rightButtonsArray indexOfObject:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectRightItemAtIndex:)]) {
        [self.delegate tabBar:self didSelectRightItemAtIndex:index];
    }
    !self.didSelectRightItemBlock ?: self.didSelectRightItemBlock(index);
}

#pragma mark --------------------  动画  --------------------

- (void)animationForCenterButtonExpand:(void (^)())animationFinished {
    [self.centerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        self.centerButtonWidth ? make.width.mas_equalTo(self.centerButtonWidth) : make.width.mas_equalTo(self).multipliedBy(0.3);
        self.centerButtonHeight ? make.height.mas_equalTo(self.centerButtonHeight) : make.height.mas_equalTo(self).multipliedBy(1.0);
        make.centerY.mas_equalTo(self);
    }];
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.isSelectedCenterButton = NO;
        if (self.isRoundCenterButton) {
            self.centerButton.layer.cornerRadius = self.centerButton.height * 0.5;
            self.centerButton.layer.masksToBounds = YES;
        } else {
            if (self.centerButtonCornerRadius > 0) {
                self.centerButton.layer.cornerRadius = self.centerButtonCornerRadius;
                self.centerButton.layer.masksToBounds = NO;
            } else {
                self.centerButton.layer.cornerRadius = self.centerButton.height * 0;
                self.centerButton.layer.masksToBounds = NO;
            }
        }
        
        !animationFinished ?: animationFinished();
    }];
}

- (void)animateCenterButtonCollapse:(void (^)())animationFinished {
    [self.centerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        self.centerButtonHeight ? make.width.height.mas_equalTo(self.centerButtonHeight) : make.width.height.mas_equalTo(self.mas_height).multipliedBy(1.0);
        make.centerY.mas_equalTo(self);
    }];
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:15 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        self.isSelectedCenterButton = YES;
        self.centerButton.layer.cornerRadius = self.centerButton.height * 0.5;
        self.centerButton.layer.masksToBounds = YES;
        
        !animationFinished ?: animationFinished();
    }];
}

- (void)showExtraLeftItem {
    
    self.leftContentView.hidden = NO;
    [self resetButtonsAlpha:self.leftButtonsArray];
    UIButton *lastButton = self.leftButtonsArray.lastObject;
    for (UIButton *button in self.leftButtonsArray) {
        button.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CGAffineTransform translation = CGAffineTransformMakeTranslation(lastButton.x - button.x, 0);
        button.transform = translation;
//        CGAffineTransform scale = CGAffineTransformMakeScale(0.4, 0.4);
//        button.transform = CGAffineTransformConcat(translation, scale);
    }
    [self animationForExtraLeftItem:self.leftButtonsArray.count - 1];

}

- (void)showExtraRightItem {
    self.rightContentView.hidden = NO;
    [self resetButtonsAlpha:self.rightButtonsArray];
    UIButton *firstButton = self.rightButtonsArray.firstObject;
    for (UIButton *button in self.rightButtonsArray) {
        button.layer.anchorPoint = CGPointMake(0.5, 0.5);
        CGAffineTransform translation = CGAffineTransformMakeTranslation(button.x - firstButton.x, 0);
        button.transform = translation;
//        CGAffineTransform scale = CGAffineTransformMakeScale(0.4, 0.4);
//        button.transform = CGAffineTransformConcat(translation, scale);
    }
    [self animationForExtraRightItem:0];
}

- (void)hideExtraLeftItem {
    self.leftContentView.hidden = YES;
}

- (void)hideExtraRighttem {
    self.rightContentView.hidden = YES;
}

- (void)resetButtonsAlpha:(NSArray *)buttons {
    for (UIButton *button in buttons) {
        button.alpha = 0;
    }
}

- (void)animationForExtraLeftItem:(NSInteger)index {
    
    self.userInteractionEnabled = NO;
    __block NSInteger tempIndex = index;
    if (tempIndex < 0) {
        for (UIButton *btn in self.leftButtonsArray) {
            [self animation:btn];
        }
        self.userInteractionEnabled = YES;
        return;
    }
    UIButton *button = [self.leftButtonsArray objectAtIndex:index];
    
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        button.alpha = 1;
        button.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        tempIndex --;
        [self animationForExtraLeftItem:tempIndex];
    }];
    
}

- (void)animationForExtraRightItem:(NSInteger)index {
    
    self.userInteractionEnabled = NO;
    __block NSInteger tempIndex = index;
    if (tempIndex >= self.rightButtonsArray.count) {
        for (UIButton *btn in self.rightButtonsArray) {
            [self animation:btn];
        }
        self.userInteractionEnabled = YES;
        return;
    }
    UIButton *button = [self.rightButtonsArray objectAtIndex:index];
    [UIView animateWithDuration:0.1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        button.alpha = 1;
        button.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        tempIndex ++;
        [self animationForExtraRightItem:tempIndex];
    }];
    
}

- (void)animation:(UIView *)view {
    
    [view.layer removeAnimationForKey:@"anmi"];
    [view.layer removeAnimationForKey:@"rotation"];
    
    CABasicAnimation *scaleX = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleX.fromValue = @(0.4);
    scaleX.toValue = @(1);
    scaleX.duration = 0.1;
    
    CABasicAnimation *scaleY = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleY.fromValue = @(0.4);
    scaleY.toValue = @(1);
    scaleY.duration = 0.1;
    
    CAKeyframeAnimation * rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"transform.rotation";
    rotation.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];
    rotation.removedOnCompletion = YES;
    rotation.fillMode = kCAFillModeForwards;
    rotation.duration = 0.2;
    rotation.repeatCount = 2;
    
    CAAnimation *anmi = [[self class] groupWithAnimations:@[scaleX, scaleY] andDuration:0.4];
    [view.layer addAnimation:anmi forKey:@"anmi"];
    [view.layer addAnimation:rotation forKey:@"rotation"];

}

+ (CAAnimationGroup *)groupWithAnimations:(NSArray *)animations andDuration:(CFTimeInterval)duration {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.animations = animations;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    return group;
}

#pragma mark --------------------  private  --------------------

- (void)enumerateObjects:(NSArray *)array usingBlock:(void (^) (UIButton *button))block {
    for (id object in array) {
        !block ?: block(object);;
    }
}

#pragma mark --------------------  布局  --------------------

- (void)layoutUI {
    
    [self layoutCenterButton];
    [self layoutContentView];
    
}

- (void)layoutCenterButton {
    [self.centerButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        self.centerButtonWidth ? make.width.mas_equalTo(self.centerButtonWidth) : make.width.mas_equalTo(self).multipliedBy(0.3);
        self.centerButtonHeight ? make.height.mas_equalTo(self.centerButtonHeight) : make.height.mas_equalTo(self.mas_height).multipliedBy(1.0);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)layoutContentView {
    [self.leftContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self.centerButton.mas_left);
    }];
    
    [self.rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self.centerButton.mas_right);
    }];
}

#pragma mark --------------------  geter  --------------------

- (SMKFoldingTabBarState)state {
    return self.isSelectedCenterButton;
}

#pragma mark --------------------  setter  --------------------

- (void)setIsRoundExtraItem:(BOOL)isRoundExtraItem {
    _isRoundExtraItem = isRoundExtraItem;
    
    [self layoutIfNeeded];
    [self enumerateObjects:self.leftButtonsArray usingBlock:^(UIButton *button) {
        button.layer.cornerRadius = button.height * 0.5;
        button.layer.masksToBounds = isRoundExtraItem;
    }];
    [self enumerateObjects:self.rightButtonsArray usingBlock:^(UIButton *button) {
        button.layer.cornerRadius = button.height * 0.5;
        button.layer.masksToBounds = isRoundExtraItem;
    }];
}

- (void)setCenterButtonTextColor:(UIColor *)centerButtonTextColor {
    _centerButtonTextColor = centerButtonTextColor;
    [self.centerButton setTitleColor:centerButtonTextColor forState:UIControlStateNormal];
}

- (void)setCenterButtonTextFont:(UIFont *)centerButtonTextFont {
    _centerButtonTextFont = centerButtonTextFont;
    self.centerButton.titleLabel.font = centerButtonTextFont;
}

- (void)setCenterButtonText:(NSString *)centerButtonText {
    _centerButtonTextFont = [centerButtonText copy];
    [self.centerButton setTitle:centerButtonText forState:UIControlStateNormal];
}

- (void)setCenterButtonImage:(UIImage *)centerButtonImage {
    _centerButtonImage = centerButtonImage;
    [self.centerButton setImage:centerButtonImage forState:UIControlStateNormal];
}

- (void)setCenterButtonBackColor:(UIColor *)centerButtonBackColor {
    _centerButtonBackColor = centerButtonBackColor;
    self.centerButton.backgroundColor = centerButtonBackColor;
}

- (void)setTextFont:(UIFont *)textFont {
    _textFont = textFont;
    [self enumerateObjects:self.leftButtonsArray usingBlock:^(UIButton *button) {
        button.titleLabel.font = textFont;
    }];
    [self enumerateObjects:self.rightButtonsArray usingBlock:^(UIButton *button) {
        button.titleLabel.font = textFont;
    }];
}

- (void)setLeftTextColor:(UIColor *)leftTextColor {
    _leftTextColor = leftTextColor;
    [self enumerateObjects:self.leftButtonsArray usingBlock:^(UIButton *button) {
        [button setTitleColor:leftTextColor forState:UIControlStateNormal];
    }];
}

- (void)setRightTextColor:(UIColor *)rightTextColor {
    _rightTextColor = rightTextColor;
    [self enumerateObjects:self.rightButtonsArray usingBlock:^(UIButton *button) {
        [button setTitleColor:rightTextColor forState:UIControlStateNormal];
    }];
}

- (void)setLeftBackColor:(UIColor *)leftBackColor {
    _leftBackColor = leftBackColor;
    [self enumerateObjects:self.leftButtonsArray usingBlock:^(UIButton *button) {
        button.backgroundColor = leftBackColor;
    }];
}

- (void)setRightBackColor:(UIColor *)rightBackColor {
    _rightBackColor = rightBackColor;
    [self enumerateObjects:self.rightButtonsArray usingBlock:^(UIButton *button) {
        button.backgroundColor = rightBackColor;
    }];
}

- (void)setIsRoundCenterButton:(BOOL)isRoundCenterButton {
    _isRoundCenterButton = isRoundCenterButton;
    
    if (isRoundCenterButton) {
        [self layoutIfNeeded];
        
        self.centerButton.layer.cornerRadius = self.centerButton.height * 0.5;
        self.centerButton.layer.masksToBounds = YES;
    } else {
        self.centerButton.layer.masksToBounds = NO;
    }
}

- (void)setCenterButtonCornerRadius:(CGFloat)centerButtonCornerRadius {
    _centerButtonCornerRadius = centerButtonCornerRadius;
    self.centerButton.layer.cornerRadius = centerButtonCornerRadius;
    self.centerButton.layer.masksToBounds = YES;
}

- (void)setCenterButtonWidth:(CGFloat)centerButtonWidth {
    _centerButtonWidth = centerButtonWidth;
    [self layoutCenterButton];
    self.isRoundCenterButton = self.isRoundCenterButton;
}

- (void)setCenterButtonHeight:(CGFloat)centerButtonHeight {
    _centerButtonHeight = centerButtonHeight;
    [self layoutCenterButton];
    self.isRoundCenterButton = self.isRoundCenterButton;
}

- (void)setLeftTitlesArray:(NSArray *)leftTitlesArray {
    
    _leftTitlesArray = [leftTitlesArray copy];
    
    [self.leftButtonsArray removeAllObjects];
    [self.leftContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = leftTitlesArray.count;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = self.leftBackColor;
        [button setTitle:[leftTitlesArray objectAtIndex:index] forState:UIControlStateNormal];
        button.titleLabel.font = self.textFont;
        [button setTitleColor:self.leftTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.leftContentView addSubview:button];
        [self.leftButtonsArray addObject:button];
    }
    
    [self.leftButtonsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                    withFixedItemLength:(self.leftItemLength ? self.leftItemLength : 32)
                                            leadSpacing:(self.leftLeadSpacing ? self.leftLeadSpacing : 8)
                                            tailSpacing: (self.leftTailSpacing ? self.leftTailSpacing : 8) ];
    [self.leftButtonsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightContentView);
        make.height.mas_equalTo((self.leftButtonHeight > 0 ? self.leftButtonHeight : 32));
    }];
    [self.leftContentView layoutIfNeeded];
    
}

- (void)setLeftImagesArray:(NSArray *)leftImagesArray {
    _leftImagesArray = [leftImagesArray copy];
    
    [self.leftButtonsArray removeAllObjects];
    [self.leftContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = leftImagesArray.count;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = self.leftBackColor;
        [button setImage:[leftImagesArray objectAtIndex:index] forState:UIControlStateNormal];
        button.titleLabel.font = self.textFont;
        [button setTitleColor:self.leftTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.leftContentView addSubview:button];
        [self.leftButtonsArray addObject:button];
    }
    
    [self.leftButtonsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                    withFixedItemLength:(self.leftItemLength ? self.leftItemLength : 32)
                                            leadSpacing:(self.leftLeadSpacing ? self.leftLeadSpacing : 8)
                                            tailSpacing: (self.leftTailSpacing ? self.leftTailSpacing : 8) ];
    [self.leftButtonsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightContentView);
        make.height.mas_equalTo((self.leftButtonHeight > 0 ? self.leftButtonHeight : 32));
    }];
    [self.leftContentView layoutIfNeeded];
}

- (void)setRightTitlesArray:(NSArray *)rightTitlesArray {
    
    _rightTitlesArray = [rightTitlesArray copy];
    
    [self.rightButtonsArray removeAllObjects];
    [self.rightContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = rightTitlesArray.count;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = self.rightBackColor;
        [button setTitle:[rightTitlesArray objectAtIndex:index] forState:UIControlStateNormal];
        button.titleLabel.font = self.textFont;
        [button setTitleColor:self.rightTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rightContentView addSubview:button];
        [self.rightButtonsArray addObject:button];
    }
    
    [self.rightButtonsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                     withFixedItemLength:(self.rightItemLength ? self.rightItemLength : 32)
                                             leadSpacing:(self.rightLeadSpacing ? self.rightLeadSpacing : 8)
                                             tailSpacing: (self.rightTailSpacing ? self.rightTailSpacing : 8) ];
    [self.rightButtonsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightContentView);
        make.height.mas_equalTo((self.rightButtonHeight > 0 ? self.rightButtonHeight : 32));
    }];
    
}

- (void)setRightImagesArray:(NSArray *)rightImagesArray {
    _rightImagesArray = [rightImagesArray copy];
    
    [self.rightButtonsArray removeAllObjects];
    [self.rightContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = rightImagesArray.count;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = self.rightBackColor;
        [button setImage:[rightImagesArray objectAtIndex:index] forState:UIControlStateNormal];
        button.titleLabel.font = self.textFont;
        [button setTitleColor:self.rightTextColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.rightContentView addSubview:button];
        [self.rightButtonsArray addObject:button];
    }
    
    [self.rightButtonsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                     withFixedItemLength:(self.rightItemLength ? self.rightItemLength : 32)
                                             leadSpacing:(self.rightLeadSpacing ? self.rightLeadSpacing : 8)
                                             tailSpacing: (self.rightTailSpacing ? self.rightTailSpacing : 8) ];
    [self.rightButtonsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightContentView);
        make.height.mas_equalTo((self.rightButtonHeight > 0 ? self.rightButtonHeight : 32));
    }];
}

#pragma mark --------------------  懒加载  --------------------

- (UIButton *)centerButton {
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerButton addTarget:self action:@selector(centerButtonTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerButton];
    }
    return _centerButton;
}

- (NSMutableArray *)leftButtonsArray {
    if (!_leftButtonsArray) {
        _leftButtonsArray = [NSMutableArray array];
    }
    return _leftButtonsArray;
}

- (NSMutableArray *)rightButtonsArray {
    if (!_rightButtonsArray) {
        _rightButtonsArray = [NSMutableArray array];
    }
    return _rightButtonsArray;
}

- (UIView *)leftContentView {
    if (!_leftContentView) {
        _leftContentView = [[UIView alloc] init];
        _leftContentView.hidden = YES;
        [self addSubview:_leftContentView];
    }
    return _leftContentView;
}

- (UIView *)rightContentView {
    if (!_rightContentView) {
        _rightContentView = [[UIView alloc]init];
        _rightContentView.hidden = YES;
        [self addSubview:_rightContentView];
    }
    return _rightContentView;
}

@end
