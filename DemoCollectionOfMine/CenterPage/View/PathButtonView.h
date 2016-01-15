//
//  PathButtonView.h
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/30.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PathButtonView : UIView
/**
 *  添加button的时候不需要给frame
 *
 */
@property (nonatomic, strong) NSArray *pathItems;
@property (nonatomic, copy) NSString *centerItemNormalImage;
@property (nonatomic, copy) NSString *centerItemHighlightImage;

@end
