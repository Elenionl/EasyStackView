//
//  ESVConfigManageType.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/11.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESVItemManageType.h"

NS_ASSUME_NONNULL_BEGIN

@class ESVStackItemConfig;

@protocol ESVStackItemType;

@protocol ESVConfigManageType <ESVItemManageType>

/// Settle config of item. -setNeedLayout will be called automatically after change config.
/// @param item The item you want to change config of.
/// @param configAction Change config in this block, will be called synchronized. There is no retain circle problem.
- (void)manageConfigOfItem:(NSObject<ESVStackItemType> *)item configAction:(void(^)(ESVStackItemConfig * _Nullable config))configAction;

/// Settle config of item. -setNeedLayout will be called automatically after change config.
/// @param index The index you want to change config of.
/// @param configAction Change config in this block, will be called synchronized. There is no retain circle problem.
- (void)manageConfigOfIndex:(NSUInteger)index configAction:(void(^)(ESVStackItemConfig * _Nullable config))configAction;

/// Get config of item. You must call -setNeedLayout by yourself to layout again.
/// @param item The item.
- (nullable ESVStackItemConfig *)configOfItem:(NSObject<ESVStackItemType> *)item;

/// Get config of index. You must call -setNeedLayout by yourself to layout again.
/// @param index The index of config.
- (nullable ESVStackItemConfig *)configOfIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
