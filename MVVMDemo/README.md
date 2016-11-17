# MVVMDemo
# 我对iOS开发中使用MVVM的理解(初级)
## 前言
之前几个月一直在学习react-native，它的组件化开发真的是很棒，控件和页面的组件化在开发中可以很好的复用，节省开发时间。那个时候还不知道react-native开发用到的就是MVVM设计模式。
前几天，UI给了新的需求，需要添加几个页面（之前的项目一直使用MVC开发的），在给这几个新页面添加入口的时候，感觉之前写的代码真的是好恶心😱😱😱，就在网上搜了搜MVP和MVVM，发现MVVM和我在写RN时的写法很像。就研究了一下，然后写下了这篇文章。(可能会有很多问题，欢迎评论)
ps：这篇文章实用为主，那些理论性的东西，我都没有研究。
俗话说得好：黑猫白猫，能用在项目中的就是好🐱
## 使用
MVVM顾名思义，那就是Model，View，ViewModel，所以我们需要创建这些类了。

![ViewModelClass](https://github.com/RabbitBell/MVVMDemo/tree/master/ViewModelClass.png)

接下来就把我的理解说说。
[]()
### ViewModelClass
![ViewModelClass](media/14782222242343/ViewModelClass.png)
`ViewModelClass.h`中

```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//定义返回请求数据的block类型
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);

@interface ViewModelClass : NSObject

@property (strong, nonatomic) ReturnValueBlock returnBlock;
@property (strong, nonatomic) ErrorCodeBlock errorBlock;

// 传入交互的Block块
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock;
@end
```
`ViewModelClass.m`

```
#import "ViewModelClass.h"
#import "RTNetworking.h"

@implementation ViewModelClass

#pragma 接收传过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
}
@end
```
上面的两个类放着的就是ViewModel的基类，用下面的方法承接之后继承于这个基类的VM中的回调数据。

```
- (void)setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock;
```
### ViewController
我之前的项目用的MVC设计模式，C指的就是这个ViewController了，之前写的垃圾代码，一个Controller里面最多放过1000多行代码，现在去找个方法需要N久。但虽然这是个简单的例子，但其实并不简单。
`ViewController.m` 


```
// 初始化HeaderVM
HeaderVM *headerView = [[HeaderVM alloc] init];
// 初始化HomeVM
HomeVM *model = [[HomeVM alloc]init];
// 调用ViewModelClass基类的方法，来获取数据
[model setBlockWithReturnBlock:^(id returnValue) {
        
        _dataArray = returnValue;
        _listArray = returnValue[@"picList"];
        _categoryArray = returnValue[@"category_new"];
        
        UIView *view = [headerView headerViewWithData:_categoryArray];
        self.tableView.tableHeaderView = view;

        [self.tableView reloadData];

    } WithErrorBlock:^(id errorCode) {
        
        NSLog(@"%@",errorCode);
        
    }];

```
上面的代码虽短，但最重要的东西都在里面，通过Block回调，将需要的数据在VM页面回传了回来。具体内容可以在Demo

### HomeVM
![HomeV](media/14782222242343/HomeVM.png)
`HomeVM.h`

```
#import "ViewModelClass.h"

@interface HomeVM : ViewModelClass

// 获取商品列表
- (void)fetchShopList;
// 跳转到商品详情页
- (void)shopListDetailWithVC:(UIViewController *)vc didSelectRowAtDic:(NSDictionary *)dic;

@end
```
`HomeVM.m`

```
#import "HomeVM.h"
#import "RTNetworking.h"
#import "DetailViewController.h"

@implementation HomeVM

- (void)fetchShopList{
    [RTNetworking getWithUrl:@"/v1/Home/all.json" refreshCache:NO success:^(id response) {
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
    [vc.navigationController pushViewController:view animated:YES];
}
@end
```

可以明显看出`HomeVM`是继承于`ViewModelClass`，在这个VM中，将Push到新页面的方法也写在了里面。

### HeaderVM
这个是一个tableView的headerView。
![HeaderV](media/14782222242343/HeaderVM.png)

`HeaderVM.h`


```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewModelClass.h"

@interface HeaderVM : ViewModelClass

// headerView中的数据
- (UIView *)headerViewWithData:(id)data;

// headerView中的按钮的点击事件
- (void)headerViewDidSeletced:(UIViewController *)vc indexPath:(NSString *)string;

@end
```
`HeaderVM.m`

```
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
```
我将HeaderView的布局写在了这个VM里面，还有HeaderView上的按钮的点击事件。
## 问题
button的点击事件，我在HeaderVM里面放置了button的点击事件，却不会调用，但将这个点击事件放在ViewController里面就可以调用，我不知道是为什么。
但我在写RN的时候，知道如果上级想要调用下级的方法，需要下级公开一个属性出来，上级复写这个方法，所以我的理解就是，在HeaderVM中的方法，在上级调用是没问题的。如果有大神能解决这个问题，希望告知。
## 总结
可能你会发现这个目录中没有Model，也没有View，这是因为我做的这个Demo中用Model太浪费，而没有View是因为，我把它给弄成VM了，可能这样写不好，但我用起来感觉还不错，以后，如果我感觉我对MVVM的理解更深一层的时候，会再写一篇关于MVVM的文章，敬请期待啦！
这个Demo中的数据用的是我公司首页的接口，请不要乱用哦！
Demo中用到的网络请求是我再封装的一层，用起来还不错，如果有什么好的建议欢迎提出


