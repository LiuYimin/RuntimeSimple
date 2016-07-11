//
//  UIButton+LP.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/11.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "UIButton+LP.h"
#import <objc/runtime.h>

@implementation UIButton (LP)

static char topEdgeKey;
static char leftEdgeKey;
static char bottomEdgeKey;
static char rightEdgeKey;



- (void)setEnlargeEdge:(CGFloat)enlargeEdge {
    [self setEnlargedEdgeWithTop:enlargeEdge left:enlargeEdge bottom:enlargeEdge right:enlargeEdge];
}

- (CGFloat)enlargeEdge {
    return [(NSNumber *)objc_getAssociatedObject(self, &topEdgeKey) floatValue];
}


- (void)setEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    objc_setAssociatedObject(self, &topEdgeKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdgeKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdgeKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGRect)enlargeRect {
    NSNumber *top = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber *left = objc_getAssociatedObject(self, &leftEdgeKey);
    NSNumber *bottom = objc_getAssociatedObject(self, &bottomEdgeKey);
    NSNumber *right = objc_getAssociatedObject(self, &rightEdgeKey);
    
    if (top && left && bottom && right) {
        CGRect rect = CGRectMake(self.bounds.origin.x-left.floatValue, self.bounds.origin.y-top.floatValue, self.bounds.size.width+left.floatValue+right.floatValue, self.bounds.size.height+top.floatValue+bottom.floatValue);
        return rect;
    }else {
        return self.bounds;
    }
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.userInteractionEnabled || self.alpha < 0.01 || self.hidden) {
        return nil;
    }
    
    CGRect rect = [self enlargeRect];
    return CGRectContainsPoint(rect, point)?self:nil;
}



@end
