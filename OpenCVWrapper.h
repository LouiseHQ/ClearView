//
//  OpenCVWrapper.h
//  ClearView
//
//  Created by LouiseHQ on 4/20/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import <opencv2/opencv.hpp>

@interface OpenCVWrapper : NSObject

//Define here interface with OpenCV


//function to get OpenCV version
+(NSString *) openCVVersionString;
//+(cv::Mat)cvMatFromUIImage:(UIImage *)image;
//+(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat;
+ (void) initMask: (UIImage*) inputImage ratioX:(CGFloat)ratioX ratioY:(CGFloat)ratioY;
+ (UIImage*) updateMasktransX:(int)transX transY:(int)transY brushSize:(int)brushSize;
+ (UIImage*) inpaint: (UIImage*) origImage;


@end
