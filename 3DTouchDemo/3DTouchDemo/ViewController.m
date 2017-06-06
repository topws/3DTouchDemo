//
//  ViewController.m
//  3DTouchDemo
//
//  Created by qianwei on 2017/6/6.
//  Copyright © 2017年 qianwei. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <Social/Social.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic,strong)UITableView * tab;

@property (nonatomic,strong)NSArray * dataArr;
@end

@implementation ViewController
-(UITableView *)tab{
    if (_tab == nil) {
        _tab = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tab.delegate = self;
        _tab.dataSource = self;
        
        [_tab registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tab;
}
-(NSArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = @[@"one",@"two",@"three"];
    }
    return _dataArr;
}
/*
 Peek／Pop（预览和弹出，包括WebView）
 1、遵守协议 UIViewControllerPreviewingDelegate
 2、注册    [self registerForPreviewingWithDelegate:self sourceView:self.view];
 3、实现代理方法
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3DTouch";
    [self.view addSubview:self.tab];
    //Appicon快捷操作
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveShortcutItem:) name:@"shortcutItemNotify" object:nil];
    //注册
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tab];
    }
    else {
        NSLog(@"该设备不支持3DTouch");
    }
}
//UIViewControllerPreviewingDelegate
-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    //location 按压的区域
    NSIndexPath * indexP = [self.tab indexPathForRowAtPoint:location];
    UITableViewCell * cell = [self.tab cellForRowAtIndexPath:indexP];
    if (cell == nil) {
        return nil;
    }
    //按压的是 tableView
    DetailViewController *childVC = [[DetailViewController alloc] init];
    childVC.view.backgroundColor = [UIColor lightGrayColor];
    
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 40, 44)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"标题";
    lable.backgroundColor = [UIColor whiteColor];
    [childVC.view addSubview:lable];

    childVC.preferredContentSize = CGSizeMake(0, 0);
    previewingContext.sourceRect = cell.frame;
    return childVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.navigationController pushViewController:viewControllerToCommit animated:NO];
}
//AppIcon快捷操作
-(void)receiveShortcutItem:(NSNotification *)object{
    NSString * type = [NSString stringWithFormat:@"%@",object.object];
    if ([type isEqualToString:@"three"]) {
        // 2.创建分享的控制器
        SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:@"com.tencent.xin.sharetimeline"];
        
        // 2.1.添加分享的文字
        [composeVc setInitialText:@"balabalabala..."];
        
        // 2.2.添加一个图片
        [composeVc addImage:[UIImage imageNamed:@"gray_advices"]];
        
        // 2.3.添加一个链接
        [composeVc addURL:[NSURL URLWithString:@"www.baidu.com"]];
        
        // 3.弹出分享控制器（以Modal形式弹出）
        [self presentViewController:composeVc animated:YES completion:nil];
        
        
        // 4.监听用户点击了取消还是发送
        /*
         SLComposeViewControllerResultCancelled,
         SLComposeViewControllerResultDone
         */
        composeVc.completionHandler = ^(SLComposeViewControllerResult result){
            if (result == SLComposeViewControllerResultCancelled) {
                NSLog(@"点击了取消");
            } else {  
                NSLog(@"点击了发送");  
            }  
        };
        return;
    }
    DetailViewController * vc = [[DetailViewController alloc]init];
    vc.title = type;
    [self.navigationController pushViewController:vc animated:YES];
}
//TableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DetailViewController * vc = [[DetailViewController alloc]init];
    vc.title = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
