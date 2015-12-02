//
//  ViewController.m
//  KTStorageDemo
//
//  Created by KT on 15/12/2.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTStorage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self plistStorage];
    
}

//Plist
- (void)plistStorage {
    NSDictionary *infoPlist = [KTPlist mainPlist];
    NSLog(@"info.plist.appname : %@",[infoPlist valueForKey:@"CFBundleName"]);
    
    //store
    [KTPlist storeUserDefinedPlistFile:@{@"test":@"115032067417"}];

    //read
    NSLog(@"UserStoredPlistFile: %@",[KTPlist readUserStoredPlistFile]);
}

@end
