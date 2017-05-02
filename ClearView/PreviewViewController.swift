//
//  PreviewViewController.swift
//  ClearView
//
//  Created by LouiseHQ on 4/18/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class PreviewViewController: UIViewController, AVCapturePhotoCaptureDelegate{
    @IBOutlet weak var retake: UIButton!
    @IBOutlet weak var auto: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var manual: UIButton!
    @IBOutlet weak var previewView: UIImageView!
    //@IBOutlet weak var WideView: UIImageView!
    
    var capturedImage: UIImage!
    
    
    //override default viewWillAppear setting up sessions for live videopreview
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.previewView.image = capturedImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //lauch in imageview
        previewView.image = capturedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewToManual" {
            let pre = segue.destination as! ManualViewController
            pre.previewImage = capturedImage
        }
    }
    
    @IBAction func retakeAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToCamera", sender: self)
    }
    
    @IBAction func autoAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "backToCamera", sender: self)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.previewView.image!, nil, nil, nil)
        self.performSegue(withIdentifier: "saveOrig", sender: self)
    }
    @IBAction func manualAction(_ sender: UIButton) {
        let ratioX = capturedImage.size.width/self.previewView.frame.size.width
        let ratioY = capturedImage.size.height/self.previewView.frame.size.height
        print(capturedImage.size)
        print(previewView.frame.size)
        OpenCVWrapper.initMask(capturedImage, ratioX:ratioX, ratioY:ratioY);
        self.performSegue(withIdentifier: "previewToManual", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
