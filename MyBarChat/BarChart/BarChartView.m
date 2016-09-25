
#import "BarChartView.h"
#import "BarChartConfig.h"
#import "BarDrawView.h"


@interface BarChartView ()
{
    NSArray *_coordinates;
    UIColor *_barColor;
    BOOL _animation;
}

@property (nonatomic,weak) BarDrawView *barDrawView;

@end
@implementation BarChartView

- (instancetype)initWithCoordiantes:(NSArray *)coordinates barColor:(UIColor *)barColor animated:(BOOL)animation
{
    if (self = [super init]) {
        _coordinates = coordinates;
        _barColor = barColor;
        _animation = animation;
        
        
        //设置滚动视图的课滚动范围
        self.contentSize = CGSizeMake(kEdgeInsertSpace * 2 +kXSpace * 2 + kDistanceBetweenPointAndPoit * (_coordinates.count - 1), 0);
        
        //去掉一些效果
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
    
}
/**
 *  开始绘制
 */
- (void)stroke
{
    BarDrawView *barDrawView = [[BarDrawView alloc] initWithCoordiantes:_coordinates barColor:_barColor animated:_animation];
    
    barDrawView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:barDrawView];
    
    _barDrawView = barDrawView;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _barDrawView.frame = CGRectMake(0, 0, self.contentSize.width, self.frame.size.height);
}


@end
