//
//  OpenCVWrapper.m
//  ClearView
//
//  Created by LouiseHQ on 4/20/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import "UIImage+Rotate.h"
//#import <opencv2/photo/photo.hpp>
//#import <CoreGraphics/CoreGraphics.h>
//#include "point.h"

@implementation OpenCVWrapper
using namespace cv;

Mat mask;
Mat origImage;
cv::Point2f prePt = {-1.0,-1.0};
float scaleX;
float scaleY;


/**
 Tryout for opencv, get version of current framework

 @return <#return value description#>
 */
+(NSString *) openCVVersionString{
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION ];
}


+(cv::Mat)cvMatFromUIImage:(UIImage *)image
{
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


+(UIImage *)UIImageFromCVMat:(cv::Mat)cvMat
{
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
                                        cvMat.step[0],                            //bytesPerRow
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

+ (void) initMask: (UIImage*) inputImage ratioX:(CGFloat)ratioX ratioY:(CGFloat)ratioY{
    UIImage* rotatedImage = [inputImage rotateToImageOrientation];
    origImage = [self cvMatFromUIImage:rotatedImage];
    scaleX = ratioX;
    scaleY = ratioY;
    mask = Mat::zeros(origImage.size(), CV_8U);
//    NSLog(@"Mask size: %i, %i", mask.rows, mask.cols);
//    NSLog(@"uiImage size: %f, %f", inputImage.size.width, inputImage.size.height);

}


/**
 Keeping track of the pan gesture and update the mask

 @param transX x coord in view
 @param transY y coord in view
 */
+ (UIImage*) updateMasktransX:(int)transX transY:(int)transY brushSize:(int)brushSize{
    cv::Point2f curPt = {static_cast<float>(scaleX*transX), static_cast<float>(scaleY*transY)};
    if (prePt.x==-1.0){
        prePt = curPt;
        UIImage* result =[self UIImageFromCVMat:origImage];
        return result;
    }
    line(mask, prePt, curPt, Scalar::all(255), brushSize, 8, 0 );
    line(origImage,prePt, curPt, Scalar::all(255), brushSize, 8, 0 );
    prePt = curPt;
    UIImage* result =[self UIImageFromCVMat:origImage];
    return result;
}



/**
 Process the orignal image to acceptable format for inpaint
 Inpaint the image and return the edited image

 @param origImage 
 @return
 */
+ (UIImage*) inpaint: (UIImage*) origImage
{
    UIImage* rotatedImage = [origImage rotateToImageOrientation];
    Mat origMat =[self cvMatFromUIImage:rotatedImage];
    Mat inpainted;
    Mat origMat8uc1;
    int type = origMat.type();
    NSLog(@"type:%i",type);
    cvtColor(origMat, origMat8uc1, CV_RGBA2RGB);
//    type = origMat8uc1.type();
//    NSLog(@"type:%i",type);
    NSLog(@"Inpaiting started");
//    type = mask.type();
//    NSLog(@"type:%i",type);
    cv::inpaint(origMat8uc1, mask, inpainted, 3, CV_INPAINT_TELEA);
    NSLog(@"Inpaiting finised");
    
    UIImage* result =[self UIImageFromCVMat:inpainted];
    return result;
}
@end
