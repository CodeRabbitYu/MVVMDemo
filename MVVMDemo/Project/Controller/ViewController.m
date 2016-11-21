

#import "ViewController.h"

#import "ViewModelClass.h"
#import "HomeVM.h"
#import "HeaderView.h"
#import "DetailViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView初始化 */
@property (nonatomic, strong) UITableView *tableView;
/** 总数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/** 列表数据 */
@property (nonatomic, strong) NSMutableArray *listArray;
/** 分类数据 */
@property (nonatomic, strong) NSMutableArray *categoryArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"MVVMDemo";
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _dataArray = [NSMutableArray array];
    _listArray = [NSMutableArray array];
    _categoryArray = [NSMutableArray array];
    
    HomeVM *model = [[HomeVM alloc]init];
    
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH * 0.17*2+30)];
    
    self.tableView.tableHeaderView = headerView;
    
    DetailViewController *detail = [[DetailViewController alloc]init];

    __weak __typeof(&*self)weakSelf = self;
    
    [headerView setBlock:^(NSString *shopId) {
        NSLog(@"%@",shopId);
        detail.labelText = shopId;
        [weakSelf.navigationController pushViewController:detail animated:YES];
    }];

    [model setBlockWithReturnBlock:^(id returnValue) {
        
        _dataArray = returnValue;
        _listArray = returnValue[@"picList"];
        _categoryArray = returnValue[@"category_new"];
        
        [headerView headerViewWithData:_categoryArray];
        
        [self.tableView reloadData];
        
    } WithErrorBlock:^(id errorCode) {
        
        NSLog(@"%@",errorCode);
        
    }];
    
    [model fetchShopList];

}

#pragma mark - 返回TableViewCell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listArray.count;
}
#pragma mark - 创建TableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        //是用代码创建的Cell
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellID];
    }
    cell.textLabel.text = _listArray[indexPath.row][@"title"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeVM *model = [[HomeVM alloc]init];
    [model shopListDetailWithVC:self didSelectRowAtDic:_listArray[indexPath.row]];
}


@end
