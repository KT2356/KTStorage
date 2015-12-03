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

//打开数据库
- (void)openDataBase {
    NSString *pathString = [self getDataBasePath:[[KTPlist mainPlist] valueForKey:@"CFBundleName"]];
    if (sqlite3_open([pathString UTF8String], &db) != SQLITE_OK) {
        NSLog(@"数据库打开失败");
    }
}

//新建table
- (void)creatTable:(NSString *)tableName
        PrimaryKey:(NSString *)key
        TextColumn:(NSArray *)textColumnArray
     IntegerColumn:(NSArray *)integerColoumnArray
{
    NSString *creatTableSQLStr = [self creatTableSQLtext:textColumnArray IntegerColumn:integerColoumnArray];
    NSString *sqlCreateTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@)",tableName,key,creatTableSQLStr];

    [self execSql:sqlCreateTable success:^{
        NSLog(@"creat table success");
    } failed:^(NSInteger state, char *msg) {
        NSLog(@"SQLite creatTable Error-----state:%ld-----msg:%s",(long)state,msg);
    }];
}

//table插入数据
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
    [self execSql:sql success:^{
        NSLog(@"insert data success");
    } failed:^(NSInteger state, char *msg) {
        NSLog(@"SQLite insertData Error-----state:%ld-----msg:%s",(long)state,msg);
    }];
}

//获取table数据总量  TODO：代优化
- (NSInteger)getItemCountOfTable:(NSString *)tableName {
   __block NSInteger count = 0;
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@",tableName] ;
    [self searchSQL:sqlQuery success:^(sqlite3_stmt *statement) {
        count = count +1;
    } failed:^(NSInteger state) {
        NSLog(@"SQL ItemCount Error - state:%ld",(long)state);
    }];
    return count;
}

//获取列名
- (NSArray *)getColumnName:(NSString *)tableName {
    sqlite3_stmt * statement;
    NSMutableArray *columnArray = [@[] mutableCopy];
     NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@",tableName] ;
    NSInteger state = sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil);
    if (state == SQLITE_OK) {
        int t =  sqlite3_column_count(statement);
        for (int i = 0 ; i < t; i ++) {
            NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(statement, i)];
            [columnArray addObject:columnName];
        }
    } else {
       NSLog(@"SQL getColumnName - state:%ld",(long)state);
    }
    return [NSArray arrayWithArray:columnArray];
}


- (NSArray *)searchTable:(NSString *)tableName SearchString:(NSString *)searchString {
    NSMutableArray *resultArray = [@[] mutableCopy];
    
    
    NSString *SQLString = [NSString stringWithFormat:@"SELECT * FROM %@ where contentNAME LIKE  '%%%@%%' or contentMOBILETEL LIKE  '%%%@%%' or  contentHOMETEL LIKE  '%%%@%%' or  contentGROUP LIKE  '%%%@%%'  or contentADDRESS LIKE  '%%%@%%' or contentREMARK  LIKE  '%%%@%%'",tableName];
    
    
    return [NSArray arrayWithArray:resultArray];
}

- (NSString *)searchSQLGenerate:(NSString *)tableName SearchString:(NSString *)searchStr {
    NSString *result;
    NSArray *colunmArray = [self getColumnName:tableName];
    for (int i = 1; i < colunmArray.count; i ++) {
        NSString *tempStr = [NSString stringWithFormat:@""];
    }
    
    return result;
}


#pragma mark - private methods
//Search SQL
- (void)searchSQL:(NSString *)sql success:(void(^)(sqlite3_stmt * statement))successBlock failed:(void(^)(NSInteger state))failedBlock {
    sqlite3_stmt * statement;
    NSInteger state = sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil);
    if (state == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            successBlock(statement);
        }
    } else {
        failedBlock(state);
    }
}


//SQL执行语句 回调状态
- (void)execSql:(NSString *)sql success:(void(^)())successBlock failed:(void(^)(NSInteger state,char *msg))failedBlock {
    char *err;
    NSInteger state = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
    if (state == 0) {
        successBlock();
    } else {
        failedBlock(state,err);
    }
}


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
