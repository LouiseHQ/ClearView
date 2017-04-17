//
//  BaseLearner.swift
//  ClearView
//
//  Created by Bell on 4/10/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import Foundation

/*!
 @brief Base interface of all learners
 */
@objc public protocol ILearner {
    
    /*!
     @brief Save the current model to a file
     @param path The path of the file
     */
    func saveTo(path: String)
    
    /*!
     @brief Load the model from a file
     @param path The path of the file
     */
    func loadFrom(path: String)
    
}
