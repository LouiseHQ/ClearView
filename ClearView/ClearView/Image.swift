//
//  Image.swift
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import Foundation

/*!
 @brief A container for storing images for processing
 */
public class Image {
    var data: OpenCVImage
    
    /*!
     @brief Create an object containing contents that represents (a copy of) a UIImage
     */
    init(image: UIImage) {
        data = OpenCVImage(uiImage: image)
    }
    
    /*!
     @brief Render a UIImage based on the current object
     */
    func getUIImage() -> UIImage {
        return data.getUIImage()
    }
    
    func getSize() -> (Int32, Int32) {
        return (data.getHeight(), data.getWidth())
    }
    
    func scale(ratio: CGFloat) {
        data.scale(ratio);
    }
}
