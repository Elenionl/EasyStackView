//
//  ESVCoupleSet.m
//  EasyStackView
//
//  Created by Elenion on 2020/8/1.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVCoupleSet.h"

@interface ESVCoupleSet ()

@property (nonatomic, strong) NSMutableArray *keyIndex;

@property (nonatomic, strong) NSMutableArray *objectIndex;

@end

@implementation ESVCoupleSet

- (instancetype)init {
    self = [super init];
    if (self) {
        _keyIndex = NSMutableArray.new;
        _objectIndex = NSMutableArray.new;
    }
    return self;
}

- (void)setObject:(id)object forKey:(id)key {
    if (!object || !key) {
        return;
    }
    [self deleteKey:key];
    [self deleteObject:object];
    [self.keyIndex addObject:key];
    [self.objectIndex addObject:object];
}

- (id)objectForKey:(id)key {
    if (!key) {
        return nil;
    }
    NSInteger index = [self.keyIndex indexOfObject:key];
    if (index > self.keyIndex.count) {
        return nil;
    }
    return self.objectIndex[index];
}

- (id)keyForObject:(id)object {
    if (!object) {
        return nil;
    }
    NSInteger index = [self.objectIndex indexOfObject:object];
    if (index > self.objectIndex.count) {
        return nil;
    }
    return self.keyIndex[index];
}

- (void)deleteKey:(id)key {
    if (!key) {
        return;
    }
    NSUInteger keyIndex = [self.keyIndex indexOfObject:key];
    if (keyIndex < self.keyIndex.count) {
        [self.keyIndex removeObjectAtIndex:keyIndex];
        [self.objectIndex removeObjectAtIndex:keyIndex];
    }
}

- (void)deleteObject:(id)object {
    if (!object) {
        return;
    }
    NSUInteger objectIndex = [self.objectIndex indexOfObject:object];
    if (objectIndex < self.objectIndex.count) {
        [self.keyIndex removeObjectAtIndex:objectIndex];
        [self.objectIndex removeObjectAtIndex:objectIndex];
    }
}

- (NSArray *)allKeys {
    __block NSArray *array = nil;
    array = self.keyIndex.copy;
    return array;
}

- (NSArray *)allObjects {
    __block NSArray *array = nil;
    array = self.objectIndex.copy;
    return array;
}

- (NSUInteger)count {
    __block NSUInteger count = 0;
    count = self.keyIndex.count;
    return count;
}

- (void)forEachAction:(void (^)(id _Nonnull, id _Nonnull))action {
    if (!action) {
        return;
    }
    for (int i = 0; i < self.keyIndex.count; i++) {
        action(self.keyIndex[i], self.objectIndex[i]);
    }
}

@end
