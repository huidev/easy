//
//  ImageListVC.m
//  RongYun
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 zwh. All rights reserved.
//

#import "PhotoListVC.h"
#import "ImageCollectionViewCell.h"
#import "PhotoModel.h"
//#import "TGRImageViewController.h"
#import "UIImageView+WebCache.h"
#import "YYResPhotoView.h"
#import "PhotoDetailVC.h"
#import "PopoverView.h"
#import "EditAlbumVC.h"
@interface PhotoListVC (){

    NSMutableArray *dataArr;
    NSIndexPath *filterIndex;

}

@end

@implementation PhotoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dataArr = [[NSMutableArray alloc] init];
    [self setRightBarButtonItemWithText:nil imageName:@"service_cd"];
    /*
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
     //2>设置item大小
     [layout setItemSize:CGSizeMake(50, 60)];
     //3>设置排列方式 - 横向
     //layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     //纵向
     layout.scrollDirection = UICollectionViewScrollDirectionVertical;
     _collectionView.collectionViewLayout = layout;
     */


    //关联内部cell
//    [self.collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];

    //[_collectionView.registerNib(UINib(_nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell") ]

    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"imageCell"];

    _collectionView.scrollEnabled = YES;
    _collectionView.backgroundColor = BGColor;
    [self.collectionView reloadData];
    
    [self loadMyData];
}

-(void)barButtonItemAction:(UIBarButtonItem *)barItem{

    //    _selectView.hidden = NO;
    //[_myTableView setContentOffset:CGPointMake(0, 0)];
  
//    CGPoint point = CGPointMake(barItem.frame.origin.x + barItem.frame.size.width/2, barItem.frame.origin.y + barItem.frame.size.height-2);
    //            [self.view convertPoint:point fromView:self.pullTableView];
    CGPoint point = CGPointMake(MY_WIDTH-40, 64);
//    __block PopoverView *popView = [[PopoverView alloc]initWithPoint:[self.view convertPoint:point fromView:self.view] titles:@[@"编辑相册",@"上传相片",@"相片管理"] images:nil type:POPOVER_NORMAL];
//    popView.selectRowAtIndex = ^(NSIndexPath *index)
//    {
//        filterIndex = index;
//        popView.selectIndex = filterIndex;
//        [self doSth:index.row];
//    };
//    popView.selectIndex = filterIndex;
//    [popView show];//    _selectView.hidden = NO;

}

- (void)doSth:(NSInteger)num{

    switch (num) {
        case 0:{
            //编辑相册
            EditAlbumVC *edit = [[EditAlbumVC alloc] init];
            [self.navigationController pushViewController:edit animated:YES];
            break;
        }
        case 1:{
            //上传相片
            break;
        }
        case 2:{
            //相片管理
            break;
        }
        default:
            break;
    }

}

- (void)loadMyData{

    NSDictionary *dic = @{@"otype":@"plist",@"u_id":_photoModel.a_user_id,@"a_id":_photoModel.a_id,@"index":@"1"};
        
    [self requestGetWithRelativeUrl:URL_PHOTO_LIST parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in responseObject) {
                PhotoModel *model = [[PhotoModel alloc] initWithDict:dic];
                [dataArr addObject:model];
            }
            [_collectionView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //  NSLog(@"%@",error);
    }];

    
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArr.count;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"imageCell";
    ImageCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    PhotoModel *model = dataArr[indexPath.row];
    cell.model = model;
    return cell;
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((MY_WIDTH-30)/2, 200);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    float temp = 0;
    if (section == 0 || section == 1) {
        temp = 5;
    }
    return UIEdgeInsetsMake(5+temp, 10, 5, 10);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableArray *imageArr = [[NSMutableArray alloc] init];
    NSMutableArray *urlArr = [[NSMutableArray alloc] init];
    NSInteger indexNum;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    NSDictionary *dic;
    for (PhotoModel *model in dataArr) {
        [imageV sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:model.p_src] andPlaceholderImage:nil options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        [imageArr addObject:imageV.image];
        dic = @{@"url":model.p_src,@"width":[NSString stringWithFormat:@"%f",imageV.image.size.width],@"height":[NSString stringWithFormat:@"%f",imageV.image.size.height]};
        [urlArr addObject:dic];
        
    }
    indexNum = indexPath.row;
    
    PhotoDetailVC *photo = [[PhotoDetailVC alloc] init];
    photo.photoArr = dataArr;
    photo.imageS = imageArr;
    photo.urlArray = urlArr;
    photo.indexNum = indexNum;
    [self.navigationController pushViewController:photo animated:YES];
    
    
//    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:imageV.image];
//    viewController.transitioningDelegate = self;
//    [self.navigationController pushViewController:viewController animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
