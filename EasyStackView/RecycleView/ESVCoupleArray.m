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

@property (readonly) dispatch_queue_t queue;

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

- (NSUInteger)count {
    __block NSUInteger count = 0;
    dispatch_sync(self.queue, ^{
        count = self.keyIndex.count;
    });
    return count;
}

- (dispatch_queue_t)queue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.easyStackView.coupleSet.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

- (void)setObject:(id)object forKey:(id)key {
    if (!object || !key) {
        return;
    }
    [self deleteKey:key];
    [self deleteObject:object];
    dispatch_barrier_async(self.queue, ^{
        [self.keyIndex addObject:key];
        [self.objectIndex addObject:object];
    });
}

- (id)objectForKey:(id)key {
    if (!key) {
        return nil;
    }
    __block id object = nil;
    dispatch_sync(self.queue, ^{
        NSInteger index = [self.keyIndex indexOfObject:key];
        if (index > self.keyIndex.count) {
            return;
        }
        object = self.objectIndex[index];
    });
    return object;
}

- (id)keyForObject:(id)object {
    if (!object) {
        return nil;
    }
    __block id key = nil;
    dispatch_sync(self.queue, ^{
        NSInteger index = [self.objectIndex indexOfObject:object];
        if (index > self.objectIndex.count) {
            return;
        }
        key = self.keyIndex[index];
    });
    return key;
}

- (void)deleteKey:(id)key {
    if (!key) {
        return;
    }
    dispatch_barrier_async(self.queue, ^{
        NSUInteger keyIndex = [self.keyIndex indexOfObject:key];
        if (keyIndex < self.keyIndex.count) {
            [self.keyIndex removeObjectAtIndex:keyIndex];
            [self.objectIndex removeObjectAtIndex:keyIndex];
        }
    });
}

- (void)deleteObject:(id)object {
    if (!object) {
        return;
    }
    dispatch_barrier_async(self.queue, ^{
        NSUInteger objectIndex = [self.objectIndex indexOfObject:object];
        if (objectIndex < self.objectIndex.count) {
            [self.keyIndex removeObjectAtIndex:objectIndex];
            [self.objectIndex removeObjectAtIndex:objectIndex];
        }
    });
}

- (NSArray *)allKeys {
    __block NSArray *array = nil;
    dispatch_sync(self.queue, ^{
        array = self.keyIndex.copy;
    });
    return array;
}

- (NSArray *)allObjects {
    __block NSArray *array = nil;
    dispatch_sync(self.queue, ^{
        array = self.objectIndex.copy;
    });
    return array;
}

@end
