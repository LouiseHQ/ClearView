//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#ifndef OpenCVImage_h
#define OpenCVImage_h

#import <UIKit/UIKit.h>

/*!
 @brief A utility for images processing
 @discussion Based on OpenCV (https://github.com/opencv/opencv)
 */
@interface NativeImageUtil: NSObject

/*!
 @brief Attempt to remove reflection on the image
 */
+ (UIImage *)removeReflection: (UIImage *)image;

@end

#endif /* OpenCVImage_h */
