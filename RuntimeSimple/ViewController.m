//
//  ViewController.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/7.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "ViewController.h"

#define HeadHeight 213

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    UITableView *_mainTableView;
    
    UIImageView *_tbHeaderView;
}

@property (nonatomic,strong) NSMutableArray *dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    [self createTableView];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        _dataSourceArray = [NSMutableArray array];
        [_dataSourceArray addObjectsFromArray:@[@"获取自定义类信息",@"方法操作",@"归档解档",@"按钮点击计数"]];
    }
    return _dataSourceArray;
}

- (void)createTableView {
    _mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.contentInset = UIEdgeInsetsMake(HeadHeight, 0, 0, 0);
    [self.view addSubview:_mainTableView];
    
    _tbHeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -HeadHeight, CGRectGetWidth(_mainTableView.frame), HeadHeight)];
    _tbHeaderView.image = [UIImage imageNamed:@"red0.JPG"];
    [_mainTableView addSubview:_tbHeaderView];
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor redColor];
    [cell addSubview:line];
    if (self.dataSourceArray.count -1 == indexPath.row) {
        UIView *bLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
        line.backgroundColor = [UIColor redColor];
        [cell addSubview:bLine];
    }
    if (self.dataSourceArray.count > indexPath.row) {
        cell.textLabel.text = self.dataSourceArray[indexPath.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        GetPersonController *gpc = [[GetPersonController alloc] init];
        [self presentViewController:gpc animated:YES completion:nil];
    }else if (indexPath.row == 1) {
        MethodController *mc = [[MethodController alloc] init];
        [self presentViewController:mc animated:YES completion:nil];
    }else if (indexPath.row == 2) {
        EcoderViewController *evc = [[EcoderViewController alloc] init];
        [self presentViewController:evc animated:YES completion:nil];
    }else if (indexPath.row == 3) {
        ButtonCountViewController *bcvc = [[ButtonCountViewController alloc] init];
        [self presentViewController:bcvc animated:YES completion:nil];
    }
}



#pragma mark -- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    CGFloat w = (y/HeadHeight)*CGRectGetWidth(self.view.frame);
    if (y < -HeadHeight) {
        CGRect frame = _tbHeaderView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        frame.size.width = w;
        frame.origin.x = -(w-CGRectGetWidth(self.view.frame))/2.f;
        
        _tbHeaderView.frame = frame;
    }
}





@end
