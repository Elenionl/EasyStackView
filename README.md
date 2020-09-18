# EasyStackView

![version](https://img.shields.io/cocoapods/v/EasyStackView)
![license](https://img.shields.io/github/license/Elenionl/EasyStackView)
![platform](https://img.shields.io/cocoapods/p/EasyStackView)
![Swift](https://img.shields.io/badge/Swfit-●-orange)
![Objecgive-C](https://img.shields.io/badge/Objective--C-●-blue)

## Introduction

This project offer a simple and elegant flex layout implementation for iOS native develop. This project can work with both Swift and Objective-C language.

## **Star** if you like it.

## Integrate with [Cocoapods](https://cocoapods.org)

Use this firm to find `podfile` script for your project.

``` Ruby
    pod 'EasyStackView'
```

## How to use
![Demo1](https://raw.githubusercontent.com/Elenionl/EasyStackView/master/readme_image/WX20200918-003155%402x.png)
![Demo2](https://github.com/Elenionl/EasyStackView/blob/master/readme_image/WX20200918-003244@2x.png?raw=true)
![Demo1](https://github.com/Elenionl/EasyStackView/blob/master/readme_image/WX20200918-003619@2x.png?raw=true)
There are three kinds of flex container right now:
`ESVStackView`
`ESVStackPlaceHolder`
`ESVScrollView`
`ESVRecycleView`

`ESVStackView` is just a simple view will layout its arranged items with flex layout.

`ESVStackPlaceHolder` works just the same as `ESVStackView` but it is not a subclass of `UIView`. It works as an abstract container to laytou its arranged items. You can use it to arrange complex layout without creating too much unnecessary view hierarchy.

*Attention:* `ESVStackPlaceHolder` instance should not be the root of an flex layout tree.

`ESVScrollView` is a Scroll View with flex layout inside.

`ESVRecycleView` is a Scroll View with flex layout inside as long as **item reuse feature**.

``` Swift
let item = ESVStackView()
item.flexDirection = .row
item.alignItems = .flexStart
item.justifyContent = .flexStart
item.spaceBetween = 10
let container = ESVScrollView(frame: CGRect(x: 0, y: 0, width: 300, height:700))
container.flexDirection = .row
item.addArrangedItem(container)
item.manageConfig(of: container) { (config) in
    config?.growth = true
}
item.backgroundColor = UIColor.red
let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
view1.backgroundColor = UIColor.blue
container.addArrangedItem(view1)
container.manageConfig(of: view1) { (config) in
    config?.margin = UIEdgeInsets(top: 100, left: 20, bottom: 20, right: 20)
    config?.shrink = true
    config?.growth = true
}
let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
view2.backgroundColor = UIColor.green
container.addArrangedItem(view2)
container.manageConfig(of: view2) { (config) in
    config?.shrink = true
}
let view3 = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
view3.backgroundColor = UIColor.purple
container.addArrangedItem(view3)
let view4 = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 400))
view4.backgroundColor = UIColor.green
item.addArrangedItem(view4)
```

## Features

---

All containers conform to `ESVFlexManageType` protocol, which gives them layout attributes.

``` Objective-C
@protocol ESVFlexManageType <NSObject>

/// Flex direction.
@property (nonatomic, assign) ESVDirection flexDirection;

/// Distribution mode along axis.
@property (nonatomic, assign) ESVJustify justifyContent;

/// Distribution mode cross axis.
@property (nonatomic, assign) ESVAlign alignItems;

/// Minium space between items.
@property (nonatomic, assign) CGFloat spaceBetween;

@end
```

---

All containers conform to `ESVItemManageType` protocol, which gives them ability to manage items.


``` Objective-C
@protocol ESVItemManageType <NSObject>

/// All items arranged in flex layout.
@property (nonatomic, readonly) NSArray<__kindof NSObject<ESVStackItemType> *> *arrangedItems;

/// Add item at the end of arranged subviews.
/// @param item Item to add
- (void)addArrangedItem:(NSObject<ESVStackItemType> *)item;

/// Delete item from arranged subview.
/// @param item Item to delete.
- (void)deleteArrangedItem:(NSObject<ESVStackItemType> *)item;

/// Insert item into arranged subviews.
/// @param item Item to insert.
/// @param index Index to insert.
- (void)insertArrangedItem:(NSObject<ESVStackItemType> *)item atIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSArray<__kindof UIView *> *managedViews;

@property (nonatomic, weak) NSObject<ESVStackItemType> * superItem;
 
@end
```

*Attention:* Only objects add with function `- (void)addArrangedItem:(NSObject<ESVStackItemType> *)item;` can join flex layout. Views added with `-(void)addSubview:(UIView *)view` will be layouted just the same as in a ordinary view.

---

All containers conform to `ESVRefreshManageType` protocol, which offers some operation about render.

``` Objective-C
@protocol ESVRefreshManageType <NSObject>

@property (readonly) BOOL dirty;

/// Mark this item as dirty, it layout soon after.
- (void)markAsDirty;

/// Try to all layout subviews if self or arranged items are dirty.
- (void)render;

/// This should not be called mannually.
- (void)applyItemFrame;

/// The preffered size of this view, which can properly hold all its arranged items.
@property (readonly) CGSize preferedSize;

@end
```
---

All containers conform to `ESVConfigManageType` protocol, which offers methods to operate arranged item's config.

``` Objective-C

@protocol ESVConfigManageType <ESVItemManageType>

/// Settle config of item. -setNeedLayout will be called automatically after change config.
/// @param item The item you want to change config of.
/// @param configAction Change config in this block, will be called synchronized. There is no retain circle problem.
- (void)manageConfigOfItem:(NSObject<ESVStackItemType> *)item configAction:(void(^)(ESVStackItemConfig * _Nullable config))configAction;

/// Settle config of item. -setNeedLayout will be called automatically after change config.
/// @param index The index you want to change config of.
/// @param configAction Change config in this block, will be called synchronized. There is no retain circle problem.
- (void)manageConfigOfIndex:(NSUInteger)index configAction:(void(^)(ESVStackItemConfig * _Nullable config))configAction;

/// Get config of item. You must call -setNeedLayout by yourself to layout again.
/// @param item The item.
- (nullable ESVStackItemConfig *)configOfItem:(NSObject<ESVStackItemType> *)item;

/// Get config of index. You must call -setNeedLayout by yourself to layout again.
/// @param index The index of config.
- (nullable ESVStackItemConfig *)configOfIndex:(NSUInteger)index;

@end

```

Each arrange item is associated with its `ESVStackItemConfig` config object. You can specify layout attributes for this arranaged item with `ESVStackItemConfig` instance.

``` Objective-C

@interface ESVStackItemConfig : NSObject

#pragma mark - Cache

/// Frame cache of view. DO NOT change this property value unless you are pretty sure what you are doing.
@property (nonatomic, assign) CGRect cacheTransformedFrame;

@property (nonatomic, assign) CGRect cacheFrame;

#pragma mark - Associate

/// The view this config is associated to.
@property (nonatomic, readonly) NSObject<ESVStackItemType> * item;

#pragma mark - Config

/// Is this view layouted according to alignSelf in this config. Default is false.
@property (nonatomic, assign) BOOL alignSelfOn;

/// Describe how to layout this view in flex layout. Only work when alignSelfOn is true.
@property (nonatomic, assign) ESVAlign alignSelf;

/// Orignal frame of the view. This is the reference size of the view during layout. Default is view's size when added into arranged views array.
@property (nonatomic, assign) CGSize originSize;

/// Minium margin inset of view in four direction. Default is {0, 0, 0, 0,}.
@property (nonatomic, assign) UIEdgeInsets margin;

/// Indicates whether this view will auto stretch when super view is not filled along axis. Default is false.
@property (nonatomic, assign) BOOL growth;

/// Indicates whether this view will auto shrink when super view is too narrow along axis. Default is false.
@property (nonatomic, assign) BOOL shrink;

- (instancetype)initWithItem:(NSObject<ESVStackItemType> *)item;

@end

```

## TODO

[●] Scroll view with flex layout.

[●] Scroll view with view reusable, in order to replace `UITableView`.

[○] Try to make EasyStackView's behavior quite the same with Web flex layout.
