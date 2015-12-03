//
//  ViewController.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//
#define tempTableName @"mytable"

#import "ViewController.h"
#import "KTStorage.h"

#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self plistStorage];
    //[self userDefaultStorage];
    
    [self SQLite];
}

#pragma mark - SQLite
- (void)SQLite {
    [[KTSQLite sharedModel] openDataBase];
    [[KTSQLite sharedModel] creatTable:tempTableName PrimaryKey:@"id" TextColumn:@[@"name",@"age"] IntegerColumn:@[@"agement"]];
    
    NSArray *columnArray = [[KTSQLite sharedModel] getColumnName:tempTableName];
    NSDictionary *dic = @{columnArray[1] : @"00",
                          columnArray[2] : @"z",
                          columnArray[3] : @"1"};
    
   // [[KTSQLite sharedModel] insertDataInTable:tempTableName DataDictionary:dic];
    //NSLog(@"count : %ld",(long)[[KTSQLite sharedModel] getItemCountOfTable:tempTableName]);
    //NSLog(@"itemName : %@",columnArray) ;
    
    //NSArray *searchResult = [[KTSQLite sharedModel] searchTable:tempTableName SearchString:@"kt"];
   // NSLog(@"searchResult %@",searchResult);
    
    //[[KTSQLite sharedModel] deleteDataINTable:tempTableName WithID:8];
//   NSDictionary *dict = [[KTSQLite sharedModel] findDataInTable:tempTableName WithID:36];
//    NSLog(@"%@",dict);
    
//    NSArray *allitem = [[KTSQLite sharedModel] getAllItemIDInTable:tempTableName];
//    NSLog(@"%@",allitem);
    NSDictionary *updateDic = @{columnArray[1] : @"kid",
                                columnArray[2] : @"kid",
                                columnArray[3] : @"kid"};
//    [[KTSQLite sharedModel] updateItemInTable:tempTableName WithID:3 updateDictionary:updateDic];
    NSArray *resluts = [[KTSQLite sharedModel] searchTable:tempTableName ColumnName:@"name" SearchString:@"KID"];
    NSLog(@"%@",resluts);
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
