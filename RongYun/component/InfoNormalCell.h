//
//  InfoNormalCell.h
//  RongYun
//
//  Created by 乐米科技 on 5/14/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoNormalCell : UITableViewCell

@property (weak, nonatomic)IBOutlet UILabel *titleLB;
@property (weak, nonatomic)IBOutlet UILabel *subtitleLB;
@property (weak, nonatomic)IBOutlet UIButton *contentBT;

- (void)configCellWithData:(NSDictionary *)dic;
@end
