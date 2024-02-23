//
//  ViewController.m
//  JXCategoryTitleViewDEMO
//
//  Created by 李韋辰 on 2023/6/14.
//

#import "ViewController.h"
#import <JXCategoryTitleView.h>

@interface ViewController () <JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryTitleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建标题数组
    NSArray *titles = @[@"Tab 1", @"Tab 2", @"Tab 3"];
    
    // 创建 JXCategoryTitleView 实例
    self.categoryTitleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    
    // 设置代理
    self.categoryTitleView.delegate = self;
    
    // 将标题数组设置给 categoryTitleView
    self.categoryTitleView.titles = titles;
    
    // 设置选中的标题下标
    self.categoryTitleView.defaultSelectedIndex = 0;
    
    // 将 categoryTitleView 添加到视图中
    [self.view addSubview:self.categoryTitleView];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"Selected index: %ld", (long)index);
    // 在这里可以执行选中项变更后的逻辑操作
}

@end
