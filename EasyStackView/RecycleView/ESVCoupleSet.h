//
//  ESVCoupleSet.h
//  EasyStackView
//
//  Created by Elenion on 2020/8/1.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESVCoupleSet<KeyType, ObjectType> : NSObject

- (void)setObject:(ObjectType)object forKey:(KeyType)key;

- (nullable ObjectType)objectForKey:(KeyType)key;

- (nullable KeyType)keyForObject:(ObjectType)object;

- (void)deleteObject:(ObjectType)object;

- (void)deleteKey:(KeyType)key;

- (NSArray<KeyType> *)allKeys;

- (NSArray<ObjectType> *)allObjects;

- (NSUInteger)count;

- (void)forEachAction:(void(^)(KeyType key, ObjectType object))action;

@end

NS_ASSUME_NONNULL_END
