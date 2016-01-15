//
//  WaterWareView.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/13.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterWareView : UIView
/*
    幅度，波速，增进等均有默认设置，已经可以日常使用
 */
//  水前景色
@property (strong, nonatomic) UIColor *waterColor;
//  水后景色
@property (strong, nonatomic) UIColor *waterShdowColor;
//  波形幅度
@property (assign, nonatomic) CGFloat waveAmplitude;
//  波形速度
@property (assign, nonatomic) CGFloat waveSpeed;
//  增进
@property (assign, nonatomic) BOOL increase;
//  当前进度
@property (assign, nonatomic) CGFloat percent;
//  是否显示当前进度,默认显示
@property (assign, nonatomic) BOOL isShowCurrentPercent;
@end
