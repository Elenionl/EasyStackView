//
//  ESVStackPlaceHolder.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/15.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESVStackItemType.h"
#import "ESVFlexManageType.h"
#import "ESVConfigManageType.h"
#import "ESVRefreshManageType.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESVStackPlaceHolder : NSObject<ESVStackItemType, ESVFlexManageType, ESVItemManageType, ESVConfigManageType, ESVRefreshManageType>

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
