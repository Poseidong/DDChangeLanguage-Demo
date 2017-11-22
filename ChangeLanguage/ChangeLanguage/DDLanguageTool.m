//
//  DDLanguageTool.m
//  ChangeLanguage
//
//  Created by Poseidon on 2017/11/21.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import "DDLanguageTool.h"
#import "AppDelegate.h"
#import "DDFirstViewController.h"

#define DDLAUGUAGESET @"DDLAUGUAGESET"

@interface DDLanguageTool ()
//当前选择的bundle
@property (nonatomic, strong) NSBundle *currentBundle;
//当前选择的语言
@property (nonatomic, strong) NSString *currentLanguage;

@end

@implementation DDLanguageTool

+ (id)shareInstance
{
    static DDLanguageTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initLanguage];
    }
    return self;
}

/**
 初始化语言(修改后的语言)
 修改语言完成后将修改后的语言保存在本地,下次启动app时,继续加载修改后的语言
 */
- (void)initLanguage
{
    NSString *language = [[NSUserDefaults standardUserDefaults] objectForKey:DDLAUGUAGESET];
    //如果获取的语言为空 就将语言设置为英语
    if (language == nil || [language isEqualToString:@""]) {
        language = EN;
    }
    self.currentLanguage = language;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.currentBundle = [NSBundle bundleWithPath:bundlePath];
}

/**
 @return 返回table中key对应的值
 */
- (NSString *)getStringForKey:(NSString *)key fromTable:(NSString *)table
{
    return NSLocalizedStringFromTableInBundle(key, table, self.currentBundle, @"");
}

/**
 设置新语言
 */
- (void)setNewLanguage:(NSString *)language
{
    if (![language isEqualToString:EN] && ![language isEqualToString:ZH]) {
        NSLog(@"设置了错误的语言");
        return;
    }
    //如果设置的新语言与上次的语言相同,不做任何操作
    if ([language isEqualToString:self.currentLanguage]) {
        return;
    }
    
    self.currentLanguage = language;
    
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    self.currentBundle = [NSBundle bundleWithPath:bundlePath];
    
    //保存当前设置的语言
    [[NSUserDefaults standardUserDefaults] setObject:language forKey:DDLAUGUAGESET];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //重启app
    [self resetRootViewController];
}

/**
 重启app(重新设置rootViewController)
 */
- (void)resetRootViewController
{
    //设置rootViewController
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    DDFirstViewController *firstVC = [[DDFirstViewController alloc] init];
    firstVC.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:10000];
    UINavigationController *firstNC = [[UINavigationController alloc] initWithRootViewController:firstVC];
    
    UITabBarController *tabBC = [[UITabBarController alloc] init];
    [tabBC setViewControllers:@[firstNC]];
    
    [appDelegate.window setRootViewController:tabBC];
    
}

@end
