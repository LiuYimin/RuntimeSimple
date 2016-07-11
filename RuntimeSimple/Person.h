//
//  Person.h
//  RuntimeSimple
//
//  Created by Liu on 16/7/7.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _hadCar;
    NSString *_son;
}

@property (nonatomic,assign) NSInteger age;
@property (nonatomic,assign) float height;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSArray *info;


- (void)sayHello;
- (void)makeLove;
- (void)sayByeBye;
- (void)beKilledWith:(NSString *)tool;
+ (void)heheda;

@end
