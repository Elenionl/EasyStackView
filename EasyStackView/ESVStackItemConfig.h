//
// Created by Elenion on 2020/4/2.
// Copyright (c) 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESVEnum.h"

@protocol ESVStackItemType;

@interface ESVStackItemConfig : NSObject

#pragma mark - Cache

/// Frame cache of view. DO NOT change this property value unless you are pretty sure what you are doing.
@property (nonatomic, assign) CGRect cacheTransformedFrame;

@property (nonatomic, assign) CGRect cacheFrame;

#pragma mark - Associate

/// The view this config is associated to.
@property (nonatomic, readonly) NSObject<ESVStackItemType> * item;

#pragma mark - Config

/// Is this view layouted according to alignSelf in this config. Default is false.
@property (nonatomic, assign) BOOL alignSelfOn;

/// Describe how to layout this view in flex layout. Only work when alignSelfOn is true.
@property (nonatomic, assign) ESVAlign alignSelf;

/// Orignal frame of the view. This is the reference size of the view during layout. Default is view's size when added into arranged views array.
@property (nonatomic, assign) CGSize originSize;

/// Minium margin inset of view in four direction. Default is {0, 0, 0, 0,}.
@property (nonatomic, assign) UIEdgeInsets margin;

/// Indicates whether this view will auto stretch when super view is not filled along axis. Default is false.
@property (nonatomic, assign) BOOL growth;

/// Indicates whether this view will auto shrink when super view is too narrow along axis. Default is false.
@property (nonatomic, assign) BOOL shrink;

- (instancetype)initWithItem:(NSObject<ESVStackItemType> *)item;

@end
