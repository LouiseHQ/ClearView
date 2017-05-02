//
//  ViewController.swift
//  ClearView
//
//  Created by LouiseHQ on 4/11/17.
//  Copyright © 2017 LouiseHQ. All rights reserved.≠
//  Reference: http://stackoverflow.com/questions/37869963/how-to-use-avcapturephotooutput
//
import UIKit
import AVFoundation

class  ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCapturePhotoCaptureDelegate { //,UIPickerViewDelegate, UIPickerViewDataSource
    
    //@IBOutlet weak var manual: UIButton!
    //@IBOutlet weak var Auto: UIButton!
    //var pickerData: [String] = [String]()
    
    @IBOutlet weak var Snap: UIButton!
    @IBOutlet weak var SavePhoto: UIButton!
    @IBOutlet weak var CameraView: UIImageView!
    
    //buttons and view areas
    @IBOutlet weak var PhotoLibrary: UIButton!
    

    //instant variables
    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturedImage:UIImage!
    var mask:UIImage!
    var editedImage:UIImage!
    
    //override default viewWillAppear setting up sessions for live videopreview
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //setting icons for all the buttons
        let snapImage = UIImage(named: "./icon/snap.png") as UIImage?
        let libraryImage = UIImage(named: "./icon/library.png") as UIImage?
        let saveImage = UIImage(named: "./icon/save.png") as UIImage?
        
        self.Snap.setBackgroundImage(snapImage, for :UIControlState.normal)
        self.PhotoLibrary.setBackgroundImage(libraryImage, for :UIControlState.normal)
       
        self.SavePhoto.setBackgroundImage(saveImage, for :UIControlState.normal)
        self.SavePhoto.isHidden = true
        
//        self.Auto.setBackgroundImage(autoImage, for: UIControlState.normal)
//        self.Auto.isHidden = true
//        self.manual.setBackgroundImage(manualImage, for: UIControlState.normal)
//        self.manual.isHidden = true
        
        //self.CameraView.frame.size.height = 552
        //start live camera here
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        photoOutput = AVCapturePhotoOutput()
        
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        if let input = try? AVCaptureDeviceInput(device: device) {
            if (captureSession.canAddInput(input)) {
                captureSession.addInput(input)
                if (captureSession.canAddOutput(photoOutput)) {
                    captureSession.addOutput(photoOutput)
                    videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                    CameraView.layer.addSublayer(videoPreviewLayer)
                    captureSession.startRunning()
                }
            } else {
                print("issue here : captureSession.canAddInput")
            }
        } else {
            print("some problem here")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //lauch live camera session
        //videoPreviewLayer!.bounds = CameraView.bounds
        videoPreviewLayer!.frame = CameraView.frame
        videoPreviewLayer!.frame.origin.y = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.EditOptions.delegate = self
//        self.EditOptions.dataSource = self
//        pickerData = ["Auto", "Manual"]
//        self.EditOptions.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //grant view access to photo library
    @IBAction func PhotoLibraryAction(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary //make sure the button is linked to photo library
        present(picker, animated: true, completion: nil)
        
    }
    
//    func panOccured(pan:UIPanGestureRecognizer){
//        //print("Pan recognized")
//        if pan.state == .began || pan.state == .changed {
//            let transX = Int32(pan.location(in: self.CameraView).x)
//            let transY = Int32(pan.location(in: self.CameraView).y)
//            OpenCVWrapper.updateMasktransX(transX, transY: transY)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "preview" {
            let pre = segue.destination as! PreviewViewController
            pre.capturedImage = capturedImage
        }
    }
    
    
    //this capture the return photo
    @IBAction func SnapAction(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        let previewPixelType = settings.availablePreviewPhotoPixelFormatTypes.first!
        let previewFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: previewPixelType,
            kCVPixelBufferWidthKey as String: 160,
            kCVPixelBufferHeightKey as String: 160
        ]
        settings.previewPhotoFormat = previewFormat
        photoOutput.capturePhoto(with: settings, delegate: self)
        self.SavePhoto.isHidden=false
        self.Snap.isHidden = true
        self.PhotoLibrary.isHidden = true
        //videoPreviewLayer.isHidden = true
    }
    
    //call back function for capturePhoto
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            print("error occure : \(error.localizedDescription)")
        }
        
        if  let sampleBuffer = photoSampleBuffer,
            let previewBuffer = previewPhotoSampleBuffer,
            let dataImage =  AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer:  sampleBuffer, previewPhotoSampleBuffer: previewBuffer) {
            print(UIImage(data: dataImage)?.size as Any)
            
            let dataProvider = CGDataProvider(data: dataImage as CFData)
            let cgImageRef: CGImage! = CGImage(jpegDataProviderSource: dataProvider!, decode: nil, shouldInterpolate: true, intent: .defaultIntent)
            capturedImage = UIImage(cgImage: cgImageRef, scale: 1.0, orientation: UIImageOrientation.right)
            let rect = AVMakeRect(aspectRatio: capturedImage.size, insideRect: CameraView.bounds)
            capturedImage.draw(in: CameraView.frame)
            print(capturedImage.size)
            
            self.CameraView.image = capturedImage
            captureSession.stopRunning()
            self.performSegue(withIdentifier: "preview", sender: self);
        } else {
            print("some error here")
        }
    }
    
    //fuction for save photo button and start the video preview again
    @IBAction func saveAction(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(capturedImage, nil, nil, nil)
        captureSession.startRunning()
        self.PhotoLibrary.isHidden=false
        self.Snap.isHidden = false
        self.SavePhoto.isHidden = true
        videoPreviewLayer.isHidden = false
    }
    
    
       
    
//    /// switching to the interface for auto mode
//    ///
//    /// - Parameter sender: <#sender description#>
//    @IBAction func AutoAction(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "edit", sender: self)
//    }
//    
//    
//    /// Calculate the ratio difference and init the mask
//    ///
//    /// - Parameter sender: <#sender description#>
//    @IBAction func ManualAction(_ sender: UIButton) {
//        let ratioX = capturedImage.size.width/self.CameraView.frame.size.width
//        let ratioY = capturedImage.size.height/self.CameraView.frame.size.height
//        OpenCVWrapper.initMask(capturedImage, ratioX:ratioX, ratioY:ratioY);
//    }
    
}


