//
//  DMTableViewController.m
//  DMRuntime
//
//  Created by lbq on 2018/3/30.
//  Copyright © 2018年 lbq. All rights reserved.
//

#import "DMTableViewController.h"
#import "ViewController.h"
@interface DMTableViewController ()

@property (nonatomic, strong) NSArray<NSDictionary *> *list;

@end

@implementation DMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray <NSDictionary *>*)list
{
    return @[
             @{
                 @"title":@"基本方法调用",
                 @"data":@[@"ivarlist",
                 @"propertylist",
                 @"propertyAttributes",
                 @"methodlist",
                 @"classMethodlist",
                 @"获取所有类方法(包括父类的)"]
                 },
             @{
                 @"title":@"关联对象",
                 @"data":@[@"关联对象"]
                 }
             ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.list[section];
    NSArray *arr = dic[@"data"];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dic = self.list[indexPath.section];
    NSArray *arr = dic[@"data"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = self.list[section];
    NSString *title = dic[@"title"];
    return title;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    if([segue.identifier isEqualToString:@"ShowVC"]){
        ViewController *desVC = (ViewController *)segue.destinationViewController;
        desVC.list = self.list;
        desVC.indexPath = [self.tableView indexPathForCell:sender];
    }
}

@end
