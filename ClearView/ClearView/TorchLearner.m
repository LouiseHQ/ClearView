//
//  TorchLearner.m
//  ClearView
//
//  Created by Bell on 4/10/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TorchLearner.h"

@implementation TorchLearner

- (id)initWithScript: (NSString *)script {
    self.torch = [Torch new];
    [self.torch initialize];
    [self.torch runMain:script inFolder:@"Lua"];
    return self;
}

- (void)saveToPath: (NSString *)path {
    // TODO
}

- (void)loadFromPath: (NSString *)path {
    [self.torch loadFileWithName:path inResourceFolder:@"Lua" andLoadMethodName:@"loadNeuralNetwork"];
}

- (lua_State *)getState {
    return [self.torch getLuaState];
}

- (void)garbageCollect: (lua_State *)state {
    NSInteger garbage_size_kbytes = lua_gc(state, LUA_GCCOUNT, LUAT_STACK_INDEX_FLOAT_TENSORS);
    
    if (garbage_size_kbytes >= KBYTES_CLEAN_UP) {
        NSLog(@"LUA -> Cleaning Up Garbage");
        lua_gc(state, LUA_GCCOLLECT, LUAT_STACK_INDEX_FLOAT_TENSORS);
    }
}

@end
