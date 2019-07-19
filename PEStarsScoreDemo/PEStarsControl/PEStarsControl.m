#import "PEStarsControl.h"
#import "PEStarButton.h"
@interface PEStarsControl()
@property (nonatomic, strong) PEStarButton *currentStar;
@property (nonatomic, assign) NSInteger numberOfStars;
@property (nonatomic, strong) UIImage *normalStarImage;
@property (nonatomic, strong) UIImage *highlightedStarImage;
@property (nonatomic, assign) CGSize starSize;
@end
@implementation PEStarsControl
- (instancetype)initWithFrame:(CGRect)frame
                        stars:(NSInteger)number
                     starSize:(CGSize)size
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage{
    if (self = [super initWithFrame:frame]) {
        _numberOfStars = number;
        _normalStarImage = normalImage;
        _highlightedStarImage = highlightedImage;
        _starSize = size;
        _allowFraction = NO;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage{
    return [self initWithFrame:frame stars:5 starSize:CGSizeMake(frame.size.height, frame.size.height) noramlStarImage:normalImage highlightedStarImage:highlightedImage];
}
- (instancetype)initWithFrame:(CGRect)frame
                        stars:(NSInteger)number
              noramlStarImage:(UIImage *)normalImage
         highlightedStarImage:(UIImage *)highlightedImage{
    return [self initWithFrame:frame stars:number starSize:CGSizeMake(frame.size.height, frame.size.height) noramlStarImage:normalImage highlightedStarImage:highlightedImage];
}
- (void)setupView {
    for (NSInteger index = 0; index < self.numberOfStars; index++) { 
        PEStarButton *starButton = [PEStarButton.alloc initWithSize:self.starSize];
        starButton.tag = index;
        starButton.normalImage = self.normalStarImage;
        starButton.highlightedImage = self.highlightedStarImage;
        starButton.userInteractionEnabled = NO;
        [self addSubview:starButton];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (NSInteger index = 0; index < self.numberOfStars; index ++) {
        PEStarButton *starButton =  [self starForTag:index];
        CGFloat newY = (self.frame.size.height - self.starSize.height) / 2;
        CGFloat margin = 0;
        if (self.numberOfStars > 1) {
            margin = (self.frame.size.width - self.starSize.width * self.numberOfStars) / (self.numberOfStars - 1);
        }
        starButton.frame = CGRectMake((self.starSize.width + margin) * index, newY, self.starSize.width, self.starSize.height);
    }
}
- (PEStarButton *)starForPoint:(CGPoint)point {
    for (NSInteger i = 0; i < self.numberOfStars; i++) {
        PEStarButton *starButton = [self starForTag:i];
        if (CGRectContainsPoint(starButton.frame, point)) {
            return starButton;
        }
    }
    return nil;
}
- (PEStarButton *)starForTag:(NSInteger)tag {
    __block UIView *target;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == tag) {
            target = obj;
            *stop = YES;
        }
    }];
    return (PEStarButton *)target;
}
- (void)starsDownToIndex:(NSInteger)index {
    for (NSInteger i = self.numberOfStars; i > index; --i) {
        PEStarButton *starButton = [self starForTag:i];
        starButton.selected = NO;
        starButton.highlighted = NO;
    }
}
- (void)starsUpToIndex:(NSInteger)index {
    for (NSInteger i = 0; i <= index; i++) {
        PEStarButton *starButton = [self starForTag:i];
        starButton.selected = YES;
        starButton.highlighted = NO;
    }
}
#pragma mark -Touch Handling
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    PEStarButton *pressedStar = [self starForPoint:point];
    if (pressedStar) {
        self.currentStar = pressedStar;
        NSInteger index = pressedStar.tag;
        CGFloat fractionPart = 1;
        if (self.isAllowFraction) {
            fractionPart = [pressedStar fractionPartOfPoint:point];
        }
        self.score = index + fractionPart;
    }
    if ([self.delegate respondsToSelector:@selector(starsControl:didChangeScore:)]) {
        [self.delegate starsControl:self didChangeScore:self.score];
    }
    return YES;
}
- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint point = [touch locationInView:self];
    PEStarButton *pressedStar = [self starForPoint:point];
    if (pressedStar) {
        self.currentStar = pressedStar;
        NSInteger index = pressedStar.tag;
        CGFloat fractionPart = 1;
        if (self.isAllowFraction) {
            fractionPart = [pressedStar fractionPartOfPoint:point];
        }
        self.score = index + fractionPart;
    }
    else{
        if (point.x < self.currentStar.frame.origin.x) {
            self.score = self.currentStar.tag;
        }
        else if (point.x > (self.currentStar.frame.origin.x + self.currentStar.frame.size.width)){
            self.score = self.currentStar.tag + 1;
        }
    }
    if ([self.delegate respondsToSelector:@selector(starsControl:didChangeScore:)]) {
        [self.delegate starsControl:self didChangeScore:self.score];
    }
    return YES;
}
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if ([self.delegate respondsToSelector:@selector(starsControl:didChangeScore:)]) {
        [self.delegate starsControl:self didChangeScore:self.score];
    }
}
- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    if ([self.delegate respondsToSelector:@selector(starsControl:didChangeScore:)]) {
        [self.delegate starsControl:self didChangeScore:self.score];
    }
}
#pragma mark - getter&setter
- (void)setScore:(CGFloat)score{
    if (_score == score) {
        return;
    }
    _score = score;
    NSInteger index = floor(score);
    CGFloat fractionPart = score - index;;
    if (!self.isAllowFraction || fractionPart == 0) {
        index -= 1;
    }
    PEStarButton *starButton = [self starForTag:index];
    if (starButton.selected || score == 0) {
        [self starsDownToIndex:index];
    }
    else{
        [self starsUpToIndex:index];
    }
    starButton.fractionPart = fractionPart;
} 
@end
