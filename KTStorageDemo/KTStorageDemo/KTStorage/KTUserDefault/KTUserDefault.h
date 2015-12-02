//
//  KTUserDefault.h
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTUserDefault : NSObject
#pragma mark - common methods
+ (void)setObject:(id)object forKey:(NSString *)key ;
+ (id)objectForKey:(NSString *)key ;

#pragma mark - NSKeyedArchiver
+ (void)setEncodeObject:(id)object forKey:(NSString *)key ;
+ (id)decodeObjectForKey:(NSString *)key ;

#pragma mark - remove
+ (void)removeObjectForKey:(NSString *)key;

#pragma mark - BOOL Value
+ (void)setBool:(BOOL)boolValue forKey:(NSString *)key ;
+ (BOOL)boolForKey:(NSString *)key ;

#pragma mark - NSInteger Value
+ (void)setInteger:(NSInteger)integer forKey:(NSString *)key ;
+ (NSInteger)integerForKey:(NSString *)key ;

#pragma mark - NSString Value
+ (void)setString:(NSString *)str forKey:(NSString *)key ;
+ (NSString *)stringForKey:(NSString *)key ;

#pragma mark - NSArray Value
+ (void)setArray:(NSArray *)array forKey:(NSString *)key ;
+ (NSArray *)arrayForKey:(NSString *)key ;

#pragma mark - NSDictionary Value
+ (void)setDictionary:(NSDictionary *)dic forKey:(NSString *)key;
+ (NSDictionary *)dictionaryForKey:(NSString *)key ;


@end