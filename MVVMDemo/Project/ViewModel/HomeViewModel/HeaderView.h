

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewModelClass.h"

typedef void(^HeaderViewBlock)(NSString *shopId);

@interface HeaderView : UIView

@property (nonatomic, copy) HeaderViewBlock block;


// headerView中的数据
- (void)headerViewWithData:(id)data;

- (void)setBlock:(HeaderViewBlock)block;


@end
