//
// Created by Elenion on 2020/4/2.
// Copyright (c) 2020 Elenion. All rights reserved.
//

#import "ESVStackItemConfig.h"
#import "ESVStackItemType.h"

@interface ESVStackItemConfig ()

@property (nonatomic, strong) NSObject<ESVStackItemType> *item;

@end

@implementation ESVStackItemConfig

- (instancetype)initWithItem:(id<ESVStackItemType>)item {
    self = [super init];
    if (self) {
        _item = item;
        _originSize = item.frame.size;
        _alignSelfOn = false;
        _margin = UIEdgeInsetsZero;
        _shrink = false;
        _growth = false;
    }
    return self;
}

@end
