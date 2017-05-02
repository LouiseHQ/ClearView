//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

#import <opencv2/opencv.hpp>
#import <Foundation/Foundation.h>
#import "NativeImageUtil.h"
#import "OpenCVImage.h"
#import "ImageProcess.h"

@interface NativeImageUtil ()

//@property (nonatomic, assign) std::shared_ptr<OpenCVImage> image;

/*!
 @brief Helper to create a cv::Mat from a UIImage
 */
+ (cv::Mat)createCVMatFromUIImage: (UIImage *)image;

/*!
 @brief Helper to create a UIImage from a cv::Mat
 */
+ (UIImage *)createUIImageFromCVMat: (cv::Mat)cvMat;

@end

@implementation NativeImageUtil

+ (UIImage *)removeReflection: (UIImage *)image {
    cv::Mat mat = [NativeImageUtil createCVMatFromUIImage: image];
    OpenCVImage cvImage(mat);
    OpenCVImage resultImage = ImageProcess::removeReflection(cvImage);
    return [NativeImageUtil createUIImageFromCVMat: resultImage.getMat()];
}

+ (cv::Mat)createCVMatFromUIImage: (UIImage *)image {
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;
    cv::Mat cvMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    CGContextRef contextRef = CGBitmapContextCreate(cvMat.data,                 // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    cvMat.step[0],              // Bytes per row
                                                    colorSpace,                 // Colorspace
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault); // Bitmap info flags
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);
    return cvMat;
}

+ (UIImage *)createUIImageFromCVMat: (cv::Mat)cvMat {
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize()*cvMat.total()];
    CGColorSpaceRef colorSpace;
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                 //width
                                        cvMat.rows,                                 //height
                                        8,                                          //bits per component
                                        8 * cvMat.elemSize(),                       //bits per pixel
                                        cvMat.step[0],                              //bytesPerRow
                                        colorSpace,                                 //colorspace
                                        kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                        provider,                                   //CGDataProviderRef
                                        NULL,                                       //decode
                                        false,                                      //should interpolate
                                        kCGRenderingIntentDefault                   //intent
                                        );
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    return finalImage;
}

@end
