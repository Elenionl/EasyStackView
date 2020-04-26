//
//  ESVEnum.h
//  EasyStackView
//
//  Created by Elenion on 2020/4/9.
//  Copyright © 2020 Elenion. All rights reserved.
//

#ifndef ESVEnum_h
#define ESVEnum_h

typedef NS_ENUM(NSUInteger, ESVDirection) {
    ESVDirectionRow,
    ESVDirectionColumn,
};

typedef NS_ENUM(NSUInteger, ESVJustify) {
    ESVJustifyFlexStart,
    ESVJustifyFlexEnd,
    ESVJustifyCenter,
    ESVJustifySpaceBetween,
    ESVJustifySpaceAround,
};

typedef NS_ENUM(NSUInteger, ESVAlign) {
    ESVAlignFlexStart,
    ESVAlignFlexEnd,
    ESVAlignCenter,
    ESVAlignStretch,
};

#endif /* ESVEnum_h */
