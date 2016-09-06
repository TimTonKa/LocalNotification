//
//  AppDelegate.m
//  LocalNotification
//
//  Created by Tim on 2016/8/26.
//  Copyright © 2016年 Tim. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //跟user要求權限，包含圖像標記，提示視窗和聲音
    UIUserNotificationSettings * notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    [self generateLocalNotification];
    
    return YES;
}

-(void)generateLocalNotification{
    
    NSString * time = [[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
    if (time == nil) {
        return;
    }
    NSInteger hour = [time substringToIndex:2].integerValue;
    
    //初始化日曆
    NSCalendar *cal = [NSCalendar currentCalendar];
    //設定日期內容
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [components setHour:hour];
    [components setMinute:49];
    NSDate *alertTime3 = [cal dateFromComponents:components];
    
    UILocalNotification * localNotification = [[UILocalNotification alloc]init];
    //localNotification.fireDate = [[NSDate alloc]initWithTimeIntervalSinceNow:10];
    //localNotification.repeatInterval = kCFCalendarUnitDay;
    
    localNotification.fireDate = alertTime3;
    
    localNotification.alertBody = @"Tim 是大帥哥";
    localNotification.applicationIconBadgeNumber = 1;
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.userInfo = @{@"id":@42};
  
    NSLog(@"Components: %@",components);
   
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    

}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if (application.applicationState == UIApplicationStateActive) {
        //inside app,在app裡面的推播
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Notification" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        UIAlertAction * viewAction = [UIAlertAction actionWithTitle:@"View" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takeActionWithLocalNotification:notification];
        }];
        
        [alertController addAction:ignoreAction];
        [alertController addAction:viewAction];
        
        [self.window.rootViewController presentViewController:alertController animated:true completion:^{
            
        }];
        
    } else {
        //outside app
        [self takeActionWithLocalNotification:notification];
    }
}

//user 按下本地推播通知之後，跳回app頁面並show出alert
//程式剛啟動時，user按下允許同意也會跳出此alert action
-(void)takeActionWithLocalNotification:(UILocalNotification*)localNotification{
    
    NSNumber * notification_id = localNotification.userInfo[@"id"];
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Action Taken" message:[NSString stringWithFormat:@"We are viewing notification %@",notification_id] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"OK");
    }];
    [alertController addAction:ok];
    [self.window.rootViewController presentViewController:alertController animated:true completion:^{
        
    }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

   
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
