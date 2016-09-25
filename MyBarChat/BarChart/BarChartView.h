//
//  BarChartView.h
//  柱状图
//

#import <UIKit/UIKit.h>

@interface BarChartView : UIScrollView

/**
 *  初始化方法
 *
 *  @param coordinates 数据,数组里为CoordinateItem的对象
 *  @param barColor    柱状颜色
 *  @param animation   是否需要动画
 *
 *  @return a object of BarChartView class
 */
- (instancetype)initWithCoordiantes:(NSArray *)coordinates barColor:(UIColor *)barColor animated:(BOOL)animation;

/**
 *  开始绘制
 */
- (void)stroke;

@end
