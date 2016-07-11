//
//  MethodController.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/7.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "MethodController.h"
#import <objc/runtime.h>

@interface MethodController ()

@property (nonatomic,strong) Person *xiaohua;

@end

@implementation MethodController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    //获取类方法,只能获取类方法,实例方法无法获取
    Class PersonClass = object_getClass([Person class]);

    SEL oriSEL = @selector(heheda);
    
    Method oriMethod = class_getClassMethod(PersonClass, oriSEL);
    
    NSLog(@"%@",NSStringFromSelector(method_getName(oriMethod)));
    
    
    //获取实例方法,对象必须初始化,Class 不能像上面那样通过object_getClass取,直接[_xiaohua class]取得,只能获取实例方法,无法获取类方法.
    self.xiaohua = [[Person alloc] init];
    Class PersonClassX = [_xiaohua class];
    
    Method xiaoMethod = class_getInstanceMethod(PersonClassX, @selector(sayHello));
    
    NSLog(@"%@",NSStringFromSelector(method_getName(xiaoMethod)));
    
    
    //添加方法
    
    BOOL addSucc = class_addMethod([Person class], @selector(test), (IMP)drink,"s@:d");//(IMP)drink, "s@:d");
    
    
    if (addSucc) {
        Person *xiaoming = [[Person alloc] init];
        [xiaoming performSelector:@selector(test)];
    }
    
    //替换原来方法实现
    class_replaceMethod([Person class], @selector(sayByeBye), (IMP)sayLoveyou, "v@:@");
    
    //因为增加了参数,这样写能将参数导入
    [_xiaohua performSelector:@selector(sayByeBye) withObject:@"bg"];
    
    
    //交换两个方法实现 //实测,实例方法可以与类方法交换
    Method sayHello = class_getInstanceMethod([Person class], @selector(sayHello));
    Method sayHeheda = class_getClassMethod(object_getClass([Person class]), @selector(heheda));
    method_exchangeImplementations(sayHello, sayHeheda);
    
    Person *xiaohong = [[Person alloc] init];
    [xiaohong sayHello];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


short drink(id self,SEL _cmd,double num) {
    
    NSLog(@"111");
    
    return 1;
}

void sayLoveyou(id self,SEL _cmd,NSString *name) {
    NSLog(@"I love %@",name);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
