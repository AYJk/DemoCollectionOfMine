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
@property (weak, nonatomic) IBOutlet UITextView *sqliteInfoTextView;
@property (nonatomic, strong) NSMutableString *sqliteInfoMessage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@end

@implementation MagicalRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _sqliteInfoMessage = [[NSMutableString alloc] init];
//    User *user1 = [User MR_createEntity];
//    user1.name = @"AndyJ";
//    user1.age = @20;
//    user1.sex = @"男";
//
//    User *user2 = [User MR_createEntity];
//    user2.name = @"AndyJe";
//    user2.age = @24;
//    user2.sex = @"Man";
//    
//    //保存user1
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    //查询第一个对象
//    User *user11 = [User MR_findFirst];
    [self searchRecord:nil];
}

- (IBAction)addRecord:(UIButton *)sender {
    
    //新增记录
    User *user1 = [User MR_createEntity];
    user1.name = _nameTextField.text;
    user1.age = [NSNumber numberWithInteger:[_ageTextField.text intValue]];
    user1.sex = _sexTextField.text;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self searchRecord:nil];
}

- (IBAction)deleteAllRecord:(UIButton *)sender {
    //  删除全部
    NSArray *userArr = [User MR_findAll];
    for (User *user in userArr) {
        [user MR_deleteEntity];
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [self searchRecord:nil];
}

- (IBAction)deleteRecord:(UIButton *)sender {

    
}

- (IBAction)modifyRecord:(UIButton *)sender {
    
    
}

- (IBAction)searchRecord:(UIButton *)sender {
    NSArray *users = [User MR_findAll];
    if (users == nil || users.count == 0) {
        _sqliteInfoTextView.text = @"None";
        return;
    }
    for (User *user2 in users) {
        [_sqliteInfoMessage appendFormat:@"%@----%@----%@\n",user2.name,user2.age,user2.sex];
    }
    _sqliteInfoTextView.text = [_sqliteInfoMessage copy];
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
