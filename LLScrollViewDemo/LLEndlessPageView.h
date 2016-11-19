//
//  LLEndlessPageView.h
//  LLScrollViewDemo
//
//  Created by Leo on 11/19/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLEndlessPageView : UIView
@property (strong,nonatomic) NSArray *imageNames;
+ (instancetype)endlessPageView;
@end
