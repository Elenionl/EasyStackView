//
//  ESVScrollView.m
//  EasyStackView
//
//  Created by Elenion on 2020/4/21.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVScrollView.h"
#import "ESVStackItemConfig.h"
#import "ESVFrameUtil.h"
#import "ESVCalculator.h"
#import "UIView+ESV.h"
#import "ESVStackPlaceHolder.h"

@interface ESVScrollView ()

@property (nonatomic, strong) NSMutableArray<NSObject<ESVStackItemType> *> *privateArrangedItems;
@property (nonatomic, strong) NSMutableArray<__kindof ESVStackItemConfig *> *arrangedConfigs;

@property (nonatomic, assign) CGSize preferredSizeCache;

@property (nonatomic, assign) BOOL dirty;

@end

@implementation ESVScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _flexDirection = ESVDirectionColumn;
        _alignItems = ESVAlignCenter;
        _justifyContent = ESVJustifyCenter;
        _dirty = true;
        _preferredSizeCache = CGSizeZero;
        _arrangedConfigs = NSMutableArray.new;
        _privateArrangedItems = NSMutableArray.new;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(frame, self.frame)) {
        [self markAsDirty];
        [super setFrame:frame];
    }
}

#pragma mark - ESVFlexManageType

@synthesize alignItems = _alignItems;

@synthesize flexDirection = _flexDirection;

@synthesize justifyContent = _justifyContent;

@synthesize spaceBetween = _spaceBetween;

- (void)setAlignItems:(ESVAlign)alignItems {
    if (alignItems != _alignItems) {
        _alignItems = alignItems;
        [self markAsDirty];
    }
}

- (void)setFlexDirection:(ESVDirection)flexDirection {
    if (flexDirection != _flexDirection) {
        _flexDirection = flexDirection;
        [self markAsDirty];
    }
}

- (void)setJustifyContent:(ESVJustify)justifyContent {
    if (justifyContent != _justifyContent) {
        _justifyContent = justifyContent;
        [self markAsDirty];
    }
}

- (void)setSpaceBetween:(CGFloat)spaceBetween {
    if (spaceBetween != _spaceBetween) {
        _spaceBetween = spaceBetween;
        [self markAsDirty];
    }
}

#pragma mark - ESVViewManageType

@synthesize superItem = _superItem;

- (NSArray<UIView *> *)managedViews {
    NSMutableArray<UIView *> *managedViews = NSMutableArray.new;
    for (NSObject<ESVStackItemType> *item in self.privateArrangedItems) {
        if ([item isKindOfClass:UIView.class]) {
            [managedViews addObject:(UIView *)item];
        } else if ([item conformsToProtocol:@protocol(ESVItemManageType)]) {
            [managedViews addObjectsFromArray:[((id<ESVItemManageType>)item) managedViews]];
        }
    }
    return managedViews;
}

- (void)addArrangedItem:(NSObject<ESVStackItemType> *)item {
    if (!item) {
        return;
    }
    if ([self.privateArrangedItems containsObject:item]) {
        return;
    }
    [self.privateArrangedItems addObject:item];
    if ([item conformsToProtocol:@protocol(ESVItemManageType)]) {
        ((id<ESVItemManageType>)item).superItem = self;
    }
    [self.arrangedConfigs addObject:[[ESVStackItemConfig alloc] initWithItem:item]];
    [self markAsDirty];
}

- (void)deleteArrangedItem:(NSObject<ESVStackItemType> *)item {
    if (!item) {
        return;
    }
    if (![self.privateArrangedItems containsObject:item]) {
        return;
    }
    NSUInteger index = [self.privateArrangedItems indexOfObject:item];
    [self.privateArrangedItems removeObjectAtIndex:index];
    [item esv_removeFromSuperitem];
    [self.arrangedConfigs removeObjectAtIndex:index];
    [self markAsDirty];
}

- (void)insertArrangedItem:(NSObject<ESVStackItemType> *)item atIndex:(NSUInteger)index {
    if (!item) {
        return;
    }
    if ([self.privateArrangedItems containsObject:item]) {
        return;
    }
    [self.privateArrangedItems insertObject:item atIndex:index];
    if ([item conformsToProtocol:@protocol(ESVItemManageType)]) {
        ((id<ESVItemManageType>)item).superItem = self;
    }
    [self.arrangedConfigs insertObject:[[ESVStackItemConfig alloc] initWithItem:item] atIndex:index];
    [self markAsDirty];
}

- (NSArray<NSObject<ESVStackItemType> *> *)arrangedItems {
    return self.privateArrangedItems;
}

#pragma mark - ESVConfigManageType

- (nullable ESVStackItemConfig *)configOfIndex:(NSUInteger)index {
    if (index < self.arrangedConfigs.count && index >= 0) {
        return self.arrangedConfigs[index];
    } else {
        return nil;
    }
}

- (ESVStackItemConfig *)configOfItem:(NSObject<ESVStackItemType> *)item {
    if (!item) {
        return nil;
    }
    NSUInteger index = [self.privateArrangedItems indexOfObject:item];
    return [self configOfIndex:index];
}

- (void)manageConfigOfIndex:(NSUInteger)index configAction:(nonnull void (^)(ESVStackItemConfig * _Nullable))configAction {
    ESVStackItemConfig *config = [self configOfIndex:index];
    if (configAction) {
        configAction(config);
        [self markAsDirty];
    }
}

- (void)manageConfigOfItem:(NSObject<ESVStackItemType> *)item configAction:(void (^)(ESVStackItemConfig * _Nullable))configAction {
    if (!item) {
        return;
    }
    NSUInteger index = [self.privateArrangedItems indexOfObject:item];
    [self manageConfigOfIndex:index configAction:configAction];
}


#pragma mark - ESVRefreshManageType

- (void)markAsDirty {
    self.dirty = true;
    self.preferredSizeCache = CGSizeZero;
    for (ESVStackItemConfig *config in self.arrangedConfigs) {
        config.cacheTransformedFrame = CGRectNull;
    }
    [self setNeedsLayout];
}

- (CGSize)preferedSize {
    [self render];
    return self.preferredSizeCache;
}

- (void)render {
    for (UIView *view in self.managedViews) {
        if (![self.subviews containsObject:view]) {
            [self addSubview:view];
        }
    }
    for (NSObject<ESVStackItemType> * item in self.privateArrangedItems) {
        if ([item conformsToProtocol:@protocol(ESVRefreshManageType)]) {
            [((id<ESVRefreshManageType>) item) render];
        }
    }
    if (self.dirty) {
        CGSize boundsSize = self.bounds.size;
        UIEdgeInsets insets;
        if (@available(iOS 11.0, *)) {
            insets = self.adjustedContentInset;
        } else {
            insets = self.contentInset;
        }
        CGSize current = CGSizeMake(boundsSize.width - insets.left - insets.right, boundsSize.height - insets.top - insets.bottom);
        self.preferredSizeCache = [ESVCalculator scrollViewLayoutWithSize:current flexConfig:self arrangedConfigs:self.arrangedConfigs];
        CGSize result = CGSizeMake(MAX(current.width, self.preferredSizeCache.width), MAX(current.height, self.preferredSizeCache.height));
        self.contentSize = result;
        self.dirty = false;
    }
}

- (void)applyItemFrame {
    for (ESVStackItemConfig *config in self.arrangedConfigs) {
        config.item.frame = config.cacheFrame;
        if ([config.item conformsToProtocol:@protocol(ESVRefreshManageType)]) {
            NSObject<ESVRefreshManageType> *item = (NSObject<ESVRefreshManageType> *)config.item;
            [item applyItemFrame];
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self render];
    [self applyItemFrame];
}

@end
