//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Gary Nothom on 9/8/16.
//  Copyright © 2016 LytxServices. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication

class MusicVideoDetailVC: UIViewController {
    
    var videos:Video!
    var securitySwitch:Bool = false
    
    
    func shareMedia() {
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step It UP!)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4,activity5], applicationActivities: nil)
        
        //activityViewController.excludedActivityTypes =  [UIActivityTypeMail]
        
        
        
        //        activityViewController.excludedActivityTypes =  [
        //            UIActivityTypePostToTwitter,
        //            UIActivityTypePostToFacebook,
        //            UIActivityTypePostToWeibo,
        //            UIActivityTypeMessage,
        //            UIActivityTypeMail,
        //            UIActivityTypePrint,
        //            UIActivityTypeCopyToPasteboard,
        //            UIActivityTypeAssignToContact,
        //            UIActivityTypeSaveToCameraRoll,
        //            UIActivityTypeAddToReadingList,
        //            UIActivityTypePostToFlickr,
        //            UIActivityTypePostToVimeo,
        //            UIActivityTypePostToTencentWeibo
        //        ]
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityType.mail {
                print ("email selected")
            }
            
        }
        
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func socialMedia(_ sender: UIBarButtonItem) {
        
        securitySwitch = UserDefaults.standard.bool(forKey: "SecSetting")
        
        switch securitySwitch {
            case true:
                touchIDCHeck()
            default:
                shareMedia()
        }
        
        
        //shareMedia()
    }
    
    func touchIDCHeck() {
        // Create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.cancel, handler: nil))
        
        
        // Create the Local Authentication Context
        let context = LAContext()
        var touchIDError : NSError?
        let reasonString = "Touch-Id authentication is needed to share info on Social Media"
        
        
        // Check if we can access local device authentication
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error:&touchIDError) {
            // Check what the authentication response was
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, policyError) -> Void in
                if success {
                    // User authenticated using Local Device Authentication Successfully!
                    DispatchQueue.main.async() { [unowned self] in
                        self.shareMedia()
                    }
                } else {
                    
                    alert.title = "Unsuccessful!"
                    
                    switch (policyError!) {
                    
                        
                    case LAError.appCancel:
                        alert.message = "Authentication was cancelled by application"
                        
                    case LAError.authenticationFailed:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case LAError.passcodeNotSet:
                        alert.message = "Passcode is not set on the device"
                        
                    case LAError.systemCancel:
                        alert.message = "Authentication was cancelled by the system"
                        
                    case LAError.touchIDLockout:
                        alert.message = "Too many failed attempts."
                        
                    case LAError.userCancel:
                        alert.message = "You cancelled the request"
                        
                    case LAError.userFallback:
                        alert.message = "Password not accepted, must use Touch-ID"
                        
                    default:
                        alert.message = "Unable to Authenticate!"
                        
                    }
                    
                    // Show the alert
                    DispatchQueue.main.async() { [unowned self] in
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            })
        } else {
            // Unable to access local device authentication
            
            // Set the error title
            alert.title = "Error"
            
            // Set the error alert message with more information
            switch (touchIDError!) {

            case LAError.touchIDNotEnrolled:
                  alert.message = "Touch ID is not enrolled"
               
            case LAError.touchIDNotAvailable:
                  alert.message = "TouchID is not available on the device"

            case LAError.passcodeNotSet:
                alert.message = "Passcode has not been set"
                
            case LAError.invalidContext:
                alert.message = "The context is invalid"

            default:
                alert.message = "Local Authentication not available"
            }
            
            // Show the alert
            DispatchQueue.main.async() { [unowned self] in
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }


    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
        
    }
    @IBOutlet weak var vName: UILabel!
    @IBOutlet weak var vGenre: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var vPrice: UILabel!
    @IBOutlet weak var vRights: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.vArtist
        vName.text = videos.vName
        vGenre.text = videos.vGenre
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData! as Data)
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvailable")
        }
        
        

        // Do any additional setup after loading the view.
         NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoDetailVC.preferredFontChanged), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    func preferredFontChanged() {
        print("the preferred font has changed")
    }
    
    //blow out the observers
    deinit
    {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }


}
