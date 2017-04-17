//
//  BaseLearner.swift
//  ClearView
//
//  Created by Bell on 4/10/17.
//  Copyright © 2017 Xiaotian Le. All rights reserved.
//

import Foundation

@objc public protocol ILearner {
    func saveTo(path: String)
    func loadFrom(path: String)
}
