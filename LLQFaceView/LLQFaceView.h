//
//  LLQFaceView.h
//  LLQFaceView
//
//  Created by LLQ on 16/6/17.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FaceName)(NSString *facename);

@interface LLQFaceView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableDictionary *_faceIconDic;
}
@property(nonatomic,strong)NSMutableArray *data;

@property(nonatomic,copy)NSString *faceName;

//定义block
@property(nonatomic,copy)FaceName faceNameBlock;

- (void)setFaceNameBlock:(FaceName)faceNameBlock;

@end
