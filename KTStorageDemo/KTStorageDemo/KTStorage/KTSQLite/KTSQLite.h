//
//  KTSQLite.h
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KTSQLite : NSObject
+ (instancetype)sharedModel ;

- (void)openDataBase;

- (void)creatTable:(NSString *)tableName
        PrimaryKey:(NSString *)key
        TextColumn:(NSArray *)textColumnArray
     IntegerColumn:(NSArray *)integerColoumnArray;

- (void)insertDataInTable:(NSString *)tableName DataDictionary:(NSDictionary *)data;
@end
