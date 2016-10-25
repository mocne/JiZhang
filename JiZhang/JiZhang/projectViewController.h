//
//  projectViewController.h
//  JiZhang
//
//  Created by 彭凯锋 on 2016/10/19.
//  Copyright © 2016年 pengkaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface projectViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UITextField *projectTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UITextField *remarksTextField;
@property (strong, nonatomic) IBOutlet UISegmentedControl *choseSeg;


@property (nonatomic) BOOL isPlus;
@property (nonatomic) float countValue;
@property (nonatomic) float inValue;
@property (nonatomic) float outValue;
@property (nonatomic) int numb;

@end
