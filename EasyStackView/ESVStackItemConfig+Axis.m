//
//  ESVStackItemConfig+Axis.m
//  EasyStackView
//
//  Created by Elenion on 2020/4/13.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVStackItemConfig+Axis.h"


@implementation ESVStackItemConfig (Axis)

- (CGFloat)headMarginOfDirection:(UILayoutConstraintAxis)direction {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return self.margin.left;
    } else {
        return self.margin.top;
    }
}

- (CGFloat)tailMarginOfDirection:(UILayoutConstraintAxis)direction {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return self.margin.right;
    } else {
        return self.margin.bottom;
    }
}

- (CGFloat)alignStartMarginOfDirection:(UILayoutConstraintAxis)direction {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return self.margin.top;
    } else {
        return self.margin.left;
    }
}

- (CGFloat)alignEndMarginOfDirection:(UILayoutConstraintAxis)direction {
    if (direction == UILayoutConstraintAxisHorizontal) {
        return self.margin.bottom;
    } else {
        return self.margin.right;
    }
}

@end
