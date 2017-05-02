//
//  SimpleTorchLearner.m
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XorLearner.h"

@implementation XorLearner

- (id)init {
    self = [super initWithScript:@"xor"];
    [self loadFromPath:@"xor.net"];
    return self;
}

- (CGFloat)classify: (CGFloat)x and:(CGFloat)y {
    lua_State *state = [self getState];
    
    THFloatStorage *classificationStorage = THFloatStorage_newWithSize1(2);
    THFloatTensor *classification = THFloatTensor_newWithStorage1d(classificationStorage, 1, 2, 1);
    THTensor_fastSet1d(classification, 0, x);
    THTensor_fastSet1d(classification, 1, y);
    lua_getglobal(state, "classifyExample");
    luaT_pushudata(state, classification, "torch.FloatTensor");
    
    int res = lua_pcall(state, 1, 1, 0);
    if (res != 0)
        NSLog(@"Error running function `f': %s", lua_tostring(state, -1));
    
    if (!lua_isnumber(state, -1))
        NSLog(@"Function `f' must return a number");
    CGFloat returnValue = lua_tonumber(state, -1);
    
    lua_pop(state, 1);
    return returnValue;
}

@end
