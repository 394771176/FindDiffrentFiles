//
//  NSUserDataManager.m
//  QuestionCompareTools
//
//  Created by cheng on 2017/10/27.
//  Copyright © 2017年 cheng. All rights reserved.
//

#import "NSUserDataManager.h"

#define APP_CONST_KJZ_DB_PATH               @"app.const.kjz.db.path"

#define APP_CONST_OTHER_DB_PATH             @"app.const.otder.db.path"

@implementation NSUserDataManager

@synthesize kjzPath = _kjzPath;

+ (instancetype)sharedInstance
{
    static id instance = nil;
    if (!instance) {
        instance = [[self alloc] init];
    }
    return instance;
}

- (NSString *)kjzPath
{
    if (!_kjzPath) {
        _kjzPath = [[NSUserDefaults standardUserDefaults] stringForKey:APP_CONST_KJZ_DB_PATH];
    }
    return _kjzPath;
}

- (void)setKjzPath:(NSString *)kjzPath
{
    _kjzPath = kjzPath;
    [[NSUserDefaults standardUserDefaults] setObject:kjzPath forKey:APP_CONST_KJZ_DB_PATH];
}

- (NSString *)otherPathIsOld:(BOOL)isOld
{
    NSString *key = [APP_CONST_OTHER_DB_PATH stringByAppendingFormat:@"_%zd_%zd", (isOld ? 1 : 0), _dbType];
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    return string;
}

- (void)setOtherPath:(NSString *)otherPath isOld:(BOOL)isOld
{
    NSString *key = [APP_CONST_OTHER_DB_PATH stringByAppendingFormat:@"_%zd_%zd", (isOld ? 1 : 0), _dbType];
    [[NSUserDefaults standardUserDefaults] setObject:otherPath forKey:key];
}

- (NSString *)otherPath
{
    return [self otherPathIsOld:NO];
}

- (void)setOtherPath:(NSString *)otherPath
{
    [self setOtherPath:otherPath isOld:NO];
}

- (NSString *)otherOldPath
{
    return [self otherPathIsOld:YES];
}

- (void)setOtherOldPath:(NSString *)otherOldPath
{
    [self setOtherPath:otherOldPath isOld:YES];
}

+ (void)saveTextField:(NSTextField *)textField forKey:(NSString *)key
{
    if (textField && textField.stringValue.length && key.length) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.stringValue forKey:key];
    }
}

+ (void)getTextField:(NSTextField *)textField forKey:(NSString *)key
{
    if (key.length && textField) {
        NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if (string.length) {
            [textField setStringValue:string];
        }
    }
}

@end
