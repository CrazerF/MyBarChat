//
//  CoordinateItem.m
//  柱状图
//


#import "CoordinateItem.h"

@implementation CoordinateItem

+ (instancetype)coordinateItemWithXText:(NSString *)xText yValue:(CGFloat)yValue
{
    CoordinateItem *item = [[self alloc] init];
    item.xValue = xText;
    item.yValue = yValue;
    
    return item;
}


@end
