//
//  KTCoreData.h
//  KTStorageDemo
//
//  Created by KT on 15/12/3.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface KTCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (instancetype)initWithModelName:(NSString *)modelName;

- (void)saveContext;

- (NSManagedObject *)getManagedObjectWithEntityName:(NSString *)entityName;
- (NSArray *)searchWithEntityName:(NSString *)entityName withSQLString:(NSString *)SQLString;
- (void)deleteEntity:(NSManagedObject *)object;

@end
