//
//  ListTableViewController.m
//  MusicListRquestFromSQLite
//
//  Created by zhang xu on 15/11/26.
//  Copyright © 2015年 zhang xu. All rights reserved.
//

#import "ListTableViewController.h"

@interface ListTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)HttpRequestData *httpRquest;
@property(nonatomic,strong)DBHelper *dbHlper;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUi];
    [self getDat];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark 设置注册自定义cell
-(void)setUi{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MusicListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    MusicModel *model=self.dataArray[indexPath.row];
    [cell requstDataFromHttp:model];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 60;
}


-(void)getDat{
    
    [self.dbHlper openDB];

    NSArray *allDataArray=[self.dbHlper selectAllMusic];
    
    if (allDataArray.count>0) {
        self.dataArray=(NSMutableArray *)allDataArray;
        [self.tableView reloadData];
        NSLog(@"本地加载");
    }else{
        [self.httpRquest  muiscUrl:MusicListUrl requestDataBlock:^(NSArray *array) {
            
            NSLog(@"网络加载");
            self.dataArray=(NSMutableArray *) array;
            
            [self.tableView reloadData];
            
        }];
    }
    
    
    

    
}

- (IBAction)reference:(UIBarButtonItem *)sender {
    
    [self getDat];
    
}

- (IBAction)ClearAllData:(UIBarButtonItem *)sender {
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.dbHlper deleteMusicList];
        [self.dbHlper  closeDB];
        self.dataArray=nil;
        [self.tableView reloadData];
    }];
    
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

#pragma mark 懒加载
-(HttpRequestData *)httpRquest{
    
    if (!_httpRquest) {
        _httpRquest=[[HttpRequestData alloc]init];
    }
    return _httpRquest;
}

-(DBHelper *)dbHlper{
    
    
    if (!_dbHlper) {
        _dbHlper=[[DBHelper alloc]init];
    }
    
    return _dbHlper;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
