//
//  ViewController.m
//  HorizontaLayout
//
//  Created by guopengwen on 16/12/21.
//  Copyright © 2016年 guopengwen. All rights reserved.
//

#import "ViewController.h"
#import "ShowButtonViewController.h"

#define GPWScreenWidth [UIScreen mainScreen].bounds.size.width
#define GPWScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"layout";
    
    UIButton *layoutTest = [UIButton buttonWithType:UIButtonTypeCustom];
    layoutTest.frame = CGRectMake(10, 70, GPWScreenWidth - 20, 40);
    [layoutTest setTitle:@"layout测试" forState:UIControlStateNormal];
    [layoutTest setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    layoutTest.layer.borderWidth = 0.5;
    layoutTest.layer.borderColor = [UIColor grayColor].CGColor;
    layoutTest.layer.masksToBounds = YES;
    [layoutTest addTarget:self action:@selector(clickLayoutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:layoutTest];
}


- (void)clickLayoutButton{
    ShowButtonViewController *showVC = [ShowButtonViewController new];
    [self.navigationController pushViewController:showVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
