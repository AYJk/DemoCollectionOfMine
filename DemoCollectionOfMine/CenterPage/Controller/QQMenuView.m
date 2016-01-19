//
//  QQMenuView.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "QQMenuView.h"

@interface QQMenuView() <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) ActionBlock block;

@end

UITableView *_menuTableView;
QQMenuView *_backgroundView;

static NSString *cellID = @"menuTableViewCell";
@implementation QQMenuView

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


+ (void)qqMenuViewWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images titles:(NSArray<NSString *> *)titles block:(ActionBlock)block {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _backgroundView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    _backgroundView.images = images;
    _backgroundView.titles = titles;
    _backgroundView.block = block;

    _backgroundView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.6];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:_backgroundView action:@selector(tapAction:)];
    [_backgroundView addGestureRecognizer:tap];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:_backgroundView];
    
    _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 156 + frame.size.width * .5, 74 - 40 * titles.count * .5, frame.size.width, 40 * titles.count) style:UITableViewStylePlain];
    [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    _menuTableView.rowHeight = 40;
    _menuTableView.delegate = _backgroundView;
    _menuTableView.dataSource = _backgroundView;
    _menuTableView.bounces = NO;
    _menuTableView.layer.cornerRadius = 10;
    _menuTableView.transform = CGAffineTransformMakeScale(.0001, .0001);
    _menuTableView.layer.anchorPoint = CGPointMake(1, 0);
//    _menuTableView.alpha = 0;

//    [UIView animateWithDuration:1 animations:^{
//        _menuTableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//        _menuTableView.alpha = 1;
//    }];
    
    POPBasicAnimation *largeAnima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    largeAnima.fromValue = [NSValue valueWithCGSize:CGSizeMake(0, 0)];
    largeAnima.toValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
    largeAnima.beginTime = CACurrentMediaTime();
    largeAnima.duration = .5;
    [_menuTableView.layer pop_addAnimation:largeAnima forKey:@"LargeAnima"];
    [window addSubview:_menuTableView];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    [_backgroundView removeFromSuperview];
    [_menuTableView removeFromSuperview];
    
}

#pragma mark - UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.imageView.image = _images[indexPath.row];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _block(indexPath.row);
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGContextMoveToPoint(context, screenWidth - 20, 74);
    CGContextAddLineToPoint(context, screenWidth - 20 * 2, 74);
    CGContextAddLineToPoint(context, screenWidth - 30, 60);
    CGContextClosePath(context);
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
