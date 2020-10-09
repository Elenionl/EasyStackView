//
//  ESVFlexManageType.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/10.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESVEnum.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ESVFlexManageType <NSObject>

/// Flex direction.
@property (nonatomic, assign) ESVDirection flexDirection;

/// Distribution mode along axis.
@property (nonatomic, assign) ESVJustify justifyContent;

/// Distribution mode cross axis.
@property (nonatomic, assign) ESVAlign alignItems;

/// Minium space between items.
@property (nonatomic, assign) CGFloat spaceBetween;

/// Inner inset between container and its elements
@property (nonatomic, assign) UIEdgeInsets padding;


@end

NS_ASSUME_NONNULL_END
