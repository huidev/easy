//
//  ConditionAddVC.m
//  RongYun
//
//  Created by 乐米科技 on 5/29/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ConditionAddVC.h"
#import "Constants.h"
#import "HZAreaPickerView.h"
#import "CategoryViewController.h"
@interface ConditionAddVC ()<UITextFieldDelegate,HZAreaPickerDelegate>
@property (strong, nonatomic) NSString *areaValue, *cityValue;
@property (strong, nonatomic) HZAreaPickerView *locatePicker;
@end

@implementation ConditionAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.layer.cornerRadius =6;
    self.nameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.nameField.layer.masksToBounds = YES;
    
    self.searchBT.layer.cornerRadius = 3;
    [self setLeftBarButtonItemWithText:@"按条件查询" imageName:IMAGENAME_BACK respond:nil];
    // Do any additional setup after loading the view.
}

- (void)barButtonItemAction:(UIButton *)sener
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - HZAreaPicker delegate
-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    if (picker.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        self.areaValue = [NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district];
    } else{
        self.cityValue = [NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    }
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}


#pragma mark - TextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:self.nameField]) {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCityAndDistrict delegate:self];
        [self.locatePicker showInView:self.m_tableView];
    } else {
        [self cancelLocatePicker];
        self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
        [self.locatePicker showInView:self.m_tableView];
    }
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self cancelLocatePicker];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"segueCategory"])
    {
        CategoryViewController *desVC = segue.destinationViewController;
        desVC.selectBlock = ^(NSDictionary *dic){
            self.categroyLB.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        };
    }
}


@end
