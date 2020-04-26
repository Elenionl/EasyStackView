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

- (void)markAsDirty;

- (void)render;

- (void)applyItemFrame;

@property (readonly) CGSize preferedSize;

@end

NS_ASSUME_NONNULL_END
