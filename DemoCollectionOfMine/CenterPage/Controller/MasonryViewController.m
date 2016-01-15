//
//  MasonryViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 15/12/29.
//  Copyright © 2015年 Andy. All rights reserved.
//

#import "MasonryViewController.h"
#import "Masonry.h"


@interface MasonryViewController ()
@property (nonatomic ,strong) UIView *view1;
@property (nonatomic, strong) UIView *calculateView;
@end

@implementation MasonryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self demo1Action:nil];
}

- (void)resetView {
    
    [_view1 removeFromSuperview];
    [_calculateView removeFromSuperview];
    _view1 = [[UIView alloc] init];
    _view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view1];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
}

- (IBAction)resetAction:(id)sender {
    
    [_view1 removeFromSuperview];
    [_calculateView removeFromSuperview];
}

- (IBAction)demo1Action:(id)sender {
    
    [self resetView];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor greenColor];
    [_view1 addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_view1).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
        /* 等价于
         make.top.equalTo(view1).with.offset(10);
         make.left.equalTo(view1).with.offset(10);
         make.bottom.equalTo(view1).with.offset(-10);
         make.right.equalTo(view1).with.offset(-10);
         */
        /* 也等价于
         make.top.left.bottom.and.right.equalTo(view1).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
         */
    }];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor yellowColor];
    [view2 addSubview:view3];
    
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor blueColor];
    [view2 addSubview:view4];
    
    int padding = 10;
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(view2.mas_centerY);
        make.left.equalTo(view2.mas_left).offset(padding);
        make.right.equalTo(view4.mas_left).offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.equalTo(view4);
    }];
    
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.mas_equalTo(view2.mas_centerY);
        make.left.equalTo(view3.mas_right).offset(padding);
        make.right.equalTo(view2.mas_right).offset(-padding);
        make.height.mas_equalTo(@150);
        make.width.equalTo(view3);
    }];
    
}

- (IBAction)demoAction2:(id)sender {
    
    [self resetView];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //    scrollView.backgroundColor = [UIColor lightGrayColor];
    [_view1 addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(_view1).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    int count = 10;
    UIView *lastView = nil;
    for (int index = 0; index < count; index ++) {
        UIView *subView = [UIView new];
        [container addSubview:subView];
        subView.backgroundColor = [UIColor colorWithHue:arc4random() % 256 / 256.0
                                             saturation:arc4random() % 256 / 256.0 + .5
                                             brightness:arc4random() % 256 / 256.0 + .5
                                                  alpha:1];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(container);
            make.height.mas_equalTo(@(20 * index));
            if (lastView) {
                make.top.mas_equalTo(lastView.mas_bottom);
            } else {
                
                make.top.mas_equalTo(container.mas_top);
            }
        }];
        lastView = subView;
    }
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (IBAction)demo3Action:(id)sender {
    
    _calculateView = [UIView new];
    _calculateView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_calculateView];
    [_calculateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 30, 0));
    }];
    
    UIView *displayView = [UIView new];
    displayView.backgroundColor = [UIColor blackColor];
    [_calculateView addSubview:displayView];
    
    UIView *keyBoardView = [UIView new];
    keyBoardView.backgroundColor = [UIColor whiteColor];
    [_calculateView addSubview:keyBoardView];
    
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.edges.equalTo(_calculateView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(_calculateView.mas_top);
        make.left.and.right.equalTo(_calculateView);
        make.height.equalTo(keyBoardView).multipliedBy(1/3.0);
    }];
    
    [keyBoardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(displayView.mas_bottom);
        make.left.and.right.equalTo(_calculateView);
        make.bottom.equalTo(_calculateView.mas_bottom);
    }];
    
    UILabel *displayNum = [UILabel new];
    [displayView addSubview:displayNum];
    displayNum.text = @"0";
    displayNum.textColor = [UIColor whiteColor];
    displayNum.font = [UIFont fontWithName:@"Arial" size:70];
    displayNum.textAlignment = NSTextAlignmentRight;
    [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                      ,@"7",@"8",@"9",@"x"
                      ,@"4",@"5",@"6",@"-"
                      ,@"1",@"2",@"3",@"+"
                      ,@"0",@"?",@".",@"="];
    int index = 0;
    for (NSString *keyStr in keys) {
        
        index ++;
        int rowNum = index % 4 == 0 ? index / 4 : index / 4 + 1; //行
        int colNum = index % 4 == 0 ? 4 : index % 4;//列
        UIButton *keyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyBoardView addSubview:keyBtn];
        [keyBtn setTitle:keyStr forState:UIControlStateNormal];
        [keyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [keyBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [keyBtn.layer setBorderWidth:1];
        [keyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if ([keyStr isEqualToString:@"0"] || [keyStr isEqualToString:@"?"]) {
                if ([keyStr isEqualToString:@"0"]) {
                    [keyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(keyBoardView.mas_left);
                        make.right.equalTo(keyBoardView.mas_centerX);
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.9);
                        make.height.equalTo(keyBoardView.mas_height).multipliedBy(.2);
                    }];
                }
                if ([keyStr isEqualToString:@"?"]) {
                    [keyBtn removeFromSuperview];
                }
                
            } else {
                
                make.width.equalTo(keyBoardView.mas_width).multipliedBy(.25);
                make.height.equalTo(keyBoardView.mas_height).multipliedBy(.2);
                switch (rowNum) {
                    case 1: {
                        
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.1);
                        keyBtn.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                    }
                        break;
                    case 2: {
                        
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.3);
                    }
                        break;
                    case 3: {
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.5);
                    }
                        break;
                    case 4: {
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.7);
                    }
                        break;
                    case 5: {
                        make.baseline.equalTo(keyBoardView.mas_baseline).multipliedBy(.9);
                    }
                        break;
                    default:
                        break;
                }
                switch (colNum) {
                    case 1: {
                        
                        make.left.equalTo(keyBoardView.mas_left);
                    }
                        break;
                    case 2:{
                        make.right.equalTo(keyBoardView.mas_centerX);
                    }
                        break;
                    case 3:{
                        make.left.equalTo(keyBoardView.mas_centerX);
                    }
                        break;
                    case 4:{
                        make.right.equalTo(keyBoardView.mas_right);
                    }
                        break;
                    default:
                        break;
                }
            }
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
