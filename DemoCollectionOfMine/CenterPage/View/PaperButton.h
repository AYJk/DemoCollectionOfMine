//
//  PaperButton.h
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaperButton;

typedef void(^PaperButtonBlock)(PaperButton *paperBtn);

@interface PaperButton : UIControl

@property (nonatomic, copy) PaperButtonBlock paperButtonBlock;

@end
