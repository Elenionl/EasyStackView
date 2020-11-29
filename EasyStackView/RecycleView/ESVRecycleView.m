//
//  ESVRecycleView.m
//  EasyStackView
//
//  Created by Elenion on 2020/7/21.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVRecycleView.h"
#import "ESVStackItemConfig.h"
#import "UIView+ESV.h"
#import "ESVCalculator.h"
#import "ESVCoupleSet.h"
#import "ESVRecyclableModel.h"
#import "ESVRecycleManager.h"
#import "ESVRecycleCellType.h"

@interface ESVRecycleView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSObject<ESVStackItemType> *> *privateArrangedItems;

@property (nonatomic, strong) NSMutableArray<__kindof ESVStackItemConfig *> *arrangedConfigs;

@property (nonatomic, assign) CGSize preferredSizeCache;

@property (nonatomic, assign) BOOL dirty;

@property (nonatomic, strong) ESVCoupleSet<NSObject<ESVRecyclableModelType> *, __kindof UIView<ESVRecycleCellType> *> *displayingItem;

@property (nonatomic, strong) ESVRecycleManager<__kindof UIView<ESVRecycleCellType> *> *recycleManager;

@end

@implementation ESVRecycleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _recycleManager = ESVRecycleManager.new;
        _flexDirection = ESVDirectionColumn;
        _alignItems = ESVAlignCenter;
        _justifyContent = ESVJustifyCenter;
        _dirty = true;
        _preferredSizeCache = CGSizeZero;
        _arrangedConfigs = NSMutableArray.new;
        _privateArrangedItems = NSMutableArray.new;
        _displayingItem = ESVCoupleSet.new;
        _padding = UIEdgeInsetsZero;
        [super setDelegate:self];
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

@synthesize padding = _padding;

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
    for (NSObject<ESVStackItemType> *item in self.privateArrangedItems) {
        if ([item isKindOfClass:UIView.class]) {
            [managedViews addObject:(UIView *)item];
        } else if ([item conformsToProtocol:@protocol(ESVItemManageType)]) {
            [managedViews addObjectsFromArray:[((id<ESVItemManageType>)item) managedViews]];
        }
    }
    return managedViews;
}

- (void)setArrangedItems:(NSArray<NSObject<ESVStackItemType> *> *)items {
    [self deleteAllArrangedItems];
    [self addArrangedItems:items];
}

- (void)addArrangedRecycableItems:(NSArray<NSObject<ESVRecyclableModelType> *> *)items {
    [self addArrangedItems:items];
}

- (void)addArrangedItems:(NSArray<NSObject<ESVStackItemType> *> *)items {
    for (NSObject<ESVStackItemType> *item in items) {
        [self addArrangedItem:item];
    }
}

- (void)addArrangedRecycableItem:(NSObject<ESVRecyclableModelType> *)item {
    [self addArrangedItem:item];
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

- (void)insertArrangedRecycableItem:(NSObject<ESVRecyclableModelType> *)item atIndex:(NSUInteger)index {
    [self insertArrangedItem:item atIndex:index];
}

- (void)insertArrangedItem:(ESVRecyclableModel *)item atIndex:(NSUInteger)index {
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

- (void)deleteAllArrangedItems {
    for (ESVRecyclableModel *item in self.privateArrangedItems) {
        [item esv_removeFromSuperitem];
    }
    [self.privateArrangedItems removeAllObjects];
    [self.arrangedConfigs removeAllObjects];
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

- (ESVStackItemConfig *)configOfItem:(ESVRecyclableModel *)item {
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

- (void)manageConfigOfItem:(ESVRecyclableModel *)item configAction:(void (^)(ESVStackItemConfig * _Nullable))configAction {
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
        [self applyItemFrame];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];
    [self markAsDirty];
}

- (void)applyItemFrame {
    for (ESVStackItemConfig *config in self.arrangedConfigs) {
        config.item.frame = config.cacheFrame;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self render];
    [self updateHotDisplay];
}

- (NSSet<ESVRecyclableModel *> *)getHotModels {
    NSMutableSet<ESVRecyclableModel *> *hotModels = NSMutableSet.new;
    CGPoint offset = self.contentOffset;
    CGSize contentSize = self.bounds.size;
    CGFloat hotOffset = 50;
    CGRect hotFrame = CGRectMake(offset.x - hotOffset, offset.y - hotOffset, contentSize.width + 2 * hotOffset, contentSize.height + 2 * hotOffset);
    for (ESVRecyclableModel *model in self.privateArrangedItems) {
        if (![model conformsToProtocol:@protocol(ESVRecyclableModelType)]) {
            continue;
        }
        if (CGRectIntersectsRect(hotFrame, model.frame)) {
            [hotModels addObject:model];
        }
    }
    return hotModels;
}

- (void)updateHotDisplay {
    NSSet<NSObject<ESVRecyclableModelType> *> *models = [self getHotModels];
    NSMutableSet<NSObject<ESVRecyclableModelType> *> *needRemove = [NSMutableSet setWithArray:self.displayingItem.allKeys];
    [needRemove minusSet:models];
    [self removeDisplayOfModels:needRemove];
    NSMutableSet<ESVRecyclableModel *> *needAdd = models.mutableCopy;
    [needAdd minusSet:[NSSet setWithArray:self.displayingItem.allKeys]];
    [self addDisplayOfModels:needAdd];
    [self.displayingItem forEachAction:^(NSObject<ESVRecyclableModelType> * _Nonnull key, __kindof UIView<ESVRecycleCellType> * _Nonnull object) {
        object.frame = key.frame;
    }];
}

- (void)removeDisplayOfModels:(NSSet<NSObject<ESVRecyclableModelType> *> *)models {
    for (ESVRecyclableModel *model in models) {
        if (!model.identifier) {
            continue;
        }
        __auto_type display = [self.displayingItem objectForKey:model];
        [self.displayingItem deleteKey:model];
        [display removeFromSuperview];
        [display prepareForReuse];
        [self.recycleManager storeItem:display forIdentifier:model.identifier];
    }
}

- (void)addDisplayOfModels:(NSSet<ESVRecyclableModel *> *)models {
    for (ESVRecyclableModel *model in models) {
        if (!model.identifier) {
            continue;
        }
        __auto_type view = [self.recycleManager getItemWithIdentifier:model.identifier];
        view.frame = model.frame;
        [view configWithModel:model index:[self.privateArrangedItems indexOfObject:model]];
        [self addSubview:view];
        [self.displayingItem setObject:view forKey:model];
    }
}

- (void)registerGenerator:(UIView<ESVRecycleCellType> * _Nonnull (^)(void))generator forIdentifier:(NSString *)identifier {
    [self.recycleManager registerGenerator:generator forIdentifier:identifier];
}

@end
