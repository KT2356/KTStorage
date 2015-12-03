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

//打开数据库
- (void)openDataBase ;
//新建table
- (void)creatTable:(NSString *)tableName
        PrimaryKey:(NSString *)key
        TextColumn:(NSArray *)textColumnArray
     IntegerColumn:(NSArray *)integerColoumnArray;

//table插入数据
- (void)insertDataInTable:(NSString *)tableName
           DataDictionary:(NSDictionary *)data;

//获取table数据总量  TODO：代优化
- (NSInteger)getItemCountOfTable:(NSString *)tableName ;
//返回表中数据全部ID Array
- (NSArray *)getAllItemIDInTable:(NSString *)tableName ;

//获取列名
- (NSArray *)getColumnName:(NSString *)tableName;


//全字段搜索，返回ID 数组
- (NSArray *)searchTable:(NSString *)tableName
            SearchString:(NSString *)searchString ;
//指定字段搜索
- (NSArray *)searchTable:(NSString *)tableName
              ColumnName:(NSString *)columnText
            SearchString:(NSString *)searchString ;
//由主键找到数据
- (NSDictionary *)findDataInTable:(NSString *)tableName
                           WithID:(NSInteger)contentID ;


// 由主键删除数据
- (BOOL)deleteDataINTable:(NSString *)tableName
                   WithID: (NSInteger)contentID ;
//清空表
- (void)emptyTable:(NSString *)tableName ;
//跟新已存在数据
- (void)updateItemInTable:(NSString *)tableName
                   WithID:(NSInteger)contentID
         updateDictionary:(NSDictionary *)updateDic;

@end
