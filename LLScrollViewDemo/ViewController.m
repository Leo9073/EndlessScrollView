//
//  ViewController.m
//  LLScrollViewDemo
//
//  Created by Leo on 11/19/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "ViewController.h"
#import "LLEndlessPageView.h"

#define LLRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
#define ImageCount 5
#define ScrollViewW self.view.bounds.size.width
#define ScrollViewH self.view.bounds.size.height


@interface ViewController () <UIScrollViewDelegate>
@property (weak,nonatomic) UIPageControl *pageControl;
@property (weak,nonatomic) UIScrollView *scrollView;
@property (weak,nonatomic) NSTimer *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    LLEndlessPageView *pageView = [LLEndlessPageView endlessPageView];
    pageView.frame = CGRectMake(0, 0, ScrollViewW, ScrollViewH);
    pageView.imageNames = @[@"1",@"2",@"3",@"4",@"5"];
    [self.view addSubview:pageView];
}

@end
