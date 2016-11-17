

#import "ViewController.h"

#import "ViewModelClass.h"
#import "HomeVM.h"
#import "HeaderVM.h"

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
    
    HeaderVM *headerView = [[HeaderVM alloc] init];
    HomeVM *model = [[HomeVM alloc]init];
    
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
    
    [model fetchShopList];

}

- (void)buttonClick:(UIButton *)button{
    
    HeaderVM *headerView = [[HeaderVM alloc] init];
    
    [headerView headerViewDidSeletced:self indexPath:_categoryArray[button.tag][@"id"]];
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
