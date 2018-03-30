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

@property (nonatomic, strong) NSArray<NSString *> *list;

@end

@implementation DMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSArray <NSString *>*)list
{
    return @[
             @"ivarlist",
             @"propertylist",
             @"propertyAttributes",
             @"methodlist",
             @"classMethodlist"
             ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell *)sender
{
    if([segue.identifier isEqualToString:@"ShowVC"]){
        ViewController *desVC = (ViewController *)segue.destinationViewController;
        desVC.list = self.list;
        desVC.index = [self.tableView indexPathForCell:sender].row;
    }
}

@end
