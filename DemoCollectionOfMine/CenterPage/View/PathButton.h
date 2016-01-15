//
//  PathButton.h
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PathButton;
typedef void(^ClickButtonBlock)(PathButton *pathButton);
@protocol PathButtonDelegate <NSObject>

- (void)pathButtonDidClicked:(PathButton *)pathButton;

@end


@interface PathButton : UIButton

@property (nonatomic, strong) id<PathButtonDelegate>delegate;

@property (nonatomic, copy) ClickButtonBlock clickButtonBlock;



- (void)clickAction:(ClickButtonBlock)clickButtonBlock;

@end
