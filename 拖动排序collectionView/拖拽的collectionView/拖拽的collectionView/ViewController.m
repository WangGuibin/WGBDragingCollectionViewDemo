//
//  ViewController.m
//  拖拽的collectionView
//
//  Created by Wangguibin on 2016/10/19.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "ViewController.h"
#import "LXReorderableCollectionViewFlowLayout.h"

@interface ViewController ()<LXReorderableCollectionViewDataSource,LXReorderableCollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (UICollectionView *)collectionView
{
	if (_collectionView==nil) {
		LXReorderableCollectionViewFlowLayout *layout =[[LXReorderableCollectionViewFlowLayout alloc]init];
		_collectionView =[[UICollectionView  alloc]initWithFrame: self.view.bounds collectionViewLayout:layout];
		_collectionView.dataSource = self;
		_collectionView.delegate = self;
		[self.view addSubview: _collectionView];
	}
	return _collectionView;
}


- (void)viewDidLoad {
	[super viewDidLoad];

	[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

	UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
	cell.backgroundColor =[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f  blue:arc4random()%256/255.0f alpha:1.0f];
	
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

	return CGSizeMake(100, 100);
}


#pragma mark LXReorderableCollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath{
//分三步走:
/**
	1.	获取到当前模型的内容存起来
	2.	将fromIndexPath的模型item移除
	3. 然后将存起来的那份模型插入到toIndexPath的位置
 */
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath{
		//已经移动过去之后 回调的方法

}

	//判断哪一个下标可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
//	if (indexPath.row == 0) {return NO;}
	return YES;
}
	//判断哪一个下标可以移动到哪一个下标
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
//	if (fromIndexPath.row == 0 || toIndexPath.row == 0) {return NO;}
	return YES;
}



@end
