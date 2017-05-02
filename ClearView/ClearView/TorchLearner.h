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

/*!
 @brief The base Torch learner providing basic helpers
 @discussion Based on "Torch7 Library for iOS" (https://github.com/clementfarabet/torch-ios)
 */
@interface TorchLearner: NSObject  // <ILearner>
// TODO Implement ILearner interface

@property (nonatomic, strong) Torch *torch;

/*!
 @brief Create an object based on a Lua script file
 @param script The path to the script file
 */
- (id)initWithScript: (NSString *)script;

- (void)saveToPath: (NSString *)path;

- (void)loadFromPath: (NSString *)path;

/*!
 @brief Fetch the current Lua intepreter internal state
 */
- (lua_State *)getState;

/*!
 @brief Perform a garbage collection of the Lua interpreter if necessary
 @param state The current Lua intepreter internal state
 */
- (void)garbageCollect: (lua_State *)state;

@end

#endif /* TorchLearner_h */
