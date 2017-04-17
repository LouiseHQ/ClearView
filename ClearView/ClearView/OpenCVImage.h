//
//  OpenCVImage.h
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#ifndef OpenCVImage_h
#define OpenCVImage_h

#import <UIKit/UIKit.h>

/*!
 @brief A container for storing images for processing
 @discussion Based on OpenCV (https://github.com/opencv/opencv)
 */
@interface OpenCVImage: NSObject

/*!
 @brief Create an object containing contents that represents (a copy of) a UIImage
 */
- (id)initWithUIImage: (UIImage *)image;

/*!
 @brief Render a UIImage based on the current object
 */
- (UIImage *)getUIImage;

/*!
 @brief Get the height of the image
 */
- (int)getHeight;

/*!
 @brief Get the width of the image
 */
- (int)getWidth;

/*!
 @brief Scale the image uniformly in place
 @param ratio New length divided by old length
 */
- (void)scale: (CGFloat)ratio;

@end

#endif /* OpenCVImage_h */
