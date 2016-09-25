//
//  BarDrawView.h
//  柱状图
//


#import <UIKit/UIKit.h>

@interface BarDrawView : UIView
/*  初始化方法
*
*  @param coordinates 数据
*  @param barColor    柱状颜色
*  @param animation   是否需要动画
*
*/
- (instancetype)initWithCoordiantes:(NSArray *)coordinates barColor:(UIColor *)barColor animated:(BOOL)animation;
@end
