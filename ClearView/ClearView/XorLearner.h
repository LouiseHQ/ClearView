//
//  SimpleTorchLearner.h
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#ifndef SimpleTorchLearner_h
#define SimpleTorchLearner_h

#import "TorchLearner.h"

/*!
 @brief A simple Torch classifier trained with the XOR function
 @discussion The XOR function here is defined as
             1, if x * y < 0
             -1, if x * y > 0
 */
@interface XorLearner: TorchLearner

- (id)init;

/*!
 @brief classify the input
 */
- (CGFloat)classify: (CGFloat)x and:(CGFloat)y;

@end

#endif /* SimpleTorchLearner_h */
