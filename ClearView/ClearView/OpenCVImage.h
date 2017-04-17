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

@interface OpenCVImage: NSObject

/*!
 @brief Create an object containing contents that represents (a copy of) a UIImage
 */
- (id)initWithUIImage: (UIImage *)image;

/*!
 @brief Render a UIImage based on the current object
 */
- (UIImage *)getUIImage;

@end

#endif /* OpenCVImage_h */
