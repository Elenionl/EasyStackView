//
//  ESVRecycleCell.h
//  EasyStackView
//
//  Created by Elenion on 2020/9/17.
//  Copyright © 2020 Elenion. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ESVRecyclableModelType;

@protocol ESVRecycleCellType <NSObject>

- (void)prepareForReuse;

- (void)configWithModel:(NSObject<ESVRecyclableModelType> *)model index:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
