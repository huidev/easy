//
//  UpLoadPortrait.m
//  RongYun
//
//  Created by apple on 15/6/5.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "UpLoadPortrait.h"

@interface UpLoadPortrait ()

@end

@implementation UpLoadPortrait

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _upLoadImageArr = [[NSMutableArray alloc] init];
    
    self.errorView.hidden = YES;
    self.view.backgroundColor = BGColor;

    _imageV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
    [_imageV addGestureRecognizer:tap];

}

- (void)clicked{
    UIActionSheet *photoSheet = [[UIActionSheet alloc]initWithTitle:@"选择图片源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"从相册中选取", nil];
    [photoSheet showInView:self.view];
}

#pragma marks -- UIActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;
{

    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;//设置可编辑
            picker.sourceType = sourceType;
            //进入照相界面
            [self presentViewController:picker animated:YES completion:^{
                
            }];
        }
            break;
        case 2:
        {
            
        }
            break;
        case 1:
        {
           DoImagePickerController1 *cont = [[DoImagePickerController1 alloc] initWithNibName:@"DoImagePickerController1" bundle:nil];
            cont.nResultType = DO_PICKER_RESULT_UIIMAGE;
            cont.delegate = self;
            cont.type = 1;
            cont.nMaxCount = 1;
            cont.nColumnCount = 3;
            [self.navigationController pushViewController:cont animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - DoImagePickerControllerDelegate1
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController1 *)picker result:(NSArray *)aSelected andDic:(NSDictionary *)dic{
    
    //    [_selectedImageDic setValuesForKeysWithDictionary:dic];
    
    if (aSelected.count == 1) {
        _coverImage = aSelected[0];
    }


    NSLog(@"%@",_coverImage);
    return;
}
#pragma mark -UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSDictionary *cameraDic = @{@"camera":image};
    [self.cameraArr addObject:cameraDic];
    [_upLoadImageArr addObject:cameraDic];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
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
