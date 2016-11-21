

#import "ViewModelClass.h"

@interface HomeVM : ViewModelClass

// 获取商品列表
- (void)fetchShopList;
// 跳转到商品详情页
- (void)shopListDetailWithVC:(UIViewController *)vc didSelectRowAtDic:(NSDictionary *)dic;

@end
