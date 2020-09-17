//
//  ESVRecyclableModel.m
//  EasyStackView
//
//  Created by Elenion on 2020/7/29.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import "ESVRecyclableModel.h"

@interface ESVRecyclableModel ()

@end

@implementation ESVRecyclableModel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (instancetype)init {
    self = [self initWithFrame:CGRectNull];
    return self;
}

#pragma mark - ESVStackItemType

@synthesize frame = _frame;

- (CGRect)bounds {
    CGRect bounds = self.frame;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    return bounds;
}

- (void)esv_removeFromSuperitem {
    
}

- (void)setNeedsLayout {
    
}


- (void)setFrame:(CGRect)frame {
    if (!CGRectEqualToRect(frame, _frame)) {
        _frame = frame;
    }
}

@synthesize identifier = _identifier;

@end
