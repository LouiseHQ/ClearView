//
//  WelcomePage.swift
//  ClearView
//
//  Created by LouiseHQ on 4/17/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import Foundation
import UIKit

class WelcomePageViewController: UIViewController {
    @IBOutlet weak var Background: UIImageView!
    @IBOutlet weak var openCVLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //display openCV version
        openCVLabel.text = OpenCVWrapper.openCVVersionString()
        
        //set background image
        let welcomeImage = UIImage(named: "./icon/welcome.jpg") as UIImage?
        self.Background.image = welcomeImage
        
        //tap recognizer to enter
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(WelcomePageViewController.connected(_:)))
        Background.isUserInteractionEnabled = true
        Background.addGestureRecognizer(tapGestureRecognizer)
        
        
        
    }
    func connected(_ sender:AnyObject){
        self.performSegue(withIdentifier: "main", sender: self);
    }
}
