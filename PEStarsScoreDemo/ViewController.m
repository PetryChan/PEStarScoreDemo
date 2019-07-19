#import "ViewController.h"
#import "PEStarsControl.h"
@interface ViewController ()<PEStarsControlDelegate>

@property (nonatomic, strong) PEStarsControl *starsControl;
@property (nonatomic, strong) PEStarsControl *starsControl2;
@property (nonatomic, strong) PEStarsControl *starsControl3;
@property (nonatomic, strong) PEStarsControl *starsControl4;
@property (weak, nonatomic) UILabel *label1;
@property (weak, nonatomic) UILabel *label2;
@property (weak, nonatomic) UILabel *label3;
@property (weak, nonatomic) UILabel *label4;
@end
@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1
    [self.view addSubview:self.starsControl];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starsControl.frame), 110, 100, 20)];
    [self.view addSubview:label1];
    self.label1 = label1;
    self.label1.textAlignment = NSTextAlignmentCenter;
    label1.text = [NSString stringWithFormat:@"%.1f",self.starsControl.score*2.0];
    
    //2
    [self.view addSubview:self.starsControl2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starsControl2.frame), 150, 100, 20)];
    [self.view addSubview:label2];
    self.label2 = label2;
    self.label2.textAlignment = NSTextAlignmentCenter;
    label2.text = [NSString stringWithFormat:@"%.1f",self.starsControl2.score*2.0];
    
    //3
    [self.view addSubview:self.starsControl3];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starsControl3.frame), CGRectGetMinY(self.starsControl3.frame)+10, 100, 20)];
    [self.view addSubview:label3];
    self.label3 = label3;
    self.label3.textAlignment = NSTextAlignmentCenter;
    label3.text = [NSString stringWithFormat:@"%.1f",self.starsControl3.score];
    
    //4
    [self.view addSubview:self.starsControl4];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.starsControl4.frame), CGRectGetMinY(self.starsControl4.frame)+10, 100, 20)];
    [self.view addSubview:label4];
    self.label4 = label4;
    self.label4.textAlignment = NSTextAlignmentCenter;
    label4.text = [NSString stringWithFormat:@"%.1f",self.starsControl4.score*2.0];
    
}
- (void)starsControl:(PEStarsControl *)starsControl didChangeScore:(CGFloat)score{
    NSString *result = [NSString stringWithFormat:@"%.1f",score*2.0];
    if (starsControl == self.starsControl) {
        self.label1.text = result;
    }else if(starsControl == self.starsControl2){
        self.label2.text = result;
    }else if(starsControl == self.starsControl3){
        self.label3.text = [NSString stringWithFormat:@"%.1f",score];;
    }else if(starsControl == self.starsControl4){
        self.label4.text = result;
    }
    
}
- (PEStarsControl *)starsControl{
    if (!_starsControl) {
        _starsControl = [PEStarsControl.alloc initWithFrame:CGRectMake(10, 100, 250 , 30) stars:5 starSize:CGSizeMake(30, 30) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
        _starsControl.delegate = self;
        _starsControl.allowFraction = NO;
        _starsControl.score = 3.0f;
        _starsControl.enabled = YES; //默认YES NO:不允许
    }
    return _starsControl;
}
- (PEStarsControl *)starsControl2{
    if (!_starsControl2) {
        _starsControl2 = [PEStarsControl.alloc initWithFrame:CGRectMake(10, 140, 250 , 30) stars:5 starSize:CGSizeMake(30, 30) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
        _starsControl2.delegate = self;
        _starsControl2.allowFraction = YES;
        _starsControl2.score = 3.5f;
        _starsControl2.enabled = YES; //默认YES NO:不允许
    }
    return _starsControl2;
}
- (PEStarsControl *)starsControl3{
    if (!_starsControl3) {
        _starsControl3 = [PEStarsControl.alloc initWithFrame:CGRectMake(10, 180, 300 , 30) stars:10 starSize:CGSizeMake(30, 30) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
        _starsControl3.delegate = self;
        _starsControl3.allowFraction = YES;
        _starsControl3.score = 3.5f;
        _starsControl3.enabled = YES; //默认YES NO:不允许
    }
    return _starsControl3;
}
- (PEStarsControl *)starsControl4{
    if (!_starsControl4) {
        _starsControl4 = [PEStarsControl.alloc initWithFrame:CGRectMake(10, 220, 250 , 30) stars:5 starSize:CGSizeMake(30, 30) noramlStarImage:[UIImage imageNamed:@"star_normal"] highlightedStarImage:[UIImage imageNamed:@"star_highlighted"]];
        _starsControl4.delegate = self;
        _starsControl4.allowFraction = YES;
        _starsControl4.score = 3.5f;
        _starsControl4.enabled = NO; //默认YES NO:不允许
    }
    return _starsControl4;
}
@end
