//
//  ViewController.m
//  JiZhang
//
//  Created by 彭凯锋 on 2016/10/10.
//  Copyright © 2016年 pengkaifeng. All rights reserved.
//

#import "ViewController.h"
#import "topTableViewCell.h"
#import "projectViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate,UITabBarDelegate>

@property (nonatomic, strong) UIView *btnView;

@property (nonatomic, strong) UITableViewCell *cell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        _arr = [[NSMutableArray alloc] init];
        _num = (int)_arr.count;
        
    }


    self.tabBarController.tabBar.tintColor = [UIColor orangeColor];
    // Do any additional setup after loading the view, typically from a nib.

    [self addTableView];
    [self addBtnView];

    [_tableView reloadData];

//    [self.view bringSubviewToFront:_btnView];
}

- (void)addTableView{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 44, self.view.bounds.size.width, self.view.bounds.size.height - 44) style:UITableViewStyleGrouped];

    tableView.separatorColor = [UIColor lightGrayColor];

    tableView.backgroundColor = [UIColor clearColor];

    tableView.bounces = NO;

    tableView.dataSource = self;
    tableView.delegate = self;

    _tableView = tableView;
    [self.view addSubview:_tableView];
}

- (void)addBtnView{

    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 90, self.view.bounds.size.height - 90, 70, 70)];
    btnView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 70, 70);
    [btn setBackgroundImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];

    btn.layer.cornerRadius = 35;
    btn.layer.masksToBounds = YES;

    [btnView addSubview:btn];

    _btnView = btnView;
    [self.view addSubview:_btnView];
}

#pragma mark - table view dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        topTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"topTableViewCell" owner:nil options:nil][0];

        cell.shouruLabel.text = [NSString stringWithFormat:@"%.2f元",_shouru];
        cell.shouruLabel.textAlignment = NSTextAlignmentCenter;
        cell.zhichuLabel.text = [NSString stringWithFormat:@"%.2f元",_zhichu];
        cell.zhichuLabel.textAlignment = NSTextAlignmentCenter;
        cell.yueLabel.text = [NSString stringWithFormat:@"%.2f元",_count];
        cell.yueLabel.textAlignment = NSTextAlignmentCenter;

        cell.backgroundColor = [UIColor colorWithRed:67/255.0 green:206/255.0 blue:252/255.0 alpha:1];

        _tableView.frame = CGRectMake(0, 24, self.view.frame.size.width, (_num - 1) * 40 + 200);

        return cell;

    }
    else{

        static NSString *cellIdentifier = @"MTCell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        cell.backgroundColor = [UIColor colorWithRed:61/255.0 green:139/255.0 blue:251/255.0 alpha:1];

        cell.textLabel.text = [NSString stringWithFormat:@"%@", _arr[indexPath.row]];

        _tableView.frame = CGRectMake(0, 24, self.view.frame.size.width, (_num - 1) * 40 + 200);

        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 160;
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  cell下划线满格
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews{

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }

    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}


/**
 *  添加项目
 */
- (void)addProject{
    projectViewController *projectVC = [[projectViewController alloc] init];
    projectVC.dataArr = [NSMutableArray arrayWithArray:_arr];
    projectVC.countValue = _count;
    projectVC.inValue = _shouru;
    projectVC.outValue = _zhichu;
    projectVC.numb = _num;

    [self presentViewController:projectVC animated:YES completion:^{
        NSLog(@"JUMP");

    }];


}

/*
- (void)addProject{

    //创建alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加项目" message:nil preferredStyle:UIAlertControllerStyleAlert];

    //创建action
    UIAlertAction *shouruAction = [UIAlertAction actionWithTitle:@"收入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        NSString *project = alertController.textFields[0].text;
        NSString *price = alertController.textFields[1].text;

        if ([project isEqualToString:@""]||[price isEqualToString:@""]) {
            return ;
        }

        [_arr addObject:[NSString stringWithFormat:@"%@：%@元",project,price]];

        _num += 1;
        _count += [price floatValue];
        _shouru += [price floatValue];

        [_tableView reloadData];
    }];
    UIAlertAction *zhichuAction = [UIAlertAction actionWithTitle:@"支出" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        NSString *project = alertController.textFields[0].text;
        NSString *price = alertController.textFields[1].text;

        if ([project isEqualToString:@""]||[price isEqualToString:@""]) {

            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:nil message:@"不能输入空内容" preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *cancleAc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

            }];

            UIAlertAction *reAction = [UIAlertAction actionWithTitle:@"重新输入" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

                [self addProject];

            }];

            [alertCon addAction:cancleAc];
            [alertCon addAction:reAction];

            //显示alertController
            [self presentViewController:alertCon animated:YES completion:^{}];

        }

        [_arr addObject:[NSString stringWithFormat:@"%@：-%@元",project,price]];

        _num += 1;
        _count -= [price floatValue];
        _zhichu -= [price floatValue];
        [_tableView reloadData];
    }];

    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {

    }];

    //添加
    [alertController addAction:cancleAction];
    [alertController addAction:shouruAction];
    [alertController addAction:zhichuAction];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {

        textField.placeholder = @"请输项目名称";

    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {

        textField.placeholder = @"请输金额";
        textField.secureTextEntry = NO;

    }];

    //显示alertController
    [self presentViewController:alertController animated:YES completion:^{}];

    UIAlertAction *action = alertController.actions[0];
    action.enabled = YES;

}

*/




@end
