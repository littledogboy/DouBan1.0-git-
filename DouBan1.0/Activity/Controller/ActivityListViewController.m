//
//  ActivityListViewController.m
//  DouBan1.0
//
//  Created by 吴书敏 on 15/8/5.
//  Copyright (c) 2015年 吴书敏. All rights reserved.
//

#import "ActivityListViewController.h"
#import "ActivityDetailViewController.h"
#import "Activity.h"
#import "ActivityListCell.h"

@interface ActivityListViewController () <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic,retain) NSMutableData *data;
@property (nonatomic,retain) NSMutableArray *activityArray;

@end

@implementation ActivityListViewController
- (void)dealloc
{
    [_data release];
    [_activityArray release];
    [super dealloc];
}

#pragma mark------ 网络解析delegate ------

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.data = [NSMutableData data];
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"收到回应");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"拼接数据");

}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"%s %d %@", __FUNCTION__, __LINE__, @"解析数据开始");
    // 解析
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
    
    NSArray *acitvitys = [rootDic objectForKey:@"events"];
    self.activityArray = [NSMutableArray array];
    
    for (NSDictionary *dic in acitvitys) {
        Activity *activity = [[Activity alloc] init];
        [activity setValuesForKeysWithDictionary:dic];
        
        [self.activityArray addObject:activity];
        
        [activity release];
    }
    [self.tableView reloadData];


}


#pragma mark------ 本地解析方法 ------

- (void)parseWithLocalPath:(NSString *)path
{
    // 1. 取文件路径
    self.data = [NSMutableData dataWithContentsOfFile:path];
    
    self.activityArray = [NSMutableArray arrayWithCapacity:20];
    // 解析
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
    NSArray *acitvitys = [rootDic objectForKey:@"events"];
    for (NSDictionary *dic in acitvitys) {
        Activity *activity = [[Activity alloc] init];
        [activity setValuesForKeysWithDictionary:dic];
        [_activityArray addObject:activity];
        [activity release];
    }
}

#pragma mark------ 网络解析方法 block 以及为什么不用block------
- (void)parseWithUrl:(NSURL *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url cachePolicy:0 timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // 解析
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSArray *acitvitys = [rootDic objectForKey:@"events"];
        self.activityArray = [NSMutableArray array];
        
        for (NSDictionary *dic in acitvitys) {
            Activity *activity = [[Activity alloc] init];
            [activity setValuesForKeysWithDictionary:dic];
            
            [self.activityArray addObject:activity];
            
            [activity release];
        }
    }];
    
#pragma mark- 方法的执行顺序
    // .m 中的一些代理方法  优先于  其他方法执行。 执行顺序 viewDidload -》tableView代理方法 -》 uconnection代理方法。 因此要刷新表
    [self.tableView reloadData];
}

#pragma mark------ controller ------

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSURL *acitvityListURL = [NSURL URLWithString:@"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php"];

    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:acitvityListURL cachePolicy:0 timeoutInterval:10];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.activityArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"activityList";
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[ActivityListCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellIdentifier] autorelease];
    }
    
    // Configure the cell...
    // 给layer层渲染做了一个优化。
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    Activity *activity = self.activityArray[indexPath.row];
#pragma mark------ KVO 观察者设计模式------
    //1. 注册观察者 给activity 添加观察者， 指定被观察属性
    if (activity.activityImage == nil) {
        // NSKeyValueObservingOptionNew 变为新的对象
        // 此时self 为 Controller 观察者为 C
        // context 传递过去数据
        [activity addObserver:self forKeyPath:@"activityImage" options:(NSKeyValueObservingOptionNew) context:[indexPath retain]];
        // MRC 下需要retain
        // arc 下需要桥接 (__bridge_retained  void *)(indexPath)
    }
    
    cell.activity = activity;
    return cell;
}

#pragma mark- 2. 实现回调方法
// 观察属性
// object 被观察者
// change 新值
// context 上面传递过来的参数
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
#pragma mark- 3. 触发回调方法
    //1 . 获取传递过来的 indexPath 和 改变的 新值
    NSIndexPath *indexPath = (NSIndexPath *)context; // 传递过来的indexPath
    UIImage *image = (UIImage *)[change objectForKey:@"new"];
//    UIImage *newImage = change[NSKeyValueChangeNewKey]; // 或者新值。
    // 2. 获取正在显示的 context
    // 解决下载同时 滑动重用问题。 思路，获取正在显示的indexPath
    NSArray *visibleIndexes = [self.tableView indexPathsForVisibleRows];
    
    // 3. indexPath 被包含 则， 给单元格添加图片，更新单元格
    // 如果 传递过来的 正在显示,则添加图片
    if ([visibleIndexes containsObject:indexPath]) {
        
        ActivityListCell *cell = (ActivityListCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.activityImage.image = image;
        
        // 更新此index
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
    }
    // 为了 防止崩溃，上面retain 下面release。
    [indexPath release];
    
#pragma mark- 移除观察者
    [object removeObserver:self forKeyPath:@"activityImage"];
}

#pragma mark------ 当单元格被选中的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 推入活动详细页面
    ActivityDetailViewController *detailVC = [[ActivityDetailViewController alloc] init];
    // 传值
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
