//
//  QQMenuView.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionBlock)(NSInteger index);

@interface QQMenuView : UIView

+ (void)qqMenuViewWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images titles:(NSArray<NSString *> *)titles block:(ActionBlock)block;

@end
