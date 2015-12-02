//
//  KTPlist.h
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTPlist : NSObject
//获取 Info.plist
+ (NSMutableDictionary *)mainPlist;
//获取 ***.plist
+ (NSMutableDictionary *)getPlistDictionary:(NSString *)plistName;

//将字典数据存储与沙盒plist
+ (void)storeUserDefinedPlistFile:(NSDictionary *)dataDictionary;
//从沙盒中读取默认plist
+ (NSDictionary *)readUserStoredPlistFile;

@end
