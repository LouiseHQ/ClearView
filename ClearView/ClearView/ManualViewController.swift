//
//  ManualViewControllor.swift
//  ClearView
//
//  Created by LouiseHQ on 4/30/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.
//

import Foundation
import UIKit

class ManualViewController: UIViewController{
@IBOutlet weak var remove: UIButton!
@IBOutlet weak var back: UIButton!
@IBOutlet weak var brushSlider:UISlider!

    var previewImage: UIImage!
    var brushSize: integer_t!
    @IBOutlet weak var save: UIButton!
    var editedImage: UIImage!
    @IBOutlet weak var editView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.remove.isHidden = true
        self.brushSlider.maximumValue = 120
        self.brushSlider.minimumValue = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editView.image = previewImage
        
        //pan recognizor
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ManualViewController.panOccured))
        view.addGestureRecognizer(pan)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func panOccured(pan:UIPanGestureRecognizer){
        self.remove.isHidden = false
        //print("Pan recognized")
        if pan.state == .began || pan.state == .changed {
            let transX = Int32(pan.location(in: self.editView).x)
            let transY = Int32(pan.location(in: self.editView).y)
            brushSize = integer_t(self.brushSlider.value)
            let curImage = OpenCVWrapper.updateMasktransX(transX, transY: transY, brushSize: brushSize)
            self.editView.image = curImage
        }
    }
    
    @IBAction func doSomething(_ sender: UISlider){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "manualToPreview" {
            let pre = segue.destination as! PreviewViewController
            pre.capturedImage = previewImage
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "manualToPreview", sender: self)
    }

    @IBAction func saveAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(editView.image!, nil, nil, nil)
        self.performSegue(withIdentifier: "manualSave", sender: self)
    }
    
/// send the captured image for editing and display
///
/// - Parameter sender: sender description
@IBAction func removeAction(_ sender: UIButton) {
    //guard let cgImage = image?.cgImage?.copy() else {
    //      return
    //    }
    //let image0 = UIImage(cgImage: cgImage,scale: image!.scale,orientation: image!.imageOrientation)
    editedImage = OpenCVWrapper.inpaint(previewImage)
    self.editView.image = editedImage;
}

}
