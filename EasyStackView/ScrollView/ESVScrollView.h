//
//  ESVScrollView.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/21.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESVFlexManageType.h"
#import "ESVConfigManageType.h"
#import "ESVRefreshManageType.h"

NS_ASSUME_NONNULL_BEGIN

@interface ESVScrollView : UIScrollView <ESVFlexManageType, ESVItemManageType, ESVConfigManageType, ESVRefreshManageType>

@end

NS_ASSUME_NONNULL_END
