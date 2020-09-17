//
//  ESVRecycleManager.m
//  EasyStackView
//
//  Created by Elenion on 2020/8/26.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVRecycleManager.h"

@interface ESVRecycleManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id(^)(void)> *generators;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray *> *caches;

@end

@implementation ESVRecycleManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _generators = NSMutableDictionary.new;
        _caches = NSMutableDictionary.new;
    }
    return self;
}

- (void)registerGenerator:(id  _Nonnull (^)(void))generator forIdentifier:(NSString *)identifier {
    if (!identifier) {
        return;
    }
    [self.generators setObject:generator forKey:identifier];
    [self.caches setObject:NSMutableArray.new forKey:identifier];
}

- (void)storeItem:(id)item forIdentifier:(NSString *)identifier {
    if (!identifier) {
        return;
    }
    if (!item) {
        return;
    }
    NSMutableArray *cache = [self.caches objectForKey:identifier];
    [cache addObject:item];
}

- (id)getItemWithIdentifier:(NSString *)identifier {
    if (!identifier) {
        return nil;
    }
    NSMutableArray *cache = [self.caches objectForKey:identifier];
    if (!cache) {
        return nil;
    }
    if (cache.count) {
        id object = cache.lastObject;
        [cache removeLastObject];
        return object;
    }
    __auto_type generator = [self.generators objectForKey:identifier];
    return generator();
}

@end
