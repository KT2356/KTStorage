//
//  CorePerson.m
//  KTStorageDemo
//
//  Created by KT on 15/12/14.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "CorePerson.h"

@implementation CorePerson

- (NSString *)description {
    return [NSString stringWithFormat:@"<modelClass:%@  age:%@  name:%@>",[self class],self.age,self.name];
}

@end
