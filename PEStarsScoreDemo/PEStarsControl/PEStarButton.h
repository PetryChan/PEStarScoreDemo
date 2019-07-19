#import <UIKit/UIKit.h>
@interface PEStarButton : UIButton
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, assign) CGFloat fractionPart;
- (instancetype)initWithSize:(CGSize)size;
- (CGFloat)fractionPartOfPoint:(CGPoint)point;
@end
