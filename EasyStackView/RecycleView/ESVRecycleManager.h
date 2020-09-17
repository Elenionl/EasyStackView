//
//  ESVRecycleManager.h
//  EasyStackView
//
//  Created by Elenion on 2020/8/26.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESVRecycleManager<ObjectType> : NSObject

- (void)registerGenerator:(ObjectType(^)(void))generator forIdentifier:(NSString *)identifier;

- (void)storeItem:(ObjectType)item forIdentifier:(NSString *)identifier;

- (ObjectType)getItemWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
