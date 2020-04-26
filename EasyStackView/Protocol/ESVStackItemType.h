//
//  ESVStackItemType.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/15.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// An abstract for item displayed in stack view, maybe a UIView object or even an abstract holder of views.
@protocol ESVStackItemType <NSObject>

@property (readonly, nonatomic) CGRect bounds;
@property (nonatomic) CGRect frame;
- (void)setNeedsLayout;

- (void)esv_removeFromSuperitem;

@end

NS_ASSUME_NONNULL_END
