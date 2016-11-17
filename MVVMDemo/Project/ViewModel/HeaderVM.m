

#import "HeaderVM.h"
#import "UIKit+AFNetworking.h"
#import "DetailViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HeaderVM{
    UIImageView *topImage;
    NSMutableArray *dataArray;
    UIButton *button;
}

- (UIView *)headerViewWithData:(id)data{
    dataArray = data;
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,SCREEN_WIDTH/5*2)];
    view.userInteractionEnabled = YES;
    
    CGFloat btnWidth  = SCREEN_WIDTH/5;
    CGFloat btnHeight = SCREEN_WIDTH/5;
    CGFloat margin=(SCREEN_WIDTH-5*btnWidth)/6;
    
    for (int i = 0; i <dataArray.count; i++) {
        
        int row = i % 5;
        int loc = i / 5;
        CGFloat appviewx=margin+(margin+btnWidth)*row;
        CGFloat appviewy=(10+btnHeight)*loc;
        
        button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(appviewx, appviewy, btnWidth, btnHeight);
        button.highlighted = NO;
        button.tag = i;
        [button setImageForState:(UIControlStateNormal) withURL:[NSURL URLWithString:dataArray[i][@"icon"]]];
        button.userInteractionEnabled = YES;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:button];

    }
    return view;
}

// 这个东西吧，不写报警告，写上我还不知道是干嘛的。。。
- (void)buttonClick:(UIButton *)tag{
}

// Header的点击事件
- (void)headerViewDidSeletced:(UIViewController *)vc indexPath:(NSString *)string{
    
    NSLog(@"tag : %@",string);
        
    DetailViewController *view = [[DetailViewController alloc]init];
    view.labelText = string;
    [vc.navigationController pushViewController:view animated:YES];
}

@end
