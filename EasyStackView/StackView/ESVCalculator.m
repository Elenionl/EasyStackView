//
//  ESVCalculator.m
//  EasyStackView
//
//  Created by Elenion on 2020/4/13.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVCalculator.h"
#import "ESVStackItemConfig.h"
#import "ESVFrameUtil.h"

CGFloat headOffsetEdgeInsetDirection(UIEdgeInsets edgeInset, ESVDirection direction) {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return edgeInset.left;
    } else {
        return edgeInset.top;
    }
}

CGFloat tailOffsetEdgeInsetDirection(UIEdgeInsets edgeInset, ESVDirection direction) {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return edgeInset.right;
    } else {
        return edgeInset.bottom;
    }
}

CGFloat alignStartOffsetEdgeInsetDirection(UIEdgeInsets edgeInset, ESVDirection direction) {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return edgeInset.top;
    } else {
        return edgeInset.left;
    }
}

CGFloat alignEndOffsetEdgeInsetDirection(UIEdgeInsets edgeInset, ESVDirection direction) {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return edgeInset.bottom;
    } else {
        return edgeInset.right;
    }
}

@interface ESVCalculator ()

@end

@implementation ESVCalculator

+ (CGSize)layoutWithSize:(CGSize)size flexConfig:(nonnull id<ESVFlexManageType>)flexConfig arrangedConfigs:(nonnull NSArray<ESVStackItemConfig *> *)arrangedConfigs {
    CGSize transformedSize = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofSize:size];
    NSMutableArray<NSNumber *> *margins = [[NSMutableArray alloc] initWithCapacity:arrangedConfigs.count + 1];
    CGFloat head = headOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection);
    CGFloat tail = tailOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection);
    CGFloat previousTailMargin = head;
    CGFloat total = 0;
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        CGSize transformedSize = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofSize:config.originSize];
        config.cacheTransformedFrame = CGRectMake(0, 0, transformedSize.width, transformedSize.height);
        CGFloat headMargin = headOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection);
        CGFloat currentHead = MAX(previousTailMargin, headMargin);
        if (i != 0) {
            currentHead = MAX(currentHead, flexConfig.spaceBetween);
        }
        [margins addObject:@(currentHead)];
        total += currentHead;
        total += transformedSize.width;
        previousTailMargin = tailOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection);
    }
    CGFloat lastMargin = MAX(previousTailMargin, tail);
    [margins addObject:@(lastMargin)];
    total += lastMargin;
    CGSize result;
    switch (flexConfig.flexDirection) {
        case ESVDirectionRow:
            result = CGSizeMake(total, size.height);
            break;
        case ESVDirectionColumn:
            result = CGSizeMake(size.width, total);
            break;
    }
    CGFloat axisOffset;
    CGFloat space = transformedSize.width - total;
    if (space < 0) {
        space = -[self tryToShrinkViewsTo:-space arrangedConfigs:arrangedConfigs];
    } else if (space > 0) {
        space = [self tryToGrowViewsTo:space arrangedConfigs:arrangedConfigs];
    }
    switch (flexConfig.justifyContent) {
        case ESVJustifyFlexStart:
            axisOffset = 0;
            break;
        case ESVJustifyFlexEnd:
            axisOffset = space;
            break;
        case ESVJustifyCenter:
            axisOffset = (space) / 2;
            break;
        case ESVJustifySpaceBetween:
            axisOffset = 0;
            [self updateBetweenMargins:margins space:space];
            break;
        case ESVJustifySpaceAround:
            axisOffset = 0;
            [self updateAroundMargins:margins space:space];
            break;
    }
    total = axisOffset;
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        CGRect itemTransformedRect = config.cacheTransformedFrame;
        CGFloat currentHead = margins[i].doubleValue;
        total += currentHead;
        CGFloat y;
        CGFloat height = itemTransformedRect.size.height;
        ESVAlign align;
        if (config.alignSelfOn) {
            align = config.alignSelf;
        } else {
            align = flexConfig.alignItems;
        }
        CGFloat start = MAX(alignStartOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection), alignStartOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection));
        CGFloat end = MAX(alignEndOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection), alignEndOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection));
        switch (align) {
            case ESVAlignFlexStart:
                y = start;
                break;
            case ESVAlignFlexEnd:
                y = transformedSize.height - itemTransformedRect.size.height - end;
                break;
            case ESVAlignCenter:
                y = (transformedSize.height - itemTransformedRect.size.height) / 2;
                break;
            case ESVAlignStretch:
                y = start;
                height = transformedSize.height - start - end;
                break;
        }
        CGRect transformedFrame = CGRectMake(total, y, itemTransformedRect.size.width, height);
        config.cacheTransformedFrame = transformedFrame;
        config.cacheFrame = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofRect:transformedFrame];
        total += transformedFrame.size.width;
    }
    return result;
}

+ (CGSize)scrollViewLayoutWithSize:(CGSize)size flexConfig:(id<ESVFlexManageType>)flexConfig arrangedConfigs:(NSArray <ESVStackItemConfig *>*)arrangedConfigs {
    CGSize transformedSize = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofSize:size];
    NSMutableArray<NSNumber *> *margins = [[NSMutableArray alloc] initWithCapacity:arrangedConfigs.count + 1];
    CGFloat head = headOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection);
    CGFloat tail = tailOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection);
    CGFloat previousTailMargin = head;
    CGFloat total = 0;
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        CGSize transformedSize = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofSize:config.originSize];
        config.cacheTransformedFrame = CGRectMake(0, 0, transformedSize.width, transformedSize.height);
        CGFloat headMargin = headOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection);
        CGFloat currentHead = MAX(previousTailMargin, headMargin);
        if (i != 0) {
            currentHead = MAX(currentHead, flexConfig.spaceBetween);
        }
        [margins addObject:@(currentHead)];
        total += currentHead;
        total += transformedSize.width;
        previousTailMargin = tailOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection);
    }
    CGFloat lastMargin = MAX(previousTailMargin, tail);
    [margins addObject:@(lastMargin)];
    total += lastMargin;
    CGSize result;
    switch (flexConfig.flexDirection) {
        case ESVDirectionRow:
            result = CGSizeMake(total, size.height);
            break;
        case ESVDirectionColumn:
            result = CGSizeMake(size.width, total);
            break;
    }
    CGFloat axisOffset;
    CGFloat space = transformedSize.width - total;
    if (space > 0) {
        space = [self tryToGrowViewsTo:space arrangedConfigs:arrangedConfigs];
    } else {
        space = 0;
    }
    switch (flexConfig.justifyContent) {
        case ESVJustifyFlexStart:
            axisOffset = 0;
            break;
        case ESVJustifyFlexEnd:
            axisOffset = space;
            break;
        case ESVJustifyCenter:
            axisOffset = (space) / 2;
            break;
        case ESVJustifySpaceBetween:
            axisOffset = 0;
            if (total < transformedSize.width) {
                [self updateBetweenMargins:margins space:space];
            }
            break;
        case ESVJustifySpaceAround:
            axisOffset = 0;
            if (total < transformedSize.width) {
                [self updateAroundMargins:margins space:space];
            }
            break;
    }
    total = axisOffset;
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        CGRect itemTransformedRect = config.cacheTransformedFrame;
        CGFloat currentHead = margins[i].doubleValue;
        total += currentHead;
        CGFloat y;
        CGFloat height = itemTransformedRect.size.height;
        ESVAlign align;
        if (config.alignSelfOn) {
            align = config.alignSelf;
        } else {
            align = flexConfig.alignItems;
        }
        CGFloat start = MAX(alignStartOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection), alignStartOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection));
        CGFloat end = MAX(alignEndOffsetEdgeInsetDirection(config.margin, flexConfig.flexDirection), alignEndOffsetEdgeInsetDirection(flexConfig.padding, flexConfig.flexDirection));
        switch (align) {
            case ESVAlignFlexStart:
                y = start;
                break;
            case ESVAlignFlexEnd:
                y = transformedSize.height - itemTransformedRect.size.height - end;
                break;
            case ESVAlignCenter:
                y = (transformedSize.height - itemTransformedRect.size.height) / 2;
                break;
            case ESVAlignStretch:
                y = start;
                height = transformedSize.height - start - end;
                break;
        }
        CGRect transformedFrame = CGRectMake(total, y, itemTransformedRect.size.width, height);
        config.cacheTransformedFrame = transformedFrame;
        config.cacheFrame = [ESVFrameUtil transformedWithDirection:flexConfig.flexDirection ofRect:transformedFrame];
        total += transformedFrame.size.width;
    }
    return result;
}

+ (CGFloat)tryToGrowViewsTo:(CGFloat)space arrangedConfigs:(NSArray <ESVStackItemConfig *>*)arrangedConfigs {
    CGFloat total = 0;
    NSMutableArray<ESVStackItemConfig *> *growthable = [[NSMutableArray alloc] initWithCapacity:arrangedConfigs.count];
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        if (config.growth) {
            total += config.cacheTransformedFrame.size.width;
            [growthable addObject:config];
        }
    }
    if (!growthable.count) {
        return space;
    }
    if (total == 0) {
        CGFloat add = space / growthable.count;
        for (ESVStackItemConfig *config in growthable) {
            CGRect rect = config.cacheTransformedFrame;
            rect.size.width += add;
            config.cacheTransformedFrame = rect;
        }
    }
    CGFloat ratio = space / total;
    for (ESVStackItemConfig *config in growthable) {
        CGRect rect = config.cacheTransformedFrame;
        rect.size.width += rect.size.width * ratio;
        config.cacheTransformedFrame = rect;
    }
    return 0;
}

+ (CGFloat)tryToShrinkViewsTo:(CGFloat)space arrangedConfigs:(NSArray <ESVStackItemConfig *>*)arrangedConfigs {
    CGFloat total = 0;
    NSMutableArray<ESVStackItemConfig *> *shrinkable = [[NSMutableArray alloc] initWithCapacity:arrangedConfigs.count];
    for (int i = 0; i < arrangedConfigs.count; i++) {
        ESVStackItemConfig *config = arrangedConfigs[i];
        if (config.shrink) {
            total += config.cacheTransformedFrame.size.width;
            [shrinkable addObject:config];
        }
    }
    if (!shrinkable.count) {
        return space;
    }
    if (total == 0) {
        return space;
    }
    CGFloat ratio = space / total;
    if (ratio > 1) {
        ratio = 1;
    }
    for (ESVStackItemConfig *config in shrinkable) {
        CGRect rect = config.cacheTransformedFrame;
        CGFloat shrink = rect.size.width * ratio;
        space -= shrink;
        rect.size.width -= shrink;
        config.cacheTransformedFrame = rect;
    }
    return space;
}

+ (void)updateAroundMargins:(NSMutableArray<NSNumber *> *)margins space:(CGFloat)space {
    NSParameterAssert(space >= 0);
    CGFloat start = CGFLOAT_MAX;
    for (NSNumber *number in margins) {
        CGFloat value = number.doubleValue;
        if (value < start) {
            start = value;
        }
        if (value == 0) {
            break;
        }
    }
    while (space > 0.5) {
        CGFloat spaceItem = space / margins.count;
        start += spaceItem;
        NSArray<NSNumber *> *marginsCopy = margins.copy;
        for (int i = 0; i < margins.count; i++) {
            CGFloat value = marginsCopy[i].doubleValue;
            if (value < start) {
                space -= (start - value);
                value = start;
                margins[i] = @(value);
            }
        }
    }
}

+ (void)updateBetweenMargins:(NSMutableArray<NSNumber *> *)margins space:(CGFloat)space {
    if (space < 0) {
        return;
    }
    if (margins.count < 3) {
        return;
    }
    CGFloat start = CGFLOAT_MAX;
    for (int i = 1; i < margins.count - 1; i++) {
        CGFloat value = margins[i].doubleValue;
        if (value < start) {
            start = value;
        }
        if (value == 0) {
            break;
        }
    }
    while (space > 0.5) {
        CGFloat spaceItem = space / (margins.count - 2);
        start += spaceItem;
        NSArray<NSNumber *> *marginsCopy = margins.copy;
        for (int i = 1; i < margins.count - 1; i++) {
            CGFloat value = marginsCopy[i].doubleValue;
            if (value < start) {
                space -= (start - value);
                value = start;
                margins[i] = @(value);
            }
        }
    }
}

@end
