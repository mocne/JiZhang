//
//  projectViewController.m
//  JiZhang
//
//  Created by 彭凯锋 on 2016/10/19.
//  Copyright © 2016年 pengkaifeng. All rights reserved.
//

#import "projectViewController.h"
#import "ViewController.h"

@interface projectViewController ()



@end

@implementation projectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    [_choseSeg addTarget:self action:@selector(doSomethingInSegment:) forControlEvents:UIControlEventValueChanged];
    _choseSeg.selectedSegmentIndex = 0;//默认选中的按钮索引

//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch2"]) {
        // 这里判断是否第一次
        _dataArr = [NSMutableArray array];
//
//    }
    _isPlus = true;
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{

    NSInteger Index = Seg.selectedSegmentIndex;

    switch (Index)
    {
        case 0:
            self.isPlus = true;
            break;
        case 1:
            self.isPlus = false;
            break;

        default:
            break;
    }
}

//取消添加
- (IBAction)exit:(id)sender {

    ViewController *VC = [[ViewController alloc] init];

    VC.arr = _dataArr;
    VC.count = _countValue;
    VC.shouru = _inValue;
    VC.zhichu = _outValue;
    VC.num = _numb;
    
    [self presentViewController:VC animated:NO completion:^{
        NSLog(@"EXIT");
    }];
}


//添加项目
- (IBAction)addProject:(id)sender {

    ViewController *VC = [[ViewController alloc] init];

    NSString *projectText = _projectTextField.text;
    NSString *priceText = _priceTextField.text;

    float p = [priceText floatValue];

    if (_isPlus == false) {

        float a = -p;
        p = a;

        _outValue += p;

    }
    else{

        _inValue += p;

    }

    _countValue += p;

    [_dataArr addObject:[NSString stringWithFormat:@"%@ : %.2f",projectText,p]];


//    VC.arr = [[NSMutableArray alloc] initWithArray:_dataArr];
    VC.count = _countValue;
    VC.shouru = _inValue;
    VC.zhichu = _outValue;
    VC.num = _numb + 1;


    [self presentViewController:VC animated:NO completion:^{
        NSLog(@"ADD");

        [VC.arr addObject:[NSString stringWithFormat:@"%@ : %.2f",projectText,p]];
        [VC.tableView reloadData];

    }];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_priceTextField resignFirstResponder];
    [_projectTextField resignFirstResponder];
    [_remarksTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
