//
//  ESVRefreshManageType.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/13.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ESVRefreshManageType <NSObject>

@property (readonly) BOOL dirty;

/// Mark this item as dirty, it layout soon after.
- (void)markAsDirty;

/// Try to all layout subviews if self or arranged items are dirty.
- (void)render;

/// This should not be called mannually.
- (void)applyItemFrame;

/// The preffered size of this view, which can properly hold all its arranged items.
@property (readonly) CGSize preferedSize;

@end

NS_ASSUME_NONNULL_END
