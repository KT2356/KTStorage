//
//  Person.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeBool:self.isMan forKey:@"isMan"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.age = [aDecoder decodeObjectForKey:@"age"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.isMan = [aDecoder decodeBoolForKey:@"isMan"];
    return self;
}



@end
