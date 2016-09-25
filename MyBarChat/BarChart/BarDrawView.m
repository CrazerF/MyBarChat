//
//  BarDrawView.m
//  柱状图
//


#import "BarDrawView.h"
#import "BarChartConfig.h"
#import "CoordinateItem.h"

@interface NSString (Size)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize;

@end

@implementation NSString (Size)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

@end
@interface BarDrawView ()
{
    NSArray *_coordinates;
    UIColor *_barColor;
    BOOL _animation;
}

@end
@implementation BarDrawView
- (instancetype)initWithCoordiantes:(NSArray *)coordinates barColor:(UIColor *)barColor animated:(BOOL)animation
{
    if (self = [super init]) {
        _coordinates = coordinates;
        _barColor = barColor;
        _animation = animation;
        
    }
    return self;
    
}

- (void)drawRect:(CGRect)rect
{self.backgroundColor = [UIColor yellowColor];
    
    //建立绘图
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, kCoordinateLineWitdth);
    
    //1.绘制坐标轴
    [self drawXYCoodinate:context];
    //2.绘制X轴文字
    [self drawXCoodinateText];
    //3.绘制Y轴文字
    [self drawYCoodinateText];
    //4.绘制柱状
    [self drawBarRect];
    
}

#pragma mark - 4.绘制柱状
- (void)drawBarRect
{
    //柱状x、y坐标，柱状宽度、高度
    CGFloat x;
    CGFloat y;
    CGFloat w;
    CGFloat h;
    
    CGFloat max = [self maxYOfCoodinateYValue];
    
    CGFloat coordinateHeight = self.frame.size.height - 2 * kEdgeInsertSpace;
    
    w = kBarWidth;

    
    //绘制柱状
    for (int i = 0; i < _coordinates.count; i++)
    {
        CoordinateItem *item = _coordinates[i];
        CGFloat scale = item.yValue / max;
        
        x = kEdgeInsertSpace + kXSpace + kDistanceBetweenPointAndPoit * i - kBarWidth/2;
        y = kEdgeInsertSpace + (1 - scale) * coordinateHeight;
        
        h = scale * coordinateHeight;
        
        
        CGMutablePathRef endPath = CGPathCreateMutable();
        CGPathAddRect(endPath, NULL, CGRectMake(x, y, w, h));
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor kBarColor].CGColor;
        layer.path = endPath;
        [self.layer addSublayer:layer];
        
        if (_animation)
        {
            CGMutablePathRef starPath = CGPathCreateMutable();
            CGPathAddRect(starPath, NULL, CGRectMake(x, self.frame.size.height - kEdgeInsertSpace, w, 0));
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
            animation.duration = 5;
            animation.fromValue = (__bridge id _Nullable)(starPath);
            animation.toValue = (__bridge id _Nullable)(endPath);
            
            [layer addAnimation:animation forKey:nil];
            
            CGPathRelease(starPath);
        }
        
        
        CGPathRelease(endPath);
        
    }
    
    
    
}
#pragma mark - 3绘制y轴文字
- (void)drawYCoodinateText
{
    CGFloat maxY = [self maxYOfCoodinateYValue];
    CGFloat rowHeight = [self rowHeight];
    
    //创建一个段落
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentRight;
    
    for (int i = 0; i < kNumberOfRow; i++) {
        NSString *text = [NSString stringWithFormat:@"%.0f",maxY - maxY / kNumberOfRow * i];
        //获取文字高度
        CGFloat textHeitht = [text sizeWithFontSize:kFontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
         //绘制
        [text drawInRect:CGRectMake(0, kEdgeInsertSpace + rowHeight * i - textHeitht/2, kEdgeInsertSpace - 5, rowHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize],NSParagraphStyleAttributeName:paragraph}];
    }
    
    
}

- (CGFloat)maxYOfCoodinateYValue
{
    CGFloat maxY = -MAXFLOAT;
    for (CoordinateItem *item in _coordinates) {
        if (item.yValue > maxY) {
            maxY = item.yValue;
        }
    }
    return maxY;
}

#pragma mark - 2绘制x轴文字
- (void)drawXCoodinateText
{
    for (int i = 0; i < _coordinates.count; i++) {
        CoordinateItem *item = _coordinates[i];
        

        //获取文字宽度
        CGFloat textWith = [item.xValue sizeWithFontSize:kFontSize maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        //绘制点
        CGPoint point =  CGPointMake(kEdgeInsertSpace - textWith/2 + kXSpace + kDistanceBetweenPointAndPoit * i, self.frame.size.height - kEdgeInsertSpace);
        //绘制
        [item.xValue drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kFontSize]}];
    }
}
#pragma mark - 1绘制坐标轴
- (void)drawXYCoodinate:(CGContextRef)context
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    //绘制坐标框
    CGContextAddRect(context, CGRectMake(kEdgeInsertSpace,
                                         kEdgeInsertSpace,
                                         width - 2 * kEdgeInsertSpace,
                                         height - 2 * kEdgeInsertSpace));
    CGContextStrokePath(context);
    
    //绘制虚线
    CGFloat lengths[1] = {5};
    CGContextSetLineDash(context, 0, lengths, sizeof(lengths) / sizeof(lengths[0]));
    
    //行高
    CGFloat rowHeight = [self rowHeight];
    
    for (int i = 0; i < kNumberOfRow; i++) {
        CGFloat y = kEdgeInsertSpace + rowHeight * i;
        CGContextMoveToPoint(context, kEdgeInsertSpace, y);
        CGContextAddLineToPoint(context, width - kEdgeInsertSpace, y);
        CGContextStrokePath(context);
    }
    
    
}
//计算行高
- (CGFloat)rowHeight
{
    return (self.frame.size.height - 2 * kEdgeInsertSpace) / kNumberOfRow;
}
@end
