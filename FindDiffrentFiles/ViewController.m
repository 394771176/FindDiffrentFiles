//
//  ViewController.m
//  FindDiffrentFile
//
//  Created by cheng on 2020/6/25.
//  Copyright © 2020 cheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    __weak IBOutlet NSTextField *textField1;
    __weak IBOutlet NSTextField *textField2;
    
    __weak IBOutlet NSTextView *textView1;
    __weak IBOutlet NSTextView *textView2;
    
    NSString *firstPath1;
    NSString *firstPath2;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //if read from cache, it will get empty files, I don't know why ???
//    [NSUserDataManager getTextField:textField1 forKey:@"textField1"];
//    [NSUserDataManager getTextField:textField2 forKey:@"textField2"];
}

- (IBAction)clearPathAction:(id)sender {
    textField1.stringValue = @"";
    textField2.stringValue = @"";
}

- (IBAction)FindBtnAction:(id)sender {
    NSString *path1 = textField1.stringValue;
    NSString *path2 = textField2.stringValue;
    
    textView1.string = @"";
    textView2.string = @"";
    
    if (path1.length && path2.length) {
        [NSUserDataManager saveTextField:textField1 forKey:@"textField1"];
        [NSUserDataManager saveTextField:textField2 forKey:@"textField2"];
        [self findDiffrentFiles:path1 andPath:path2 dirName:nil];
    } else {
        if (path1.length <= 0) {
            textView1.string = @"文件路径1为空";
        }
        
        if (path2.length <= 0) {
            textView2.string = @"文件路径2为空";
        }
    }
}

- (void)findDiffrentFiles:(NSString *)path1 andPath:(NSString *)path2 dirName:(NSString *)dirName
{
    if (path1.length <= 0 || path2.length <= 0) {
        return;
    }
    
    NSString *pp1 = [path1 copy];
    NSString *pp2 = [path2 copy];
    if (dirName.length) {
        pp1 = [pp1 stringByAppendingPathComponent:dirName];
        pp2 = [pp2 stringByAppendingPathComponent:dirName];
    }
    
    if (![DTFileManager isFileDirectory:pp1] || ![DTFileManager isFileDirectory:pp2]) {
        return;
    }
    
    NSArray *contents1 = [DTFileManager contentsWithPath:pp1];
    NSArray *contents2 = [DTFileManager contentsWithPath:pp2];
    
    NSMutableArray *diff1 = [NSMutableArray arrayWithArray:contents1];
    NSMutableArray *diff2 = [NSMutableArray arrayWithArray:contents2];
    
    if (diff1.count && diff2.count) {
        [diff1 removeObjectsInArray:contents2];
        [diff2 removeObjectsInArray:contents1];
    }
    
    [self showDiffrent:diff1 dirName:dirName toTextView:textView1];
    [self showDiffrent:diff2 dirName:dirName toTextView:textView2];
    
    NSMutableArray *same = [contents1 mutableCopy];
    [same removeObjectsInArray:diff1];
    
    [same enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (dirName) {
            [self findDiffrentFiles:path1 andPath:path2 dirName:[dirName stringByAppendingPathComponent:obj]];
        } else {
            [self findDiffrentFiles:path1 andPath:path2 dirName:obj];
        }
    }];
}

- (void)showDiffrent:(NSArray *)diff dirName:(NSString *)dirName toTextView:(NSTextView *)textView
{
    if (diff.count) {
        [diff enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:@".DS_Store"]) {
                
            } else {
                if (dirName.length) {
                    [textView addLog:[dirName stringByAppendingPathComponent:obj]];
                } else {
                    [textView addLog:obj];
                }
            }
        }];
    }
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
