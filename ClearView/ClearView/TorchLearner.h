//
//  TorchLearner.h
//  ClearView
//
//  Created by Bell on 4/10/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#ifndef TorchLearner_h
#define TorchLearner_h

#import "Torch.h"
#import <Torch/Torch.h>
//#import "ClearView-Swift.h"

#define KBYTES_CLEAN_UP 10000  //10 Megabytes Max Storage Otherwise Force Cleanup
#define LUAT_STACK_INDEX_FLOAT_TENSORS 4  //Index of Garbage Collection Stack Value

@interface TorchLearner: NSObject  // <ILearner>

@property (nonatomic, strong) Torch *torch;

- (id)initWithScript: (NSString *)script;

- (void)saveToPath: (NSString *)path;

- (void)loadFromPath: (NSString *)path;

- (lua_State *)getState;

- (void)garbageCollect: (lua_State *)state;

@end

#endif /* TorchLearner_h */
