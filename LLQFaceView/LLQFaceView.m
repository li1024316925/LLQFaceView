//
//  LLQFaceView.m
//  LLQFaceView
//
//  Created by LLQ on 16/6/17.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "LLQFaceView.h"
#import "LLQFaceViewCell.h"


@implementation LLQFaceView

- (instancetype)initWithFrame:(CGRect)frame
{
    //固定高度
    CGRect newFram = frame;
    newFram.size.height = 249;
    
    self = [super initWithFrame:newFram];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self loadData];
        [self loadCollectionView];
        
    }
    return self;
}

//加载数据
- (void)loadData{
    
    _data = [[NSMutableArray alloc] init];
    
    //加载配置文件
    NSArray *alldataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"]];
    
    //分组数
    int count = (int)alldataArr.count/28;
    if (alldataArr.count%28 != 0) {
        count ++;
    }
    
    //将数据分组
    for (int i = 0; i < count; i ++) {
        //从数据数组中截取每组数据
        //截取位置：   截取长度：如果后面的数据大于28就取28个，如果后面的数据小于28，就取出后面所有的数据
        NSArray *array = [alldataArr subarrayWithRange:NSMakeRange(i * 28, ((alldataArr.count-i*28)<28) ? (alldataArr.count%28) : 28)];
        
        [_data addObject:array];
        
    }
    
}

//加载集合视图
- (void)loadCollectionView{
    
    //创建集合视图
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    //注册单元格
    [collectionView registerClass:[LLQFaceViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:collectionView];
    
}



#pragma mark------UICollectionViewDataSource

//返回每组单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _data.count;
    
}

//返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //复用单元格
    LLQFaceViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];

    //block赋值
    cell.faceName = self.faceNameBlock;
    
    cell.data = _data[indexPath.row];
    
    return cell;
}

@end
