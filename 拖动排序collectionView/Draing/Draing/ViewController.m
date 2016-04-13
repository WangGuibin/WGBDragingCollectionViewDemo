//
//  ViewController.m
//  Draing
//
//  Created by Wangguibin on 16/4/13.
//  Copyright © 2016年 王贵彬. All rights reserved.
//

#import "ViewController.h"
#import "Draing-swift.h"

#ifdef DEBUG
//Debug 阶段打印
#define WGBLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#define WGBLog(...)  NSLog(__VA_ARGS__)
#else
//发布阶段 取消打印
#define WGBLog(...)
#endif

/**  打印方法名  */
#define WGBFunc  WGBLog(@"%s",__func__);


@interface ViewController ()<DrapDropCollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) DragDropCollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *magicData;
@end

@implementation ViewController

- (NSMutableArray *)magicData
{
    if (_magicData==nil) {

        _magicData =[[NSMutableArray alloc]init];

        /**  模拟20个假数据  */
        for (int i;  i < 20; i++) {
            NSString*str=[NSString stringWithFormat:@"%zd",i];
            [_magicData addObject:str];
        }


    }

    return _magicData;
}


- (DragDropCollectionView *)collectionView
{
    if (_collectionView==nil) {

        UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing=5.0f;
        layout.minimumLineSpacing=5.0f;
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;

        _collectionView =[[DragDropCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , self.view.bounds.size.height-31) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.draggingDelegate=self;

    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof(self) weak_self=self;

    [weak_self.view addSubview:weak_self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //可以被拖动!!!
    [self.collectionView enableDragging:YES];
}


#pragma mark---- <collectionViewDelegate>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

//WGBFunc
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//WGBFunc
    return self.magicData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WGBFunc
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(20,20, 60 , 80)];
    [cell.contentView addSubview:view1];
   view1.backgroundColor=[UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f  blue:arc4random()%256/255.0f  alpha:1.0f];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    WGBFunc
    return CGSizeMake(120, 120);
}

/*!
 *  @author  WGB  , 16-04-13 10:04:31
 *
 *  @brief cell拖动的代理方法
 *
 *  @param initialIndexPath 原始下标
 *  @param newIndexPath     新下标
 */
- (void)dragDropCollectionViewDidMoveCellFromInitialIndexPath:(NSIndexPath * __nonnull)initialIndexPath toNewIndexPath:(NSIndexPath * __nonnull)newIndexPath
{

//        WGBFunc

    /**  初始位置  */
    id objToMove=self.magicData[initialIndexPath.row];
    /**  干掉初始位置  */
    [self.magicData removeObjectAtIndex:initialIndexPath.row];
    /**  挪到新位置  */
    [self.magicData insertObject:objToMove atIndex:newIndexPath.row];


}

/**  选中cell的下标  开始拖动啦  */
- (void)dragDropCollectionViewDraggingDidBeginWithCellAtIndexPath:(NSIndexPath * __nonnull)indexPath
{

//WGBFunc
    WGBLog(@"%ld",indexPath.row);
}

/**  拖动完成啦  */
- (void)dragDropCollectionViewDraggingDidEndForCellAtIndexPath:(NSIndexPath * __nonnull)indexPath
{
//WGBFunc
    WGBLog(@"%ld",indexPath.row);

}

/**  开关 cell的抖动  */
- (IBAction)switchAction:(UISwitch *)sender {

    if (sender.on) {

        [self.collectionView startWiggle];

    }else{

        [self.collectionView stopWiggle];
    }

}

/**  
 
 我发现这个库是不支持换组的   只能在本组里调位置 
 iOS 9 系统自带了这个功能
 */


@end
