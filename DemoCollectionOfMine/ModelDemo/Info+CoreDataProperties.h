//
//  Info+CoreDataProperties.h
//  DemoCollectionOfMine
//
//  Created by Andy on 16/1/20.
//  Copyright © 2016年 Andy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Info.h"

NS_ASSUME_NONNULL_BEGIN

@interface Info (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSNumber *telPhone;
@property (nullable, nonatomic, retain) User *user;

@end

NS_ASSUME_NONNULL_END
