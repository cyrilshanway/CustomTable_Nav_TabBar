//
//  ViewController.m
//  CustomTable
//
//  Created by Cyrilshanway on 2014/12/24.
//  Copyright (c) 2014年 Cyrilshanway. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustomTableCell.h"
#import "DetailViewController.h"

@interface CustomTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CustomTableViewController
{
    NSArray *allNames;
    NSArray *allImages;
    BOOL checkMark[16];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //table datasource
    allNames  = [NSArray arrayWithObjects: @"Apple", @"Android", @"Twitter", @"GitHub", @"Snapchat",@"Windows", @"Email", @"Facebook", @"iTunes", @"YouTube", @"Video", @"Dropbox", @"instagram", @"PayPal", @"Amazon",@"Share", nil];
    allImages = [NSArray arrayWithObjects: @"pic2", @"pic3", @"pic4", @"pic5", @"pic6", @"pic7", @"pic8", @"pic9", @"pic10", @"pic11", @"pic12", @"pic13", @"pic14", @"pic15", @"pic16", @"pic17", nil];
    
    //ios7之後會蓋到狀態欄，增加以下code(上左下右)
    [self.tableView setContentInset:UIEdgeInsetsMake(20,
                                                     self.tableView.contentInset.left,
                                                     self.tableView.contentInset.bottom,
                                                     self.tableView.contentInset.right)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"CustomTableCell";
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
    
//    cell.textLabel.text = [allNames objectAtIndex:indexPath.row];
//    //cell.imageView.image = [UIImage imageNamed:@"angel_64.png"];
//    cell.imageView.image = [UIImage imageNamed:[allImages objectAtIndex:indexPath.row]];
    
    CustomTableCell *cell = (CustomTableCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    //設定cell
    if (cell == nil) {
        cell = [[CustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    //在表格cell中顯示食譜
    cell.nameLabel.text = [allNames objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = [UIImage imageNamed:[allImages objectAtIndex:indexPath.row]];
    cell.thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    if (checkMark[indexPath.row]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    checkMark[indexPath.row] = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *destVC = segue.destinationViewController;
        destVC.nameString = [allNames objectAtIndex:indexPath.row];
    }
}
@end
