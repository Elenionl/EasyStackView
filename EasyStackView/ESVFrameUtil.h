//
//  ESVFrameUtil.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/7.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESVFrameUtil : NSObject

/// Flip rect's x and y axis.
/// @param rect The rect to flip.
+ (CGRect)flippedOfRect:(CGRect)rect;

/// Flip the rect if needed according to direction, make sure axis is horizontal for the convience of layout.
/// @param direction Direction
/// @param rect Rect to flip.
+ (CGRect)transformedWithDirection:(UILayoutConstraintAxis)direction ofRect:(CGRect)rect;

/// Flip size's x and y axis.
/// @param size The size to flip.
+ (CGSize)flippedOfSize:(CGSize)size;

/// Flip the size if needed according to direction, make sure axis is horizontal for the convience of layout.
/// @param direction Direction
/// @param size Size to flip.
+ (CGSize)transformedWithDirection:(UILayoutConstraintAxis)direction ofSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
