

#import "TopView.h"
#import "UIKit+AFNetworking.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation TopView{
    UIView *topView;
}

- (UIView *)topViewWith:(id)data{
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
//    UIImageView *topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
//    [topImage setImageWithURL:data[@"banner"]];
//    [topView addSubview:topImage];

    topView.backgroundColor = [UIColor redColor];
    
    return topView;
}
@end
