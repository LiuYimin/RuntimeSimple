//
//  UIButton+LP.h
//  RuntimeSimple
//
//  Created by Liu on 16/7/11.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  增加按钮点击范围
 */
@interface UIButton (LP)

@property (nonatomic,assign) CGFloat enlargeEdge;

- (void)setEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

@end
