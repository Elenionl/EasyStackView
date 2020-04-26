//
//  ESVFrameUtil.m
//  EasyStackView
//
//  Created by Elenion on 2020/4/7.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVFrameUtil.h"

@implementation ESVFrameUtil

+ (CGRect)flippedOfRect:(CGRect)rect {
    return CGRectMake(rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
}

+ (CGRect)transformedWithDirection:(UILayoutConstraintAxis)direction ofRect:(CGRect)rect {
    switch (direction) {
        case UILayoutConstraintAxisHorizontal:
            return rect;
        case UILayoutConstraintAxisVertical:
            return [self flippedOfRect:rect];
    }
}

+ (CGSize)flippedOfSize:(CGSize)size {
    return CGSizeMake(size.height, size.width);
}

+ (CGSize)transformedWithDirection:(UILayoutConstraintAxis)direction ofSize:(CGSize)size {
    switch (direction) {
        case UILayoutConstraintAxisHorizontal:
            return size;
        case UILayoutConstraintAxisVertical:
            return [self flippedOfSize:size];
    }
}

@end
