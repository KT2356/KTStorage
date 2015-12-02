//
//  KTSQLite.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTSQLite.h"
#import "KTPlist.h"
#import "sqlite3.h"

@interface KTSQLite()
{
    sqlite3 *db;
}
@end

@implementation KTSQLite

#pragma mark - public methods
+ (instancetype)sharedModel {
    static dispatch_once_t onceToken;
    static KTSQLite *sqlite;
    dispatch_once(&onceToken, ^{
        sqlite = [[KTSQLite alloc] init];
    });
    return sqlite;
}

- (void)openDataBase {
    NSString *pathString = [self getDataBasePath:[[KTPlist mainPlist] valueForKey:@"CFBundleName"]];
    if (sqlite3_open([pathString UTF8String], &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    }
}

#pragma mark - 新建表
- (void)creatTable:(NSString *)tableName
        PrimaryKey:(NSString *)key
        TextColumn:(NSArray *)textColumnArray
     IntegerColumn:(NSArray *)integerColoumnArray
{
    NSString *creatTableSQLStr = [self creatTableSQLtext:textColumnArray IntegerColumn:integerColoumnArray];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@)",tableName,key,creatTableSQLStr];
    
    [self execSql:sqlCreateTable];
}


#pragma mark - 插入数据
- (void)insertDataInTable:(NSString *)tableName DataDictionary:(NSDictionary *)data
{
    if (!data) {
        return;
    }
    __block NSString *keyString = [[NSString alloc] init];
    __block NSString *objString = [[NSString alloc] init];
    [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        keyString = [keyString stringByAppendingString:[NSString stringWithFormat:@"'%@',",key]];
        objString = [objString stringByAppendingString:[NSString stringWithFormat:@"'%@',",obj]];
    }];
    keyString = [keyString substringToIndex:[keyString length]-1];
    objString = [objString substringToIndex:[objString length]-1];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableName,keyString,objString];
    [self execSql:sql];
}



- (void)execSql:(NSString *)sql {
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败! %d",sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err));
    }
}


#pragma mark - private methods
//数据库路径
- (NSString *)getDataBasePath:(NSString *)tableName {
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathString = pathArray[0];
    pathString = [pathString stringByAppendingString:[NSString stringWithFormat:@"%@.sqlite",tableName]];
    NSLog(@"%@",pathString);
    return pathString;
}

//建表 SQL 语句生成
- (NSString *)creatTableSQLtext:(NSArray *)textColumnArray IntegerColumn:(NSArray *)integerColoumnArray {
    NSString *outString = [[NSString alloc] init];
    for (int i = 0; i < textColumnArray.count; i ++) {
        NSString *type = [NSString stringWithFormat:@"%@ TEXT,",textColumnArray[i]];
        outString = [outString stringByAppendingString:type];
    }
    if (integerColoumnArray) {
        for (int i = 0; i < integerColoumnArray.count; i ++) {
            NSString *type = [NSString stringWithFormat:@"%@ INTEGER,",integerColoumnArray[i]];
            outString = [outString stringByAppendingString:type];
        }
    }
    outString = [outString substringToIndex:outString.length -1];
    return outString;
}
@end
