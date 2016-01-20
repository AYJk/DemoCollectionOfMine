//
//  MagicalRecordViewController.m
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/20.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MagicalRecordViewController.h"
#import "Info.h"
#import "User.h"
@interface MagicalRecordViewController ()

@end

@implementation MagicalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user1 = [User MR_createEntity];
    user1.name = @"AndyJ";
    user1.age = @20;
    user1.sex = @"男";

    User *user2 = [User MR_createEntity];
    user2.name = @"AndyJe";
    user2.age = @24;
    user2.sex = @"Man";
    
    //保存user1
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    //查询第一个对象
    User *user11 = [User MR_findFirst];
    NSLog(@"111111%@----%@----%@",user11.name,user11.age,user11.sex);
    
    NSArray *users = [User MR_findAll];
    for (User *user2 in users) {
        NSLog(@"2222222%@----%@----%@",user2.name,user2.age,user2.sex);
    }
    //删除默认上下文中得所有Person实体
    [User MR_truncateAll];
}

//- (void)saveUserWithUserEntity:() {
//    
//    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
//        
//        
//    } completion:^(BOOL contextDidSave, NSError *error) {
//        
//    }];
//}

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
