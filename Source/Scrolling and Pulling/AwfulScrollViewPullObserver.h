//
//  AwfulScrollViewPullObserver.h
//  Awful
//
//  Copyright 2012 Awful Contributors. CC BY-NC-SA 3.0 US http://github.com/AwfulDevs/Awful
//

#import <UIKit/UIKit.h>

@interface AwfulScrollViewPullObserver : NSObject

typedef enum {
    AwfulScrollViewPullDown,
    AwfulScrollViewPullUp
} AwfulScrollViewPullDirection;

typedef void (^AwfulPullToRefreshBlock)(void);

// Designated initializer.
- (id)initWithScrollView:(UIScrollView *)scrollView
               direction:(AwfulScrollViewPullDirection)direction
           triggerOffset:(CGFloat)triggerOffset;

@property (readonly, weak, nonatomic) UIScrollView *scrollView;

@property (readonly, nonatomic) AwfulScrollViewPullDirection direction;

@property (nonatomic) CGFloat triggerOffset;

@property (copy, nonatomic) AwfulPullToRefreshBlock willTrigger;

@property (copy, nonatomic) AwfulPullToRefreshBlock willNotTrigger;

@property (copy, nonatomic) AwfulPullToRefreshBlock didTrigger;

@property (copy, nonatomic) AwfulPullToRefreshBlock scrollViewDidResize;

- (void)reset;

- (void)willLeaveScrollView:(UIScrollView *)scrollView;

@end
