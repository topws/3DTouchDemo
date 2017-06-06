//
//  DetailViewController.m
//  3DTouchDemo
//
//  Created by qianwei on 2017/6/6.
//  Copyright © 2017年 qianwei. All rights reserved.
//

#import "DetailViewController.h"
#import <SafariServices/SafariServices.h>
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //按照url初始化safari控制器并调整
    
}
//Web view peek and pop API (HTML链接预览功能)
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    SFSafariViewController *sf = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.navigationController pushViewController:sf animated:YES];
}
//Force Properties
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        UITouch * touch = touches.anyObject;
        NSLog(@"force:%f,maximumPossibleForce:%ff",touch.force,touch.maximumPossibleForce);
        self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:touch.force/touch.maximumPossibleForce alpha:1.0];
        
    }
}
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    UIPreviewAction * action = [UIPreviewAction actionWithTitle:@"action1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"PreViewAction1");
        
        
    }];
    return @[action];
}

@end
