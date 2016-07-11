//
//  Person.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/7.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "Person.h"
#import <UIKit/UIKit.h>

//协议写在这里无法被class_copyProtocolList获取到
@interface Person ()<UIScrollViewDelegate>

@end

@implementation Person

- (void)sayHello; {
    NSLog(@"Halo");
}

//如果不实现,是无法通过Method获取的
//- (void)makeLove; {
//
//}

//实现了的类方法通过class_copyMethodList 也是获取不到的
+ (void)heheda {
    NSLog(@"heheda");
}

- (void)sayByeBye; {
    NSLog(@"ByeBye");
}

- (void)beKilledWith:(NSString *)tool; {
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
}

@end
