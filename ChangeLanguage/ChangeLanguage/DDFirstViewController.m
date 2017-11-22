//
//  DDFirstViewController.m
//  ChangeLanguage
//
//  Created by Poseidon on 2017/11/11.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "DDFirstViewController.h"

@interface DDFirstViewController ()

@end

@implementation DDFirstViewController

- (void)changeToEnglish
{
    [[DDLanguageTool shareInstance] setNewLanguage:EN];
}

- (void)changeToChinese
{
    [[DDLanguageTool shareInstance] setNewLanguage:ZH];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *eBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    [eBtn addTarget:self action:@selector(changeToEnglish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eBtn];
    
    UIButton *cBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 200, 200, 100)];
    [cBtn addTarget:self action:@selector(changeToChinese) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cBtn];
    
    self.title = DDGetStringWithKeyFormTable(@"homePage", @"ChangeLauguage");
    [eBtn setTitle:DDGetStringWithKeyFormTable(@"changeToEnglish", @"ChangeLauguage") forState:UIControlStateNormal];
    [cBtn setTitle:DDGetStringWithKeyFormTable(@"changeToChinese", @"ChangeLauguage") forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
