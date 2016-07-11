//
//  Model.m
//  RuntimeSimple
//
//  Created by Liu on 16/7/8.
//  Copyright © 2016年 Liu. All rights reserved.
//

#import "Model.h"
#import <objc/runtime.h>



#define encodeRuntime(A) \
unsigned int count;\
Ivar *ivarList = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
    Ivar var = ivarList[i];\
    const char * name = ivar_getName(var);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [self valueForKey:key];\
    [aCoder encodeObject:value forKey:key];\
}\
free(ivarList);\
\

#define initCoderRuntime(A) \
unsigned int count;\
Ivar *ivarList = class_copyIvarList([A class], &count);\
for (int i = 0; i<count; i++) {\
    Ivar var = ivarList[i];\
    const char * name = ivar_getName(var);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [aDecoder decodeObjectForKey:key];\
    [self setValue:value forKey:key];\
}\
free(ivarList);\
\

@implementation Model

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivarList[i];
        const char * name = ivar_getName(var);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivarList);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        unsigned int count;
        Ivar *ivarList = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar var = ivarList[i];
            const char * name = ivar_getName(var);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivarList);
    }
    return self;
}


@end
