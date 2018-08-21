//
//  ViewController.m
//  SudokuDemo
//
//  Created by QMMac on 2018/8/21.
//  Copyright © 2018 QMMac. All rights reserved.
//

#import "ViewController.h"

/**************************无间距****************************/
/** 设置格子的X坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * WIDTH     指九宫格每个小格子的宽度  int width = (VVS_SCREEN_WIDTH - (colunm - 1) * margin) / colunm;
 * COLUMN    指九宫格的纵向列数
 * 注意： MARGIN 和 WIDTH不能都是CGFloat
 */
#define CELL_X_WITH_SUPERVIEW_AND_WIDTH(SUPERVIEW,WIDTH,COLUMN) SUPERVIEW.subviews.count % COLUMN * WIDTH

/** 设置格子的Y坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * WIDTH     指九宫格每个小格子的宽度  int width = (VVS_SCREEN_WIDTH - (colunm - 1) * margin) / colunm;
 * COLUMN    指九宫格的纵向列数
 * 注意： MARGIN 和 WIDTH不能都是CGFloat
 */
#define CELL_Y_WITH_SUPERVIEW_AND_HEIGHT(SUPERVIEW,HEIGHT,COLUMN) SUPERVIEW.subviews.count / COLUMN * HEIGHT

/**************************有间距****************************/
/** 设置格子的X坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * WIDTH     指九宫格每个小格子的宽度  int width = (VVS_SCREEN_WIDTH - (colunm - 1) * margin) / colunm;
 * COLUMN    指九宫格的纵向列数
 * MARGIN    指格子之间的横向间距
 * 注意： MARGIN 和 WIDTH不能都是CGFloat
 */
#define CELL_X_WITH_PARAMETERS(SUPERVIEW,WIDTH,COLUMN,MARGIN) SUPERVIEW.subviews.count % COLUMN * WIDTH + SUPERVIEW.subviews.count % COLUMN  * MARGIN

/** 设置格子的Y坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * HEIGHT    指九宫格每个小格子的高度
 * COLUMN    指九宫格的纵向列数
 * MARGIN    指格子之间的纵向间距
 * 注意： MARGIN 和 HEIGHT不能都是CGFloat
 */
#define CELL_Y_WITH_PARAMETERS(SUPERVIEW,HEIGHT,COLUMN,MARGIN) SUPERVIEW.subviews.count / COLUMN * HEIGHT + SUPERVIEW.subviews.count / COLUMN * MARGIN

/**************************有间距、有边距****************************/
/** 设置格子的X坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * WIDTH     指九宫格每个小格子的宽度 int width = (VVS_SCREEN_WIDTH - (colunm + 1) * margin) / colunm;
 * COLUMN    指九宫格的纵向列数
 * MARGIN    指格子之间的横向间距 和 外边距
 * 注意： MARGIN 和 WIDTH不能都是CGFloat
 */
#define CELL_X_WITH_EDGE_PARAMETERS(SUPERVIEW,WIDTH,COLUMN,MARGIN) SUPERVIEW.subviews.count % COLUMN * WIDTH + (SUPERVIEW.subviews.count % COLUMN + 1) * MARGIN

/** 设置格子的Y坐标
 * SUPERVIEW 指九宫格每个小格子的父视图
 * HEIGHT    指九宫格每个小格子的高度
 * COLUMN    指九宫格的纵向列数
 * MARGIN    指格子之间的纵向间距 和 外边距
 * 注意： MARGIN 和 HEIGHT不能都是CGFloat
 */
#define CELL_Y_WITH_EDGE_PARAMETERS(SUPERVIEW,HEIGHT,COLUMN,MARGIN) SUPERVIEW.subviews.count / COLUMN * HEIGHT + (SUPERVIEW.subviews.count / COLUMN + 1) * MARGIN

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSquare];
}


- (void)setupSquare {
    // 小格子的公共父视图
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:backView];
    // 列数
    int colunm = 2;
    // 间距
    int margin = 10;
    // 宽度
    int width = (SCREEN_WIDTH - (colunm + 1) * margin) / colunm;
    // 高度
    int height = width;
    // 循环添加9个小格子
    for (int i = 0; i < 9; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        // 使用宏计算frame
        button.frame = CGRectMake(CELL_X_WITH_EDGE_PARAMETERS(backView, width, colunm, margin), CELL_Y_WITH_EDGE_PARAMETERS(backView, height, colunm, margin), width, height);
        // 创建好后就把小格子添加到父视图
        [backView addSubview:button];
        
        CGFloat red = rand() % 255 / 255.f;
        CGFloat green = rand() % 255 / 255.f;
        CGFloat blue = rand() % 255 / 255.f;
        button.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
        // 给每个小格子添加监听事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)buttonClick:(UIButton *)sender {
    NSLog(@"%ld", (long)sender.tag);
}

@end
