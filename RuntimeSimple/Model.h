//
//  Model.h
//  RuntimeSimple
//
//  Created by Liu on 16/7/8.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *age;
@property (nonatomic,strong) NSArray *girls;

@end
