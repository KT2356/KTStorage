//
//  KTUserDefault.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTUserDefault.h"

@implementation KTUserDefault
#pragma mark - private method
+ (NSUserDefaults *)standardUserDefaults {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - common methods
+ (void)setObject:(id)object forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setObject:object forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (id)objectForKey:(NSString *)key {
    id data = [[KTUserDefault standardUserDefaults] objectForKey:key];
    return data ? data : nil ;
}

#pragma mark - NSKeyedArchiver
+ (void)setEncodeObject:(id)object forKey:(NSString *)key {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[KTUserDefault standardUserDefaults] setObject:data forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (id)decodeObjectForKey:(NSString *)key {
    id data = [[KTUserDefault standardUserDefaults] objectForKey:key];
    data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return data ? data : nil ;
}

#pragma mark - remove
+ (void)removeObjectForKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] removeObjectForKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

#pragma mark - BOOL Value
+ (void)setBool:(BOOL)boolValue forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setBool:boolValue forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (BOOL)boolForKey:(NSString *)key {
    BOOL boolValue = [[KTUserDefault standardUserDefaults] boolForKey:key];
    return boolValue ? boolValue : NO;
}

#pragma mark - NSInteger Value
+ (void)setInteger:(NSInteger)integer forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setInteger:integer forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (NSInteger)integerForKey:(NSString *)key {
    NSInteger integer = [[KTUserDefault standardUserDefaults] integerForKey:key];
    return integer ? integer : 0;
}

#pragma mark - NSString Value
+ (void)setString:(NSString *)str forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setValue:str forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (NSString *)stringForKey:(NSString *)key {
    NSString *str = [[KTUserDefault standardUserDefaults] stringForKey:key];
    return str ? str : nil;
}

#pragma mark - NSArray Value
+ (void)setArray:(NSArray *)array forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setValue:array forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (NSArray *)arrayForKey:(NSString *)key {
    NSArray *array = [[KTUserDefault standardUserDefaults] arrayForKey:key];
    return array ? array : nil;
}

#pragma mark - NSDictionary Value
+ (void)setDictionary:(NSDictionary *)dic forKey:(NSString *)key {
    [[KTUserDefault standardUserDefaults] setValue:dic forKey:key];
    [[KTUserDefault standardUserDefaults] synchronize];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)key {
    NSDictionary *dic = [[KTUserDefault standardUserDefaults] dictionaryForKey:key];
    return dic ? dic : nil;
}

@end
