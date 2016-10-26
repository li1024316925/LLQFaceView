//
//  ViewController.m
//  LLQFaceView
//
//  Created by LLQ on 16/6/17.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "ViewController.h"
#import "LLQFaceView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    LLQFaceView *faceView = [[LLQFaceView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 400)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 414, 50)];
//    label.text = faceView.faceName;
    label.backgroundColor = [UIColor yellowColor];
    
    [faceView setFaceNameBlock:^(NSString *facename) {
       
        label.text = facename;
        
    }];
    
    
    [self.view addSubview:label];
    [self.view addSubview:faceView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
