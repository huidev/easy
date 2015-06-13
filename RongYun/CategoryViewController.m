//
//  CategoryViewController.m
//  RongYun
//
//  Created by 乐米科技 on 6/2/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super allocData];
    NSDictionary *dTmp=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"categoryListData" ofType:@"plist"]];
    NSArray *arr =[dTmp valueForKey:@"Objects"];
    [self.dataArray addObjectsFromArray:arr];
    [self setLeftBarButtonItemWithText:@"选择分类" imageName:IMAGENAME_BACK respond:nil];
    // Do any additional setup after loading the view.
}
- (void)barButtonItemAction:(UIBarButtonItem *)barItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text=[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    int level =[[[self.dataArray objectAtIndex:indexPath.row] valueForKey:@"level"] intValue];
    if(level==0)
    {
        cell.imageView.image = [UIImage imageNamed:@"group_type"];
    }else
    {
        cell.imageView.image = [UIImage imageNamed:@""];
    }
    [cell setIndentationLevel:level];
    [cell setIndentationWidth:20];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *d=[self.dataArray objectAtIndex:indexPath.row];
    if([d valueForKey:@"Objects"]) {
        NSArray *ar=[d valueForKey:@"Objects"];
        
        BOOL isAlreadyInserted=NO;
        
        for(NSDictionary *dInner in ar ){
            NSInteger index=[self.dataArray indexOfObjectIdenticalTo:dInner];
            isAlreadyInserted=(index>0 && index!=NSIntegerMax);
            if(isAlreadyInserted) break;
        }
        
        if(isAlreadyInserted) {
            [self miniMizeThisRows:ar];
        } else {
            NSUInteger count=indexPath.row+1;
            NSMutableArray *arCells=[NSMutableArray array];
            for(NSDictionary *dInner in ar ) {
                [arCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [self.dataArray insertObject:dInner atIndex:count++];
            }
            [tableView insertRowsAtIndexPaths:arCells withRowAnimation:UITableViewRowAnimationLeft];
        }
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
        self.selectBlock(d);
    }
}

-(void)miniMizeThisRows:(NSArray*)ar{
    
    for(NSDictionary *dInner in ar ) {
        NSUInteger indexToRemove=[self.dataArray indexOfObjectIdenticalTo:dInner];
        NSArray *arInner=[dInner valueForKey:@"Objects"];
        if(arInner && [arInner count]>0){
            [self miniMizeThisRows:arInner];
        }
        
        if([self.dataArray indexOfObjectIdenticalTo:dInner]!=NSNotFound) {
            [self.dataArray removeObjectIdenticalTo:dInner];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:
                                                    [NSIndexPath indexPathForRow:indexToRemove inSection:0]
                                                    ]
                                  withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
