//
//  HeaderView.m
//  MVVMDemo
//
//  Created by 郭洪安 on 2016/11/15.
//  Copyright © 2016年 ShunLian. All rights reserved.
//

#import "HeaderView.h"
#import "UIKit+AFNetworking.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HeaderView{
    UIImageView *topImage;
    NSMutableArray *dataArray;
}

- (UIView *)headerViewWithData:(id)data{
    
    dataArray = data;

    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_WIDTH/5*2)];
    view.backgroundColor=[UIColor redColor];
    view.userInteractionEnabled = YES;
    
    CGFloat btnWidth  = SCREEN_WIDTH/5;
    CGFloat btnHeight = SCREEN_WIDTH/5;
    CGFloat margin=(SCREEN_WIDTH-5*btnWidth)/6;
    
    for (int i = 0; i <dataArray.count; i++) {
        
        int row = i % 5;
        int loc = i / 5;
        CGFloat appviewx=margin+(margin+btnWidth)*row;
        CGFloat appviewy=(10+btnHeight)*loc;
        
        _button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _button.frame = CGRectMake(appviewx, appviewy, btnWidth, btnHeight);
        _button.highlighted = NO;
        _button.tag = i;
        [_button setImageForState:(UIControlStateNormal) withURL:[NSURL URLWithString:dataArray[i][@"icon"]]];
        _button.userInteractionEnabled = YES;
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:_button];

    }
    return view;
}

- (void)buttonClick:(UIButton *)tag{
    NSLog(@"0000000");
}

- (void)headerViewDidSeletced:(UIViewController *)vc indexPath:(NSString *)tag{
        
    UIViewController *view = [[UIViewController alloc]init];
    view.view.backgroundColor = [UIColor whiteColor];
    [vc.navigationController pushViewController:view animated:YES];
}

@end
