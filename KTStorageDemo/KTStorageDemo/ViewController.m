//
//  ViewController.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//
#define tempTableName @"mytablepp"

#import "ViewController.h"
#import "KTStorage.h"
#import "KTCoreData.h"
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self plistStorage];
    //[self userDefaultStorage];
    //[self SQLite];
      [self CoreData];
}

#pragma mark - Core Data
- (void)CoreData {
    KTCoreData *ktCoreData = [[KTCoreData alloc] initWithModelName:@"KTCoreData"];
    
    NSManagedObject *test = [ktCoreData getManagedObjectWithEntityName:@"CorePerson"];
    [test setValue:@"kt111" forKey:@"name"];
    
    
    NSError *error = nil;
    BOOL success = [ktCoreData.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }
    
}

#pragma mark - SQLite
- (void)SQLite {
    //打开数据库，建表
    [[KTSQLite sharedModel] openDataBase];
    [[KTSQLite sharedModel] creatTable:tempTableName PrimaryKey:@"id" TextColumn:@[@"name",@"age"] IntegerColumn:@[@"agement"]];
    //获取表列名
    NSArray *columnArray = [[KTSQLite sharedModel] getColumnName:tempTableName];
    NSLog(@"columnArrayName : %@",columnArray) ;
    
    //插入数据
    NSDictionary *dic = @{columnArray[1] : @"kid",
                          columnArray[2] : @"kt",
                          columnArray[3] : @"123"};
    
    [[KTSQLite sharedModel] insertDataInTable:tempTableName DataDictionary:dic];
    
    //获取数据总量
    NSLog(@"Tablecount : %ld",(long)[[KTSQLite sharedModel] getItemCountOfTable:tempTableName]);
    //获取全部ID
    NSArray *allitem = [[KTSQLite sharedModel] getAllItemIDInTable:tempTableName];
    NSLog(@"%@",allitem);
    
    //全表模糊查询
    NSArray *searchResult = [[KTSQLite sharedModel] searchTable:tempTableName SearchString:@"k"];
    NSLog(@"searchResultInAllTable %@",searchResult);
    //指定字段查询
    NSArray *resluts = [[KTSQLite sharedModel] searchTable:tempTableName ColumnName:@"name" SearchString:@"KID"];
    NSLog(@"%@",resluts);
    
    //删除指定数据
    //[[KTSQLite sharedModel] deleteDataINTable:tempTableName WithID:1];
    //清空全部数据
    //[[KTSQLite sharedModel] emptyTable:tempTableName];
    
    //由ID找到唯一数据
     NSDictionary *dict = [[KTSQLite sharedModel] findDataInTable:tempTableName WithID:1];
     NSLog(@"find Data Reault%@",dict);
    
    
    //跟新数据
    NSDictionary *updateDic = @{columnArray[1] : @"kid",
                                columnArray[2] : @"kid",
                                columnArray[3] : @"kid"};
    [[KTSQLite sharedModel] updateItemInTable:tempTableName WithID:1 updateDictionary:updateDic];
    
    //关闭数据库
    [[KTSQLite sharedModel] shutDownDataBase];
}



#pragma mark - UserDefault
- (void)userDefaultStorage {
    Person *person = [[Person alloc] init];
    person.name = @"kt00";
    person.age  = @"210";
    person.isMan = YES;
    NSArray *array = @[@"123",@"444",@"7891624564"];
    NSDictionary *dic = @{@"a" : @"123",
                          @"b" : @"456",
                          @"c" : @"789"};
    
    [KTUserDefault setDictionary:dic forKey:@"dic"];
    NSLog(@"dic %@",[KTUserDefault dictionaryForKey:@"dic"]);

    
    [KTUserDefault setArray:array forKey:@"array"];
    NSLog(@"array %@",[KTUserDefault arrayForKey:@"array"]);
    
    [KTUserDefault setEncodeObject:person forKey:@"personList"];
    NSLog(@"name %@",[[KTUserDefault decodeObjectForKey:@"personList"] valueForKey:@"name"]);
    
    [KTUserDefault setString:person.age forKey:@"age"];
    NSLog(@"age %@",[KTUserDefault stringForKey:@"age"]);
}


#pragma mark - Plist
- (void)plistStorage {
    NSDictionary *infoPlist = [KTPlist mainPlist];
    NSLog(@"info.plist.appname : %@",[infoPlist valueForKey:@"CFBundleName"]);
    
    [KTPlist storeUserDefinedPlistFile:@{@"test":@"115032067417"}];
    NSLog(@"UserStoredPlistFile: %@",[KTPlist readUserStoredPlistFile]);
}

@end
