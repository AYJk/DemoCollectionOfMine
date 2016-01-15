//
//  PathMenuViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/30.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "PathMenuViewController.h"
#import "PathButtonView.h"
#import "PathButton.h"
#import "PaperButton.h"
#import "QQMenuView.h"
@interface PathMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *menuLabel;

@end

@implementation PathMenuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configView];
    self.title = @"菜单动画";
    PaperButton *paperBtn = [[PaperButton alloc] initWithFrame:CGRectMake(0, 0, 24, 19)];
    paperBtn.tintColor = [UIColor blueColor];
    
    paperBtn.paperButtonBlock = ^(PaperButton *paperButton) {
        
        NSLog(@"paperButton Clicked");
        [QQMenuView qqMenuViewWithFrame:CGRectMake(self.view.frame.size.width - 100, 64, 150, 200) images:@[[UIImage imageNamed:@"saoyisao"],[UIImage imageNamed:@"jiahaoyou"],[UIImage imageNamed:@"taolun"],[UIImage imageNamed:@"diannao"],[UIImage imageNamed:@"diannao"],[UIImage imageNamed:@"shouqian"]] titles:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] block:^(NSInteger index) {
            
            NSLog(@"点击第%ld个按钮",index);
        }];
    };

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:paperBtn];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)configView {
    
    PathButtonView *pathView = [[PathButtonView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pathView.centerItemNormalImage = @"chooser-button-input";
    pathView.centerItemHighlightImage = @"chooser-button-input-highlighted";
    [self.view addSubview:pathView];
    
    PathButton *item1 = [PathButton buttonWithType:UIButtonTypeCustom];
    [item1 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-music"] forState:UIControlStateNormal];
    [item1 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-music-highlighted"] forState:UIControlStateHighlighted];
    [item1 clickAction:^(PathButton *pathButton) {
        NSLog(@"click 1");
    }];
    
    PathButton *item2 = [PathButton buttonWithType:UIButtonTypeCustom];
    [item2 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-place"] forState:UIControlStateNormal];
    [item2 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-place-highlighted"] forState:UIControlStateHighlighted];
    [item2 clickAction:^(PathButton *pathButton) {
        NSLog(@"click 2");
    }];
    
    PathButton *item3 = [PathButton buttonWithType:UIButtonTypeCustom];
    [item3 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-camera"] forState:UIControlStateNormal];
    [item3 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-camera-highlighted"] forState:UIControlStateHighlighted];
    [item3 clickAction:^(PathButton *pathButton) {
        NSLog(@"click 3");
    }];
    
    PathButton *item4 = [PathButton buttonWithType:UIButtonTypeCustom];
    [item4 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-thought"] forState:UIControlStateNormal];
    [item4 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-thought-highlighted"] forState:UIControlStateHighlighted];
    [item4 clickAction:^(PathButton *pathButton) {
        NSLog(@"click 4");
    }];
    
    PathButton *item5 = [PathButton buttonWithType:UIButtonTypeCustom];
    [item5 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-sleep"] forState:UIControlStateNormal];
    [item5 setBackgroundImage:[UIImage imageNamed:@"chooser-moment-icon-sleep-highlighted"] forState:UIControlStateHighlighted];
    [item5 clickAction:^(PathButton *pathButton) {
        NSLog(@"click 5");
    }];
    
    pathView.pathItems = @[item1,item2,item3,item4,item5];

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
