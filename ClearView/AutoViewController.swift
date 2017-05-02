//
//  AutoViewController.swift
//  ClearView
//
//  Created by LouiseHQ on 5/2/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import Foundation
import UIKit

class AutoViewController: UIViewController{
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var save: UIButton!

    @IBOutlet weak var horSlider:UISlider!
    @IBOutlet weak var verSlider:UISlider!
    @IBOutlet weak var scaleSlider:UISlider!

    
    var previewImage: UIImage!
    var horizontalAngle: integer_t!
    var veritcalAngle: integer_t!
    var scale: float_t!
    //var editedImage: UIImage!
    @IBOutlet weak var editView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
//        self.brushSlider.maximumValue = 120
//        self.brushSlider.minimumValue = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editView.image = previewImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    @IBAction func doSomething(_ sender: UISlider){
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manualToPreview" {
            let pre = segue.destination as! PreviewViewController
            pre.capturedImage = previewImage
        }
    }

    
    @IBAction func backAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "autoToPreview", sender: self)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(editView.image!, nil, nil, nil)
        self.performSegue(withIdentifier: "autoSave", sender: self)
    }
    
}
