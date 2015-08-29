//
//  MineListViewController.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "MineListViewController.h"

#import "LoginViewController.h"

#import "ActivityFavoriteViewController.h" // 导入收藏活动列表

#import "SDImageCache.h" // 导入SD 清除图片缓存头文件

#define kCleanCacheTag 101
#define kLoginOutTag 102


@interface MineListViewController () <UIAlertViewDelegate>

@end

@implementation MineListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1; // 一个分区
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3; // 行
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier] autorelease];
    }
    
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的活动";
            break;
        case 1:
            cell.textLabel.text = @"我的电影";
            break;
        case 2:
            cell.textLabel.text = @"清除缓存";
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark--- 清除缓存
- (void)cleanImageCache
{
    // 使用警告框提醒用户是否清除缓存， 给alertView 添加代理， c 遵守代理协议，实现代理方法
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:nil otherButtonTitles:@"", nil];
    // 给alertView 添加tag 值，因为本页面中还有“注销用户” 使用了提醒视图。
    alertView.tag = kCleanCacheTag;
    [alertView show];
    [alertView release]; // 不要忘记release
}

#pragma mark--- 遵守alertView 的协议。
// 实现alertView 的协议方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 点击的是确定， index 从 0 取消 开始
    if (buttonIndex == 1) {
        switch (alertView.tag) {
            case kCleanCacheTag:
            {
                // 通知者中心发出通知，清除缓存，1. 清除 model 的image 属性值， 2. 清除沙盒
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kCleanCachedNotification object:nil];
                
                // 2. 清除沙盒里的图片, sd 第三方 也清除缓存
                [[FileHandler shareInstance] cleanDownloadImages];
                
                // 调用了第三方sd中的清除图片缓存。
                [[SDImageCache sharedImageCache] clearDisk];
#pragma mark- ***我写到这里了。 准备添加显示清除了多少缓存方法。
                

            }
                break;
                
            default:
                break;
        }
    }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark- Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            // 进入收藏活动页面
            ActivityFavoriteViewController *activityFVC = [[ActivityFavoriteViewController alloc] initWithStyle:(UITableViewStylePlain)];
            [self.navigationController pushViewController:activityFVC animated:YES];
            [activityFVC release];
        }
            break;
        case 1:
            
            break;
        case 2:
            // 清除缓存
            [self cleanImageCache];
            break;
            
        default:
            break;
    }

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
