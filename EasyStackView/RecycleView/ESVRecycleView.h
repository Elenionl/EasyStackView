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

@protocol ESVRecyclableModelType, ESVRecycleCellType;

@interface ESVRecycleView : UIScrollView <ESVFlexManageType, ESVItemManageType, ESVConfigManageType, ESVRefreshManageType>

- (void)setArrangedItems:(NSArray<NSObject<ESVRecyclableModelType> *> *)items;
- (void)addArrangedItems:(NSArray<NSObject<ESVRecyclableModelType> *> *)items;
- (void)addArrangedItem:(NSObject<ESVRecyclableModelType> *)item;
- (void)deleteArrangedItem:(NSObject<ESVRecyclableModelType> *)item;
- (void)insertArrangedItem:(NSObject<ESVRecyclableModelType> *)item atIndex:(NSUInteger)index;
- (void)deleteAllArrangedItems;

- (ESVStackItemConfig *)configOfItem:(NSObject<ESVRecyclableModelType> *)item;

- (void)manageConfigOfItem:(NSObject<ESVRecyclableModelType> *)item configAction:(void (^)(ESVStackItemConfig * _Nullable))configAction;

- (void)registerGenerator:(UIView<ESVRecycleCellType> *(^)(void))generator forIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
