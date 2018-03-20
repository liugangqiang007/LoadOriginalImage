//
//  ViewController.m
//  根据网络加载高清非高清图片
//
//  Created by LGQ on 16/5/3.
//  Copyright © 2016年 LGQ. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+GGSetImage.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ViewController

NSString * const cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    [manger startMonitoring];
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:AFNetworkingReachabilityDidChangeNotification object:nil];
}

- (void)reloadDataaaa {
    NSLog(@"-----");

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.imageView gg_setImageWithOriginalUrl:[NSURL URLWithString:@"http://tse1.mm.bing.net/th?id=OIP.M395d14934cf6f3c9043483c7d6b0097co1&pid=15.1"]
                                  thumbnailUrl:[NSURL URLWithString:@"http://www.ledao.so/pics/2012/08/06/2012861833332439l.jpg"]
                                   placeholder:[UIImage imageNamed:@"btn_start"]
                                     completed:^(UIImage *image, GGImageDownloadType type, NSError *error) {

    }];
    
    return cell;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 100;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self.tableView];
}

@end
