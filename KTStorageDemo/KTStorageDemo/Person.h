//
//  Person.h
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL     isMan;

@end
