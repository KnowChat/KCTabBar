//
//  KCTabBar.m
//  Knowchat04
//
//  Created by knowchatMac01 on 2018/4/4.
//  Copyright © 2018年 yyk. All rights reserved.
//

#import "KCMidBtnTabBar.h"

@implementation KCMidBtnTabBar

- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage titleStr:(NSString *)title {
    return [self initWithMidBtnNormalImage:normalImage selectedImage:selectedImage titleStr:title titleToImgSpace:2 centerBtnOriginY:-normalImage.size.height / 2.0];
}

- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage titleStr:(NSString *)title titleToImgSpace:(CGFloat)titleToImgSpace centerBtnOriginY:(CGFloat)centerBtnOriginY {
    if (self = [super init]) {
        self.midBtnNormalImg = normalImage;
        self.midBtnSelectedImg = selectedImage;
        self.midBtnTitleStr = title;
        self.titleToImgSpace = titleToImgSpace;
        self.centerBtnOriginY = centerBtnOriginY;
    }
    return self;
}

- (UIButton *)centerBtn {
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] init];
        [_centerBtn setImage:self.midBtnNormalImg forState:UIControlStateNormal];
        [_centerBtn setImage:self.midBtnSelectedImg forState:UIControlStateSelected];
        [_centerBtn setTitle:self.midBtnTitleStr forState:UIControlStateNormal];
        [_centerBtn setTitleColor:[UIColor colorWithRed:48 / 255.0 green:200 / 255.0 blue:250 / 255.0 alpha:1.0] forState:UIControlStateSelected];
        [_centerBtn setTitleColor:[UIColor colorWithRed:187 / 255.0 green:187 / 255.0 blue:187 / 255.0 alpha:1.0] forState:UIControlStateNormal];
        _centerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10.f];
        [_centerBtn addTarget:self action:@selector(btnCenterEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_centerBtn];
    }
    return _centerBtn;
}

- (void)btnCenterEvent:(UIButton *)btn {
    if (self.centerClickBlock) {
        self.centerClickBlock();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    
    if (tabBarButtonArray.count == 0) {
        return;
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat midBtnWidth = barWidth / (tabBarButtonArray.count + 1);
    CGFloat midBtnHeight = CGRectGetHeight(((UIView *)tabBarButtonArray[0]).frame);
    // 设置中间按钮的位置，居中
    CGSize sizeImage = self.midBtnNormalImg.size;
    NSString *titleStr = [self.centerBtn titleForState:UIControlStateNormal];
    CGSize sizeTitle = [titleStr sizeWithAttributes:@{NSFontAttributeName:self.centerBtn.titleLabel.font}];
    midBtnWidth = midBtnWidth > sizeImage.width ? midBtnWidth : sizeImage.width;
    if (titleStr.length > 0) {
        self.centerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.centerBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        midBtnHeight = midBtnHeight > sizeImage.height + self.titleToImgSpace + sizeTitle.height ? midBtnHeight : sizeImage.height + self.titleToImgSpace + sizeTitle.height;
        self.centerBtn.bounds = CGRectMake(0, 0, midBtnWidth, midBtnHeight);
        CGRect frame = self.centerBtn.bounds;
        frame.origin.x = barWidth / 2.0 - midBtnWidth / 2.0;
        frame.origin.y = self.centerBtnOriginY;
        self.centerBtn.frame = frame;
        [self.centerBtn setImageEdgeInsets:UIEdgeInsetsMake(0, (midBtnWidth - sizeImage.width) / 2.0, 0, 0)];
        [self.centerBtn setTitleEdgeInsets:UIEdgeInsetsMake(midBtnHeight - sizeTitle.height, (midBtnWidth - sizeTitle.width) / 2.0 - sizeImage.width, 0, 0)];
    }else {
        midBtnHeight = midBtnHeight > sizeImage.height ? midBtnHeight : sizeImage.height;
        self.centerBtn.bounds = CGRectMake(0, 0, midBtnWidth, midBtnHeight);
        self.centerBtn.center = CGPointMake(barWidth / 2, 0);
    }

    // 重新布局其他 tabBarItem
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - midBtnWidth) / tabBarButtonArray.count;
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + midBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

//扩大点击区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newA = [self convertPoint:point toView:self.centerBtn];
        if ( [self.centerBtn pointInside:newA withEvent:event]) {
            return self.centerBtn;
        }else {
            return [super hitTest:point withEvent:event];
        }
    }else {
        return [super hitTest:point withEvent:event];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
