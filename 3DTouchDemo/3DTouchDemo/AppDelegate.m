//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by qianwei on 2017/6/6.
//  Copyright © 2017年 qianwei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//Home Screen Quick Actions（主屏幕快捷操作)
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController * vc = [[ViewController alloc]init];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    CGFloat currentDeviceVersionFloat = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (currentDeviceVersionFloat >= 9.0) {
        //添加 自定义的ShortcutItem
        [self addShortcutItems:application];
    }
    
    
    return YES;
}
-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"shortcutItemNotify" object:shortcutItem.type];
}

-(void)addShortcutItems:(UIApplication *)application{
    if (application.shortcutItems.count == 0) {//备注：如果加上此判断，3dtouch只会走一次，如果内容有变更，必须卸载再安装才可以
        
        UIApplicationShortcutItem * itemOne = [[UIApplicationShortcutItem alloc]initWithType:@"one" localizedTitle:@"主功能2"];
        
        //这里给定的图片，系统会再处理成 自己需要的图片
        UIApplicationShortcutIcon * icon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"personal"];
        UIMutableApplicationShortcutItem * itemtwo = [[UIMutableApplicationShortcutItem alloc]initWithType:@"two" localizedTitle:@"主功能1" localizedSubtitle:@"副标题" icon:icon userInfo:nil];
        
        UIApplicationShortcutIcon * systemIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
        UIMutableApplicationShortcutItem * itemThree = [[UIMutableApplicationShortcutItem alloc]initWithType:@"three" localizedTitle:@"分享" localizedSubtitle:nil icon:systemIcon userInfo:nil];
        
        application.shortcutItems = @[itemtwo,itemOne,itemThree];
    }
}

@end
