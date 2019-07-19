#import "PEStarButton.h"
@implementation PEStarButton
- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]) {
        self.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (CGFloat)fractionPartOfPoint:(CGPoint)point{
    CGFloat fractionPart =  (point.x - self.frame.origin.x) / self.frame.size.width;
    return round(fractionPart * 10) / 10;
}
#pragma mark - helper
+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize{
    UIGraphicsBeginImageContext(reSize);
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
- (UIImage *)croppedImage:(UIImage *)image fraction:(CGFloat)fractonPart{
    CGFloat width = image.size.width * fractonPart * image.scale;
    CGRect newFrame = CGRectMake(0, 0, width , image.size.height * image.scale); 
    CGImageRef resultImage = CGImageCreateWithImageInRect(image.CGImage, newFrame);
    UIImage *result = [UIImage imageWithCGImage:resultImage scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(resultImage);
    return [self composeImg:result andImg:self.normalImage];
}
- (UIImage *)composeImg:(UIImage *)img andImg:(UIImage *)img1 {
    UIGraphicsBeginImageContext(CGSizeMake(img1.size.width * img1.scale, img1.size.height * img1.scale));
    [img1 drawInRect:CGRectMake(0, 0, img1.size.width * img1.scale, img1.size.height * img1.scale)];
    [img drawInRect:CGRectMake(0, 0, img.size.width * img1.scale, img.size.height * img1.scale)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
#pragma mark - setter&getter
- (void)setNormalImage:(UIImage *)normalImage{
    _normalImage = normalImage;
    [self setImage:normalImage forState:UIControlStateNormal];
}
- (void)setHighlightedImage:(UIImage *)highlightedImage{
    _highlightedImage = highlightedImage;
    [self setImage:highlightedImage forState:UIControlStateSelected];
}
- (void)setFractionPart:(CGFloat)fractionPart{
    if (fractionPart == 0) {
        return;
    }
    UIImage *image = [self croppedImage:self.highlightedImage fraction:fractionPart];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    [self setImage:image forState:UIControlStateHighlighted];
    self.selected = NO;
    self.highlighted = YES;
}
@end
