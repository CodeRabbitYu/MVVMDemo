

#import <Foundation/Foundation.h>
@class ShopInfo;
@interface DetailModel : NSObject

/** 店铺信息 */
@property (nonatomic, strong) ShopInfo *shopInfo;
/** 分享链接 */
@property (nonatomic, strong) NSString *shareLink;

@end

@interface ShopInfo : NSObject

/** <#type#> */
@property (nonatomic, strong) NSString *banner;
/** <#type#> */
@property (nonatomic, strong) NSString *shop_name;

@end
