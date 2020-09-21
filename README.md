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


There are four kinds of flex container right now:

`ESVStackView` -> `UIView`

`ESVStackPlaceHolder` -> `UIView` (When using flexbox layout, we create some `<div>` purelly for layout reference. To avoid creating too much useless  `UIView` object, use `ESVStackPlaceHolder` instead of `ESVStackView`. `ESVStackPlaceHolder` is much less expensive compared with `ESVStackView`.)

*Attention:* `ESVStackPlaceHolder` instance should not be the root of an flex layout tree.

`ESVScrollView` -> `UIScrollView`

`ESVRecycleView` -> `UITableView` or `UICollectionView`

### Sample

![Alert](https://github.com/Elenionl/EasyStackView/blob/master/readme_image/WX20200920-220607@2x.png?raw=true)

To build UI as above, there are only few steps.

1. Firstly, create a container for the whole alertView. Each element inside is rendered vertically, and stretched as width as possible.

``` Swift
let container: ESVStackView = createContainer()
container.flexDirection = .column
container.alignItems = .stretch
```

2. Add title.

``` Swift
let title: UILabel = createTitle()
container.addArrangedItem(title)
```

3. Add content and set margin for content.

``` Swift
let content: UITextView = createContent()
container.addArrangedItem(content)
container.manageConfig(of: content) { (config) in
    config?.margin = .init(top: 10, left: 10, bottom: 10, right: 10)
    config?.growth = true
}
```

4. Create a scrollable container to hold four icons. Hide the horizontal scroll indicator. Eelements layout horizontal.

``` Swift
let iconHolder: ESVScrollView = createIconHolder()
iconHolder.showsHorizontalScrollIndicator = false
container.addArrangedItem(iconHolder)
iconHolder.flexDirection = .row
container.manageConfig(of: iconHolder) { (config) in
    config?.margin = .init(top: 10, left: 10, bottom: 10, right: 10)
}
```

5. Create four items and add them to the scrollable container.

``` Swift
for i in 0...4 {
    let icon: UIView = createIcon()
    if i % 3 == 0 {
        icon.backgroundColor = UIColor.red
    } else {
        icon.backgroundColor = UIColor.white
    }
    iconHolder.addArrangedItem(icon)
    if i == 4 {
        iconHolder.manageConfig(of: UInt(i)) { (config) in
            config?.margin = .init(top: 0, left: 5, bottom: 0, right: 5)
        }
    } else {
        iconHolder.manageConfig(of: UInt(i)) { (config) in
            config?.margin = .init(top: 0, left: 5, bottom: 0, right: 0)
        }
    }
}
```

6. Create another scrollable container to hold ten icons. In case there are too much icons inside, we'd prefer using recycable container.

``` Swift
let recycleIconHolder: ESVRecycleView = createRecycleIconHolder()
recycleIconHolder.showsHorizontalScrollIndicator = false
container.addArrangedItem(recycleIconHolder)
recycleIconHolder.flexDirection = .row
container.manageConfig(of: recycleIconHolder) { (config) in
    config?.margin = .init(top: 10, left: 10, bottom: 10, right: 10)
}
```

7. Define a subclass of `UIView` which works as recyclable element in display.

``` Swift
class RecycleIcon: UIView, ESVRecycleCellType {
    func prepareForReuse() {
        
    }
    
    func config(with model: ESVRecyclableModelType, index: UInt) {
        self.layer.cornerRadius = 6
        self.backgroundColor = index % 3 == 0 ? UIColor.white : UIColor.red
    }
}
```

8. Register `RecycleIcon` generator with key `"RecycleIcon"`.

``` Swift
recycleIconHolder.registerGenerator({ () -> UIView & ESVRecycleCellType in
    return RecycleIcon()
}, forIdentifier: "RecycleIcon")
```

9. Add ten model objects to the container.

``` Swift
for i in 0...10 {
    let model: ESVRecyclableModelType = ESVRecyclableModel()
    model.frame = .init(x: 0, y: 0, width: 50, height: 50)
    model.identifier = "RecycleIcon"
    recycleIconHolder.addArrangedItem(model)
    if i == 10 {
        recycleIconHolder.manageConfig(of: UInt(i)) { (config) in
            config?.margin = .init(top: 0, left: 5, bottom: 0, right: 5)
        }
    } else {
        recycleIconHolder.manageConfig(of: UInt(i)) { (config) in
            config?.margin = .init(top: 0, left: 5, bottom: 0, right: 0)
        }
    }
}
```

10. Add a container for buttons. It only works as a render reference and has not display. So using `ESVStackPlaceHolder` is a cheap choice.

``` Swift
let buttonContainer: ESVStackPlaceHolder = createButtonContainer()
container.addArrangedItem(buttonContainer)
buttonContainer.flexDirection = .row
buttonContainer.alignItems = .stretch
```

11. Add two buttons to the button container. Two buttons are equal in size and should stretch to occupy all space.

``` Swift
let confirmButton = createConfirmButton()
buttonContainer.addArrangedItem(confirmButton)
buttonContainer.manageConfig(of: confirmButton) { (config) in
    config?.growth = true
    config?.margin = .init(top: 5, left: 5, bottom: 5, right: 5)
}
let cancelButton = createCancelButton()
buttonContainer.addArrangedItem(cancelButton)
buttonContainer.manageConfig(of: cancelButton) { (config) in
    config?.growth = true
    config?.margin = .init(top: 5, left: 5, bottom: 5, right: 5)
}
```

This sample is written in `./Demo/Sample4ViewController.swift` in this repository. You can run the `Demo` target with Xcode to check this out.

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

[Finish]    Scroll view with flex layout.

[Finish]    Scroll view with view reusable, in order to replace `UITableView`.

[Todo]      Try to make EasyStackView's behavior quite the same with Web flex layout.

