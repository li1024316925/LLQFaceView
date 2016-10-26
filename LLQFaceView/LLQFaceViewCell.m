//
//  LLQFaceViewCell.m
//  LLQFaceView
//
//  Created by LLQ on 16/6/17.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "LLQFaceViewCell.h"

#define kFaceScreenW [[UIScreen mainScreen] bounds].size.width
#define kFaceScreenH 220

#define kItemSize 30
#define kItemSpace 20



@implementation LLQFaceViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadFaceView];

        
    }
    return self;
}

//加载表情视图
- (void)loadFaceView{
    
    _faceView = [[UIView alloc] initWithFrame:CGRectMake(14.5, 14.5, self.bounds.size.width-29, self.bounds.size.height-29)];
    _faceView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_faceView];
    
}

//复写data的set方法，赋值时创建小单元格
- (void)setData:(NSArray *)data{
    
    _data = data;
    
    [self createImage];
    
}

//创建图片
- (void)createImage{
    
    //绘制背景图片
//    UIImage *bgImage = [UIImage imageNamed:@"emoticon_keyboard_background"];
//    [bgImage drawInRect:self.bounds];
    
    //移除所有子视图
    for (UIView *v in _faceView.subviews) {
        if ([v isKindOfClass:[UIImageView class]]) {
            [v removeFromSuperview];
        }
    }
    
    for (int i = 0; i < _data.count; i ++) {
        
        //创建小图，并赋值图片
        UIImageView *item = [[UIImageView alloc] initWithFrame:[self makeFrameAtIndex:i]];
        NSString *imageName = [_data[i] objectForKey:@"png"];
        item.image = [UIImage imageNamed:imageName];
        
        [_faceView addSubview:item];
        
    }
    
}

//创建frame
- (CGRect)makeFrameAtIndex:(int)index{
    
    int x = index%7;
    int y = index/7;
    
    return CGRectMake(x*kItemSize + kItemSpace*(x+1), kItemSize*y + kItemSpace*(y+1), kItemSize, kItemSize);
    
}


//触摸开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //创建放大镜
    if (_magnifier == nil) {
        _magnifier = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emoticon_keyboard_magnifier"]];
        
        _magnifier.frame = CGRectMake(0, 0, 64, 92);
        //开始时隐藏
        _magnifier.hidden = YES;
        //创建放大镜中小图
        _gif = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [_magnifier addSubview:_gif];
        [self addSubview:_magnifier];
    }
    
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_faceView];
    
    //获取触摸点对应的表情index
    int index = [self indexForPoint:point];
    //判断Index是否大于数组长度，防止越界
    if (index >= _data.count) {
        return;
    }
    
    //获取下标对应的表情图片的frame
    CGRect frameIndex = [self makeFrameAtIndex:index];
    
    //计算出当前表情图片的中心位置
    CGFloat centerX = frameIndex.origin.x + frameIndex.size.width/2;
    CGFloat centerY = frameIndex.origin.y + frameIndex.size.height/2;
    
    //将放大镜设置在表情的中心位置上
    _magnifier.center = CGPointMake(centerX+16, centerY-23);
    //显示
    _magnifier.hidden = NO;
    
    //设置放大镜上面小图
    NSString *imageName = [_data[index] objectForKey:@"png"];
    _gif.image = [UIImage imageNamed:imageName];
    
    //让集合视图不能滑动
    [(UICollectionView *)self.superview setScrollEnabled:NO];
    
}

//通过一个点，计算表情图片的Index
- (int)indexForPoint:(CGPoint)point{
    
    int x = point.x/(_faceView.bounds.size.width/7);
    int y = point.y/(_faceView.bounds.size.height/4);
    
    return y*7+x;
}

//触摸移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_faceView];
    
    //获取触摸点对应的表情index
    int index = [self indexForPoint:point];
    //判断Index是否大于数组长度，防止越界
    if (index >= _data.count) {
        return;
    }
    
    //获取下标对应的表情图片的frame
    CGRect frameIndex = [self makeFrameAtIndex:index];
    
    //计算出当前表情图片的中心位置
    CGFloat centerX = frameIndex.origin.x + frameIndex.size.width/2;
    CGFloat centerY = frameIndex.origin.y + frameIndex.size.height/2;
    
    //将放大镜设置在表情的中心位置上
    _magnifier.center = CGPointMake(centerX+16, centerY-23);
    //显示
    _magnifier.hidden = NO;
    
    //设置放大镜上面小图
    NSString *imageName = [_data[index] objectForKey:@"png"];
    _gif.image = [UIImage imageNamed:imageName];
    
}

//触摸结束
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //开启集合视图的滑动效果
    [(UICollectionView *)self.superview setScrollEnabled:YES];
    
    //隐藏放大镜
    _magnifier.hidden = YES;
    
    //获取触摸点对应的Index
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_faceView];
    
    //获取触摸点对应的表情index
    int index = [self indexForPoint:point];
    //判断Index是否大于数组长度，防止越界
    if (index >= _data.count) {
        return;
    }
    
     NSString *faceName = [_data[index] objectForKey:@"chs"];
    //回调block
    _faceName(faceName);
}

@end
