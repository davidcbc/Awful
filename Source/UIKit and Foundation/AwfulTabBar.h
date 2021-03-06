//
//  AwfulTabBar.h
//  Awful
//
//  Copyright 2012 Awful Contributors. CC BY-NC-SA 3.0 US http://github.com/AwfulDevs/Awful
//

#import <UIKit/UIKit.h>
@protocol AwfulTabBarDelegate;

@interface AwfulTabBar : UIView

@property (copy, nonatomic) NSArray *items;

@property (nonatomic) UITabBarItem *selectedItem;

@property (weak, nonatomic) id <AwfulTabBarDelegate> delegate;

@end


@protocol AwfulTabBarDelegate <NSObject>
@optional

- (void)tabBar:(AwfulTabBar *)tabBar didSelectItem:(UITabBarItem *)item;

@end
