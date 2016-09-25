//
//  CoordinateItem.h
//  柱状图
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CoordinateItem : NSObject
//x文字
@property (nonatomic, copy) NSString *xValue;
//y轴数据
@property (nonatomic, assign) CGFloat yValue;

+ (instancetype)coordinateItemWithXText:(NSString *)xText yValue:(CGFloat)yValue;

@end
