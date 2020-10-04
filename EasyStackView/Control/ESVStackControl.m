//
//  ESVControl.m
//  EasyStackView
//
//  Created by Elenion on 2020/7/20.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVStackControl.h"
#import "ESVStackItemConfig.h"
#import "ESVFrameUtil.h"
#import "ESVCalculator.h"
#import "UIView+ESV.h"
#import "ESVStackPlaceHolder.h"
 
@interface ESVStackControl ()

@property (nonatomic, strong) NSMutableArray<NSObject<ESVStackItemType> *> *privateArrangedItems;
@property (nonatomic, strong) NSMutableArray<__kindof ESVStackItemConfig *> *arrangedConfigs;

@property (nonatomic, assign) CGSize preferredSizeCache;

@property (nonatomic, assign) BOOL dirty;

@end

@implementation ESVStackControl

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

#pragma mark - ESVItemManageType

@synthesize superItem = _superItem;

- (NSArray<UIView *> *)managedViews {
    NSMutableArray<UIView *> *managedViews = NSMutableArray.new;
    for (NSObject<ESVStackItemType> * item in self.privateArrangedItems) {
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
    __auto_type managedViews = self.managedViews;
    NSMutableSet<UIView *> *managedViewSet = [NSMutableSet setWithArray:managedViews];
    NSSet<UIView *> *subviewSet = [NSSet setWithArray:self.subviews];
    [managedViewSet minusSet:subviewSet];
    [managedViewSet enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, BOOL * _Nonnull stop) {
        [self addSubview:obj];
    }];
    for (NSObject<ESVStackItemType> * item in self.privateArrangedItems) {
        BOOL isHolder = ![item isKindOfClass:UIView.class];
        BOOL isRefreshable = [item conformsToProtocol:@protocol(ESVRefreshManageType)];
        if (isHolder && isRefreshable) {
            [((id<ESVRefreshManageType>) item) render];
        }
    }
    if (self.dirty) {
        self.preferredSizeCache = [ESVCalculator layoutWithSize:self.bounds.size flexConfig:self arrangedConfigs:self.arrangedConfigs];
        self.dirty = false;
        [self applyItemFrame];
    }
}

- (void)applyItemFrame {
    for (ESVStackItemConfig *config in self.arrangedConfigs) {
        config.item.frame = config.cacheFrame;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self render];
}

@end
