//
//  KCNormalTabBar.h
//  Knowchat04
//
//  Created by knowchatMac01 on 2019/4/21.
//  Copyright © 2019年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KCNormalTabBar : UITabBar
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) UIImage *midBtnNormalImg;
@property (nonatomic, strong) UIImage *midBtnSelectedImg;
@property (nonatomic, strong) NSString *midBtnTitleStr;
@property (nonatomic, assign) CGFloat titleToImgSpace;

- (instancetype)initWithMidBtnNormalImage:(UIImage *)normalImage
                            selectedImage:(UIImage *)selectedImage
                                 titleStr:(NSString *)title
                          titleToImgSpace:(CGFloat)titleToImgSpace;
@end

NS_ASSUME_NONNULL_END
