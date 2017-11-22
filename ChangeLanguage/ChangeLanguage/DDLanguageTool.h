//
//  DDLanguageTool.h
//  ChangeLanguage
//
//  Created by Poseidon on 2017/11/21.
//  Copyright © 2017年 Poseidon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZH @"zh-Hans"
#define EN @"en"

/**
 加载设定的语言
 */
#define DDGetStringWithKeyFormTable(key, table) [[DDLanguageTool shareInstance] getStringForKey:key fromTable:table]

@interface DDLanguageTool : NSObject

+ (id)shareInstance;

/**
 设置新语言

 @param language 新语言 中文:ZH 英文:EN
 */
- (void)setNewLanguage:(NSString *)language;

/**
 从table中获得key对应的值

 @param key 当前修改语言的key
 @param table 当前修改语言的table
 @return 返回table中key对应的值
 */
- (NSString *)getStringForKey:(NSString *)key fromTable:(NSString *)table;

@end
