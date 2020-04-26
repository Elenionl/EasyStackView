//
//  ESVCalculator.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/13.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESVEnum.h"
#import "ESVItemManageType.h"
#import "ESVFlexManageType.h"
#import "ESVConfigManageType.h"
#import "ESVRefreshManageType.h"

NS_ASSUME_NONNULL_BEGIN

@class UIView, ESVStackItemConfig;

@interface ESVCalculator : NSObject

+ (CGSize)layoutWithSize:(CGSize)size flexConfig:(id<ESVFlexManageType>)flexConfig arrangedConfigs:(NSArray <ESVStackItemConfig *>*)arrangedConfigs;

+ (CGSize)scrollViewLayoutWithSize:(CGSize)size flexConfig:(id<ESVFlexManageType>)flexConfig arrangedConfigs:(NSArray <ESVStackItemConfig *>*)arrangedConfigs;

@end

NS_ASSUME_NONNULL_END
