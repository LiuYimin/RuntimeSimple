//
//  GetPersonController.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/7.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "GetPersonController.h"
#import <objc/runtime.h>

#define ScreenWidth CGRectGetWidth(self.view.frame)

@interface GetPersonController ()
{
    UIScrollView *_backScrollView;
    UITextView *_propertyTextView;
    UITextView *_ivarTextView;
    UITextView *_methodTextView;
    UITextView *_protocolTextView;
}

@end

@implementation GetPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    _backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _backScrollView.scrollEnabled = YES;
    [self.view addSubview:_backScrollView];
    
    UIButton *getPropertyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getPropertyButton.frame = CGRectMake(50, 50, ScreenWidth-100, 40);
    getPropertyButton.backgroundColor = [UIColor grayColor];
    [getPropertyButton setTitle:@"获取属性" forState:UIControlStateNormal];
    [getPropertyButton addTarget:self action:@selector(getProperty) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:getPropertyButton];
    
    
    UITextView *propertyTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(getPropertyButton.frame)+20, ScreenWidth-100, 200)];
    [propertyTextView.layer setMasksToBounds:YES];
    propertyTextView.layer.borderColor = [UIColor blackColor].CGColor;
    propertyTextView.layer.borderWidth = 1;
    propertyTextView.font = [UIFont systemFontOfSize:14];
    [_backScrollView addSubview:propertyTextView];
    _propertyTextView = propertyTextView;
    
    
    UIButton *getIvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getIvarButton.frame = CGRectMake(50, CGRectGetMaxY(propertyTextView.frame)+20, ScreenWidth-100, 40);
    getIvarButton.backgroundColor = [UIColor grayColor];
    [getIvarButton setTitle:@"获取成员变量" forState:UIControlStateNormal];
    [getIvarButton addTarget:self action:@selector(getIvar) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:getIvarButton];
    
    
    UITextView *ivarTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(getIvarButton.frame)+20, ScreenWidth-100, 200)];
    [ivarTextView.layer setMasksToBounds:YES];
    ivarTextView.layer.borderColor = [UIColor blackColor].CGColor;
    ivarTextView.layer.borderWidth = 1;
    ivarTextView.font = [UIFont systemFontOfSize:14];
    [_backScrollView addSubview:ivarTextView];
    _ivarTextView = ivarTextView;
    
    
    UIButton *getMethodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getMethodButton.frame = CGRectMake(50, CGRectGetMaxY(ivarTextView.frame)+20, ScreenWidth-100, 40);
    getMethodButton.backgroundColor = [UIColor grayColor];
    [getMethodButton setTitle:@"获取方法" forState:UIControlStateNormal];
    [getMethodButton addTarget:self action:@selector(getMethod) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:getMethodButton];
    
    
    UITextView *methodTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(getMethodButton.frame)+20, ScreenWidth-100, 200)];
    [methodTextView.layer setMasksToBounds:YES];
    methodTextView.layer.borderColor = [UIColor blackColor].CGColor;
    methodTextView.layer.borderWidth = 1;
    methodTextView.font = [UIFont systemFontOfSize:14];
    [_backScrollView addSubview:methodTextView];
    _methodTextView = methodTextView;
    
    
    UIButton *getProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    getProtocolButton.frame = CGRectMake(50, CGRectGetMaxY(methodTextView.frame)+20, ScreenWidth-100, 40);
    getProtocolButton.backgroundColor = [UIColor grayColor];
    [getProtocolButton setTitle:@"获取协议" forState:UIControlStateNormal];
    [getProtocolButton addTarget:self action:@selector(getProtocol) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:getProtocolButton];
    

    UITextView *protocolTextView = [[UITextView alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(getProtocolButton.frame)+20, ScreenWidth-100, 200)];
    [protocolTextView.layer setMasksToBounds:YES];
    protocolTextView.layer.borderColor = [UIColor blackColor].CGColor;
    protocolTextView.layer.borderWidth = 1;
    protocolTextView.font = [UIFont systemFontOfSize:14];
    [_backScrollView addSubview:protocolTextView];
    _protocolTextView = protocolTextView;
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(50, CGRectGetMaxY(protocolTextView.frame)+20, ScreenWidth-100, 40);
    backButton.backgroundColor = [UIColor grayColor];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    [_backScrollView addSubview:backButton];
    
    
    _backScrollView.contentSize = CGSizeMake(ScreenWidth, CGRectGetMaxY(backButton.frame)+50);
    
    NSLog(@"%@",NSStringFromCGSize(_backScrollView.contentSize));
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Custom 

- (void)getProperty {
    unsigned int count;
    objc_property_t *personPropertyList = class_copyPropertyList([Person class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = personPropertyList[i];
        const char *propertyName = property_getName(property);
        _propertyTextView.text = [_propertyTextView.text stringByAppendingString:[NSString stringWithUTF8String:propertyName]];
        _propertyTextView.text = [_propertyTextView.text stringByAppendingString:@"\n"];
    }
}

- (void)getIvar {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivarList[i];
        const char *ivarName = ivar_getName(var);
        _ivarTextView.text = [_ivarTextView.text stringByAppendingString:[NSString stringWithUTF8String:ivarName]];
        _ivarTextView.text = [_ivarTextView.text stringByAppendingString:@"\n"];
    }
}

- (void)getMethod {
    unsigned int count;
    Method *methodList = class_copyMethodList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Method method = methodList[i];
        _methodTextView.text = [_methodTextView.text stringByAppendingString:NSStringFromSelector(method_getName(method))];
        _methodTextView.text = [_methodTextView.text stringByAppendingString:@"\n"];
    }
}

- (void)getProtocol {
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Protocol *protocol = protocolList[i];
        _protocolTextView.text = [_protocolTextView.text stringByAppendingString:[NSString stringWithUTF8String:protocol_getName(protocol)]];
        _protocolTextView.text = [_protocolTextView.text stringByAppendingString:@"\n"];
    }
}

- (void)backButton {
    [self dismissViewControllerAnimated:YES completion:nil];
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
