//
//  ESVItemManageType.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/10.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class UIView;

@protocol ESVStackItemType;

@protocol ESVItemManageType <NSObject>

/// All items arranged in flex layout.
@property (nonatomic, readonly) NSArray<__kindof NSObject<ESVStackItemType> *> *arrangedItems;

/// Add item at the end of arranged subviews.
/// @param item Item to add
- (void)addArrangedItem:(NSObject<ESVStackItemType> *)item;

/// Delete item from arranged subview.
/// @param item Item to delete.
- (void)deleteArrangedItem:(NSObject<ESVStackItemType> *)item;

/// Insert item into arranged subviews.
/// @param item Item to insert.
/// @param index Index to insert.
- (void)insertArrangedItem:(NSObject<ESVStackItemType> *)item atIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSArray<__kindof UIView *> *managedViews;

@property (nonatomic, weak) NSObject<ESVStackItemType> * superItem;
 
@end

NS_ASSUME_NONNULL_END
