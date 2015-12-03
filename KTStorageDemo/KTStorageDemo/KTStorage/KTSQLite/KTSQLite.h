//
//  KTSQLite.h
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface KTSQLite : NSObject

+ (instancetype)sharedModel;

- (void)openDataBase;

- (void)creatTable:(NSString *)tableName
        PrimaryKey:(NSString *)key
        TextColumn:(NSArray *)textColumnArray
     IntegerColumn:(NSArray *)integerColoumnArray;

- (void)insertDataInTable:(NSString *)tableName
           DataDictionary:(NSDictionary *)data;

- (NSInteger)getItemCountOfTable:(NSString *)tableName;
- (NSArray *)getColumnName:(NSString *)tableName;

- (NSArray *)searchTable:(NSString *)tableName SearchString:(NSString *)searchString;
- (BOOL)deleteDataINTable:(NSString *)tableName WithID: (NSInteger)contentID;
- (NSDictionary *)findDataInTable:(NSString *)tableName WithID:(NSInteger)contentID;
- (NSArray *)getAllItemIDInTable:(NSString *)tableName;
- (void)updateItemInTable:(NSString *)tableName WithID:(NSInteger)contentID updateDictionary:(NSDictionary *)updateDic;
- (NSArray *)searchTable:(NSString *)tableName ColumnName:(NSString *)columnText SearchString:(NSString *)searchString;

@end
