//
//  ESVRecycleView.h
//  EasyStackView
//
//  Created by Elenion on 2020/7/21.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESVFlexManageType.h"
#import "ESVConfigManageType.h"
#import "ESVRefreshManageType.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ESVStackItemType, ESVRecycleCellType, ESVRecyclableModelType;

@interface ESVRecycleView : UIScrollView <ESVFlexManageType, ESVItemManageType, ESVConfigManageType, ESVRefreshManageType>

- (void)setArrangedItems:(NSArray<NSObject<ESVStackItemType> *> *)items;
- (void)addArrangedItems:(NSArray<NSObject<ESVStackItemType> *> *)items;
- (void)addArrangedItem:(NSObject<ESVStackItemType> *)item;
- (void)deleteArrangedItem:(NSObject<ESVStackItemType> *)item;
- (void)insertArrangedItem:(NSObject<ESVStackItemType> *)item atIndex:(NSUInteger)index;
- (void)deleteAllArrangedItems;

- (void)addArrangedRecycableItems:(NSArray<NSObject<ESVRecyclableModelType> *> *)items;
- (void)addArrangedRecycableItem:(NSObject<ESVRecyclableModelType> *)item;
- (void)insertArrangedRecycableItem:(NSObject<ESVRecyclableModelType> *)item atIndex:(NSUInteger)index;

- (ESVStackItemConfig *)configOfItem:(NSObject<ESVStackItemType> *)item;

- (void)manageConfigOfItem:(NSObject<ESVStackItemType> *)item configAction:(void (^)(ESVStackItemConfig * _Nullable))configAction;

- (void)registerGenerator:(UIView<ESVRecycleCellType> *(^)(void))generator forIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
