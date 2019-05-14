//
//  KCNormalTabBar.m
//  Knowchat04
//
//  Created by knowchatMac01 on 2019/4/21.
//  Copyright © 2019年 yyk. All rights reserved.
//

#import "KCNormalTabBar.h"

@implementation KCNormalTabBar

- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage titleStr:(NSString *)title titleToImgSpace:(CGFloat)titleToImgSpace {
    if (self = [super init]) {
        self.midBtnNormalImg = normalImage;
        self.midBtnSelectedImg = selectedImage;
        self.midBtnTitleStr = title;
        self.titleToImgSpace = titleToImgSpace;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [self bringSubviewToFront:view];
            [tabBarButtonArray addObject:view];
        }
    }

    if (self.tabBarButtons) {
        [self.tabBarButtons removeAllObjects];
    }
    self.tabBarButtons = tabBarButtonArray;
    
    if (tabBarButtonArray.count == 0) {
        return;
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGSize titleSize = [self.midBtnTitleStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.f]}];
    CGSize midImgSize = self.midBtnSelectedImg.size;
    CGFloat midBtnWidth = midImgSize.width;
    CGFloat midBtnHeight = self.midBtnTitleStr.length > 0 ? midImgSize.height + titleSize.height + self.titleToImgSpace : midImgSize.height;
    
    // 重新布局其他 tabBarItem
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - midBtnWidth) / (tabBarButtonArray.count - 1);
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;
        if (idx > tabBarButtonArray.count / 2) {
            frame.origin.x = (idx - 1) * barItemWidth + midBtnWidth;
            frame.size.width = barItemWidth;
        }else if (idx < tabBarButtonArray.count / 2) {
            frame.origin.x = idx * barItemWidth;
            frame.size.width = barItemWidth;
        }else {
            frame.origin.x = idx * barItemWidth;
            frame.origin.y = -midImgSize.height / 2.0;
            frame.size = CGSizeMake(midBtnWidth, midBtnHeight);
        }
        
        view.frame = frame;
    }];
}

//扩大点击区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.tabBarButtons.count / 2 < self.tabBarButtons.count) {
        if (self.isHidden == NO) {
            UIView *midTabBarButton = self.tabBarButtons[self.tabBarButtons.count / 2];
            CGPoint newA = [self convertPoint:point toView:midTabBarButton];
            if (CGRectContainsPoint(midTabBarButton.bounds, newA)) {
                return midTabBarButton;
            }else {
                return [super hitTest:point withEvent:event];
            }
        }else {
            return [super hitTest:point withEvent:event];
        }
    }
    return [super hitTest:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
