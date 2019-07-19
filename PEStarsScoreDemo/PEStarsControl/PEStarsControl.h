#import <UIKit/UIKit.h>
@class PEStarsControl;
@protocol PEStarsControlDelegate<NSObject>
@optional

/**
 回调星星改变后的分数
 
 @param starsControl 星星组件
 @param score 分数
 */
- (void)starsControl:(PEStarsControl *)starsControl didChangeScore:(CGFloat)score;
@end
@interface PEStarsControl : UIControl

/**
 初始化一个星星组件,默认5颗星，默认星星的长宽为frame的高度
 
 @param frame fram
 @param normalImage 普通状态星星
 @param highlightedImage 高亮状态星星
 @return 星星组件
 */
- (instancetype)initWithFrame:(CGRect)frame
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage;

/**
 初始化一个星星组件，默认星星的长宽为frame的高度
 
 @param frame frame
 @param number 星星数量
 @param normalImage 普通状态星星
 @param highlightedImage 高亮状态星星
 @return 星星组件
 */
- (instancetype)initWithFrame:(CGRect)frame
                        stars:(NSInteger)number
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage;

/**
 初始化一个星星组件
 
 @param frame frame
 @param number 星星数目
 @param size 星星大小
 @param normalImage 普通形态星星
 @param highlightedImage 高亮形态星星
 @return 星星组件
 */
- (instancetype)initWithFrame:(CGRect)frame
                        stars:(NSInteger)number
                     starSize:(CGSize)size
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage;
@property (nonatomic, weak)   id<PEStarsControlDelegate> delegate;
//是否允许小数（1位小数），默认为NO
@property (nonatomic, assign, getter=isAllowFraction) BOOL allowFraction;
//星星组件上的分数，可以直接设置
@property (nonatomic, assign) CGFloat score;

@end
