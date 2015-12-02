//
//  KTPlist.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTPlist.h"

@implementation KTPlist

#pragma mark - public methods
+ (NSMutableDictionary *)mainPlist {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return dict;
}

+ (NSMutableDictionary *)getPlistDictionary:(NSString *)plistName {
    NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    return dict;
}

+ (void)storeUserDefinedPlistFile:(NSDictionary *)dataDictionary {
    [dataDictionary writeToFile:[KTPlist getDomainFilePath] atomically:YES];
}


+ (NSDictionary *)readUserStoredPlistFile {
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:[KTPlist getDomainFilePath]];
    return dict;
}


#pragma mark - private methods
+ (NSString *)getDomainFilePath {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = path[0];
    
    NSDictionary *infoPlist = [KTPlist mainPlist];
    NSString *appName       = [infoPlist valueForKey:@"CFBundleName"];
    
    filePath = [filePath stringByAppendingString:[NSString stringWithFormat:@"%@%@",appName,@"KTPlist.plist"]];
    return filePath;
}

@end
