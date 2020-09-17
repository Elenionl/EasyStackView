//
//  ESVRecyclableModel.h
//  EasyStackView
//
//  Created by Elenion on 2020/7/29.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESVStackItemType.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ESVRecyclableModelType <ESVStackItemType>

@property (nonatomic, copy) NSString *identifier;

@end

@interface ESVRecyclableModel: NSObject <ESVRecyclableModelType>

@end

NS_ASSUME_NONNULL_END
