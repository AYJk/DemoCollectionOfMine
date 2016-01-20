//
//  User+CoreDataProperties.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/20.
//  Copyright © 2016年 Andy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *sex;
@property (nullable, nonatomic, retain) NSSet<Info *> *infos;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addInfosObject:(Info *)value;
- (void)removeInfosObject:(Info *)value;
- (void)addInfos:(NSSet<Info *> *)values;
- (void)removeInfos:(NSSet<Info *> *)values;

@end

NS_ASSUME_NONNULL_END
