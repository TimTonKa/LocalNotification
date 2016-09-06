//
//  ViewController.m
//  LocalNotification
//
//  Created by Tim on 2016/8/26.
//  Copyright © 2016年 Tim. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString * time = @"21:00";
    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
