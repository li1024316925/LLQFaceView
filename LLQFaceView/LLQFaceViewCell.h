//
//  LLQFaceViewCell.h
//  LLQFaceView
//
//  Created by LLQ on 16/6/17.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FaceName)(NSString *facename);

@interface LLQFaceViewCell : UICollectionViewCell
{
    UIView *_faceView;
    UIImageView *_magnifier;
    UIImageView *_gif;
}

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)FaceName faceName;


- (void)setFaceName:(FaceName)faceName;

@end
