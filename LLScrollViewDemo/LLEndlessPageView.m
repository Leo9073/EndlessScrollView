//
//  LLEndlessPageView.m
//  LLScrollViewDemo
//
//  Created by Leo on 11/19/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "LLEndlessPageView.h"
#import <Masonry.h>

#define ScrollViewW self.bounds.size.width
#define ScrollViewH self.bounds.size.height

@interface LLEndlessPageView () <UIScrollViewDelegate>
@property (weak,nonatomic) UIPageControl *pageControl;
@property (weak,nonatomic) UIScrollView *scrollView;
@property (weak,nonatomic) NSTimer *timer;
@end

@implementation LLEndlessPageView

+ (instancetype)endlessPageView {
    
    return [[self alloc] init];
}

- (void)setImageNames:(NSArray *)imageNames {
    
    _imageNames = imageNames;
    
    //防止对属性重新赋值时，没有清除原来的图片
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setupScrollView];
    [self setupPageControl];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        [self setupScrollView];
        //        [self setupPageControl];
        [self startTimer];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

#pragma mark -- 配置子视图
/**
 *  配置滚动视图
 */
- (void)setupScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScrollViewW*self.imageNames.count, ScrollViewH);
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    for (int i = 0; i < self.imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScrollViewW, 0, ScrollViewW, ScrollViewH)];
        imageView.image = [UIImage imageNamed:self.imageNames[i]];
        [scrollView addSubview:imageView];
    }
}

/**
 *  配置分页视图
 */
- (void)setupPageControl {
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = self.imageNames.count;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.hidesForSinglePage = YES; //单页是否隐藏
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

#pragma mark -- 定时器相关方法

/**
 *  开启定时器
 */
- (void)startTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

/**
 *  停止定时器
 */
- (void)stopTimer {
    
    [self.timer invalidate];
}

/**
 *  自动显示下一页
 */
- (void)nextPage {
    
    NSInteger page = self.pageControl.currentPage + 1;
    if (page == self.imageNames.count) {
        page = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(page * ScrollViewW, 0) animated:YES];
}

#pragma mark -- 布局方法
/**
 *  子视图布局
 */
- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof(self) weakSelf = self;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(weakSelf);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(-20);
        //        make.centerX.equalTo(weakSelf.mas_centerX);
        //        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(100);
        make.right.equalTo(weakSelf).offset(-100);
    }];
}

#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    double page = scrollView.contentOffset.x / ScrollViewW;
    self.pageControl.currentPage = (int) (page+0.5);
}

/**
 *  开始拖拽，停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

/**
 *  拖拽完成，开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}

@end
