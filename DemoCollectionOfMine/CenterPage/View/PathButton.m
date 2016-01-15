//
//  PathButton.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/31.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "PathButton.h"
@implementation PathButton

- (void)clickAction:(ClickButtonBlock)clickButtonBlock {
    
    _clickButtonBlock = clickButtonBlock;
    [self addTarget:self action:@selector(clickBlock:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clickBlock:(PathButton *)btn {
    
    if (_clickButtonBlock) {
        _clickButtonBlock(btn);
    }
    if ([_delegate respondsToSelector:@selector(pathButtonDidClicked:)]) {
        [_delegate pathButtonDidClicked:btn];
    }
}

@end
