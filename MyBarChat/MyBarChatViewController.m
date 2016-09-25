//
//  MyBarChatViewController.m
//  MyBarChat
//


#import "MyBarChatViewController.h"
//导入头文件
#import "BarChartView.h"
#import "CoordinateItem.h"


@implementation MyBarChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self test];
    
}

- (void)test
{
    NSMutableArray *coordiantes = [NSMutableArray array];
    //柱状图x轴数据
    NSArray *xText = @[@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周"];
    //柱状图y轴数据
    NSArray *yValue = @[@"50",@"66",@"30",@"100",@"72",@"85",@"45",@"30"];
    
    for (NSInteger i = 0; i < 8; i++)
    {
        CoordinateItem *item = [CoordinateItem coordinateItemWithXText:xText[i]
                             yValue:[yValue[i] integerValue] ];
        [coordiantes addObject:item];
    }
    
    
    //创建柱状图
    BarChartView *barChatView = [[BarChartView alloc] initWithCoordiantes:coordiantes
                   barColor:[UIColor redColor]
                   animated:YES];
    
    barChatView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    [self.view addSubview:barChatView];
    //开始绘制
    [barChatView stroke];
    
}

@end
