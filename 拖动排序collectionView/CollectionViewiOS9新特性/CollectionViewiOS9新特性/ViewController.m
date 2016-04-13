//
//  ViewController.m
//  CollectionViewiOS9新特性
//
//  Created by Wangguibin on 16/3/28.
//  Copyright © 2016年 DDYS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(50, 50);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.backgroundColor = [UIColor cyanColor];
        _collectionView.dataSource = self;
        _collectionView.delegate=self;
        //此处给其增加长按手势，用此手势触发cell移动效果
        UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [_collectionView addGestureRecognizer:longGesture];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

/**  感觉系统的要比 第三方排的要快.. 但是只支持iOS 9.0  ||-_-  
        缺点还是不能支持组与组的交换位置(插入排序)...
 思路: 如果有 A,B,C 共3个组  每个组20个   从B组中拿一个到A组  , 那A组就多一个
 这时要处理 多出的那一个cell  内容交换  下标不变... ( 不交换就越界了 A组cell 个数 + 1)
 */

- (void)viewDidLoad {
    [super viewDidLoad];

    [self collectionView];
    _dataSource=[NSMutableArray array];
    for (int i = 1; i <= 20; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d",i];
        [_dataSource addObject:imageName];
    }


}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{
            //判断手势落点位置是否在路径上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGesture locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
            //在路径上则开始移动该路径上的cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //移动过程当中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.collectionView]];
            break;
        case UIGestureRecognizerStateEnded:
            //移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    //返回YES允许其item移动
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    //取出源item数据
    id objc = [_dataSource objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [_dataSource removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [_dataSource insertObject:objc atIndex:destinationIndexPath.item];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width , cell.frame.size.height)];

    label.text=self.dataSource[indexPath.row];
    label.backgroundColor=[UIColor redColor];
    label.textAlignment=NSTextAlignmentCenter;

    [cell.contentView addSubview:label];

    return cell;

}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return CGSizeMake(100, 100);
//}




@end
