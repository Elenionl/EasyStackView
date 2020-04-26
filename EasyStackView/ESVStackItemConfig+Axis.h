//
//  ESVStackItemConfig+Axis.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/13.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVStackItemConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESVStackItemConfig (Axis)

- (CGFloat)headMarginOfDirection:(UILayoutConstraintAxis)direction;

- (CGFloat)tailMarginOfDirection:(UILayoutConstraintAxis)direction;

- (CGFloat)alignStartMarginOfDirection:(UILayoutConstraintAxis)direction;

- (CGFloat)alignEndMarginOfDirection:(UILayoutConstraintAxis)direction;

@end

NS_ASSUME_NONNULL_END
