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

@interface XorLearner: TorchLearner

- (id)init;

- (CGFloat)classify: (CGFloat)x and:(CGFloat)y;

@end

#endif /* SimpleTorchLearner_h */
