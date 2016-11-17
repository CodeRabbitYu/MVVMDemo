

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewModelClass.h"

@interface HeaderVM : ViewModelClass

// headerView中的数据
- (UIView *)headerViewWithData:(id)data;

// headerView中的按钮的点击事件
- (void)headerViewDidSeletced:(UIViewController *)vc indexPath:(NSString *)string;

@end
