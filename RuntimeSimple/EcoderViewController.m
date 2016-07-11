//
//  EcoderViewController.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/8.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "EcoderViewController.h"
#import <objc/runtime.h>

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width


@interface EcoderViewController ()
{
    UITextField *_infoTextField;
    UILabel *_infoText;
    UILabel *_infoLabel;
    NSInteger state;//0:输入姓名 1:输入年龄 2:输入girls
    Model *_customModel;
    NSString *_homePath;
}

@end

@implementation EcoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *homeDictionary = NSHomeDirectory();//获取根目录
    _homePath  = [homeDictionary stringByAppendingPathComponent:@"atany.archiver"];//添加储存的文件名
    
//    Model *model = [[Model alloc] init];
//    model.name = @"刘";
//    model.age = @12;
//    model.girls = @[@"a",@"n",@"c"];
//    NSMutableData *data = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    [archiver encodeObject:model forKey:@"Liu"];
//    [archiver finishEncoding];//这一行不能少,而且要写在下面一行的前面
//    [data writeToFile:homePath atomically:YES];
//    
//    //解档
//    NSData *modelData = [NSData dataWithContentsOfFile:homePath];
//    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:modelData];
//    Model *Liu = [unArchiver decodeObjectForKey:@"Liu"];
//    NSLog(@"%@,%@,%@",Liu.name,Liu.age.stringValue,Liu.girls);
//    
    
    [self setUI];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUI {
    _infoTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, ScreenWidth-100, 50)];
    _infoTextField.placeholder = @"请输入姓名";
    [_infoTextField.layer setMasksToBounds:YES];
    _infoTextField.layer.borderColor = [UIColor blueColor].CGColor;
    _infoTextField.layer.borderWidth = 1;
    [self.view addSubview:_infoTextField];
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(50, CGRectGetMaxY(_infoTextField.frame)+10, ScreenWidth-100, 50);
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    submitButton.backgroundColor = [UIColor brownColor];
    [submitButton addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitButton];
    
    _infoText = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(submitButton.frame)+20, ScreenWidth-100, 200)];
    _infoText.font = [UIFont systemFontOfSize:13];
    _infoText.numberOfLines = 0;
    [_infoText.layer setMasksToBounds:YES];
    _infoText.layer.borderWidth = 1;
    _infoText.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:_infoText];
    
    
    UIButton *getInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    getInfo.frame = CGRectMake(50, CGRectGetMaxY(_infoText.frame)+20, ScreenWidth-100, 50);
    getInfo.backgroundColor = [UIColor brownColor];
    [getInfo setTitle:@"解档" forState:UIControlStateNormal];
    [getInfo addTarget:self action:@selector(getInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getInfo];
    
    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(getInfo.frame)+10, ScreenWidth-100, 200)];
    [_infoLabel.layer setMasksToBounds:YES];
    _infoLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    _infoLabel.layer.borderWidth = 1;
    _infoLabel.numberOfLines = 0;
    _infoLabel.text = @"";
    [self.view addSubview:_infoLabel];
}

- (void)ensure {
    switch (state) {
        case 0:
        {
            if (_customModel == nil) {
                _customModel = [[Model alloc] init];
            }
            _customModel.name = _infoTextField.text;
            _infoTextField.text = @"";
            _infoTextField.placeholder = @"请输入年龄";
            _infoText.text = [NSString stringWithFormat:@"姓名:%@\n",_customModel.name];
            state = 1;
        }
            break;
        case 1:
        {
            if (_customModel == nil) {
                return;
            }
            _customModel.age = [NSNumber numberWithInteger:[_infoTextField.text integerValue]];//[NSNumber numberWithInteger:(NSInteger)_infoTextField.text];
            _infoTextField.text = @"";
            _infoTextField.placeholder = @"请输入Girls,用逗号隔开";
            _infoText.text = [_infoText.text stringByAppendingString:[NSString stringWithFormat:@"年龄:%@\n",_customModel.age.stringValue]];
            state = 2;
        }
            break;
        case 2:
        {
            if (_customModel == nil) {
                return;
            }
            
            _customModel.girls = [_infoTextField.text componentsSeparatedByString:@","];
            _infoTextField.text = @"";
            _infoTextField.placeholder = @"信息录取完成";
            _infoText.text = [_infoText.text stringByAppendingString:[NSString stringWithFormat:@"Girls:%@\n",_customModel.girls]];
            state = 0;
            [self readyArchiver];
        }
            break;
            
        default:
            break;
    }
}

- (void)readyArchiver {
    [NSThread sleepForTimeInterval:1];
   
    _infoTextField.text = [NSString stringWithFormat:@"正在归档到:%@",_homePath];
    _infoTextField.adjustsFontSizeToFitWidth = YES;
    
    
    UIAlertController * altController = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *key = altController.textFields.firstObject;
        [self archiverWith:key.text];
    }];
    [altController addAction:okAction];
    [altController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入归档Key";
    }];
    [self presentViewController:altController animated:YES completion:nil];
}

- (void)archiverWith:(NSString *)key {
    
    if ([key isEqualToString:@""]) {
        NSLog(@"归档失败");
        return;
    }
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_customModel forKey:key];
    [archiver finishEncoding];//这一行不能少,而且要写在下面一行的前面
    [data writeToFile:_homePath atomically:YES];
}

- (void)getInfo {
    UIAlertController *altController = [UIAlertController alertControllerWithTitle:@"提示" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *key = altController.textFields.firstObject;
        [self unAirchiver:key.text];
    }];
    [altController addAction:okAction];
    [altController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入Key值";
    }];
    [self presentViewController:altController animated:YES completion:nil];
}

- (void)unAirchiver:(NSString *)key {
    // 解档
    NSData *modelData = [NSData dataWithContentsOfFile:_homePath];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:modelData];
    Model *getModel = [unArchiver decodeObjectForKey:key];
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Model class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivarList[i];
        const char * name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [getModel valueForKey:key];
        const char *type = ivar_getTypeEncoding(var);
        NSString *oType = [NSString stringWithUTF8String:type];
        
        NSString *addString = @"";
        if ([oType isEqualToString:@"@\"NSString\""]) {
            addString = value;
        }else if ([oType isEqualToString:@"@\"NSNumber\""]) {
            addString = [value stringValue];
        }else if ([oType isEqualToString:@"@\"NSArray\""]) {
            NSArray *tmp = value;
            for (NSInteger j = 0; j<tmp.count; j++) {
                if ([tmp[j] isKindOfClass:[NSString class]]) {
                    addString = [addString stringByAppendingString:tmp[j]]; //这里发现一个知识点,如果addString 初始化为nil,用这个方法添加无效,一直是nil
                    addString = [addString stringByAppendingString:@","];
                }
            }
        }else {
            //...
        }
        
        _infoLabel.text = [_infoLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@\n",addString]];
        
    }
    free(ivarList);
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
