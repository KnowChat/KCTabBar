//
//  KCTabMidBtnBar.h
//  Knowchat04
//
//  Created by knowchatMac01 on 2018/4/4.
//  Copyright © 2018年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KCMidBtnTabBar : UITabBar
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, copy) dispatch_block_t centerClickBlock;
@property (nonatomic, strong) UIImage *midBtnNormalImg;
@property (nonatomic, strong) UIImage *midBtnSelectedImg;
@property (nonatomic, copy) NSString *midBtnTitleStr;
@property (nonatomic, assign) CGFloat titleToImgSpace;
@property (nonatomic, assign) CGFloat centerBtnOriginY;

/**
 初始化，中间按钮中部在TabBar顶部，中间按钮字与图间距为2

 @param normalImage 中间按钮常态图
 @param selectedImage 中间按钮选中图
 @param title 中间按钮标题
 @return 中间按钮的tabbar
 */
- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
                                 titleStr:(NSString *)title;

/**
 初始化，可设置中间按钮位置

 @param normalImage 中间按钮常态图
 @param selectedImage 中间按钮选中图
 @param title 中间按钮标题
 @param titleToImgSpace 中间按钮字与图间距
 @param centerBtnOriginY 中间按钮y开始坐标
 @return 中间按钮的tabbar
 */
- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
                                 titleStr:(NSString *)title
                          titleToImgSpace:(CGFloat)titleToImgSpace
                         centerBtnOriginY:(CGFloat)centerBtnOriginY;
@end
