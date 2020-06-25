//
//  NSUserDataManager.h
//  QuestionCompareTools
//
//  Created by cheng on 2017/10/27.
//  Copyright © 2017年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NSDBTypeKJZ = 0,
    NSDBTypeJKBD,
    NSDBTypeJXYDT,
    NSDBTypeYBJK,
} NSDBType;

typedef NS_ENUM(NSUInteger, NSEmType) {
    NSEmType1,
    NSEmType2
};

typedef enum {
    DTCertTypeXiaoche = 1, // 小车
    DTCertTypeKeche = 2, // 客车
    DTCertTypeHuoche = 4, // 货车
    DTCertTypeMotoche = 8, // 摩托车
    DTCertTypeTaxi = 16, // 出租车
    DTCertTypeHuoyun = 32, // 货运
    DTCertTypeJiaolian = 64, // 教练
    DTCertTypeKeyun = 128, // 客运
    DTCertTypeWeixian = 256, // 危险品
    DTCertTypeTaxiInternet = 512, //网约车
} DTCertType;

@interface NSUserDataManager : NSObject

@property (nonatomic) NSInteger dbType;

@property (nonatomic, strong) NSString *kjzPath;
@property (nonatomic, strong) NSString *otherPath;
@property (nonatomic, strong) NSString *otherOldPath;

+ (instancetype)sharedInstance;

+ (void)saveTextField:(NSTextField *)textField forKey:(NSString *)key;
+ (void)getTextField:(NSTextField *)textField forKey:(NSString *)key;

@end
