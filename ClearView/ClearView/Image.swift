//
//  Image.swift
//  ClearView
//
//  Created by Bell on 4/11/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import Foundation

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
}
