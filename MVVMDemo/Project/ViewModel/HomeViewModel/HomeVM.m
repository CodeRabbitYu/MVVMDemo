

#import "HomeVM.h"
#import "RTNetworking.h"
#import "DetailViewController.h"

@implementation HomeVM

- (void)fetchShopList{
    [RTNetworking getWithUrl:@"v1/Home/all.json" refreshCache:NO success:^(id response) {
        
        [self loadDataWithSuccessDic:response];
        
    } fail:^(NSError *error) {
        
        self.errorBlock(error);
        
    }];
}
- (void)loadDataWithSuccessDic:(NSDictionary *)dic{
    NSMutableArray *arr = dic[@"data"];
    self.returnBlock(arr);
}

- (void)shopListDetailWithVC:(UIViewController *)vc didSelectRowAtDic:(NSDictionary *)dic{
    DetailViewController *view = [[DetailViewController alloc]init];
    view.labelText = dic[@"title"];
//    view.shopId = dic[@"itemId"];
    [vc.navigationController pushViewController:view animated:YES];
}

@end


