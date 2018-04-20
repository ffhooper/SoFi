//
//  ViewController.swift
//  SoFi
//
//  Created by Riley Hooper on 3/31/18.
//  Copyright © 2018 Riley Hooper. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MessageUI

class ViewController: UIViewController {
    
    @IBOutlet weak var profileInfoLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    
    var imageURLS = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let members = loadJson()
        profileInfoLabel.text = members?.first?.bio
        if let members = members {
            for member in members {
                if let url = member.avatar {
                    imageURLS.append(url)
                }
            }
        }
        loadImagesIntoView()
    }
    
    /// Parse data from team.json file.
    ///
    /// - Returns: Array of member object.
    func loadJson() -> [Member]? {
        if let url = Bundle.main.url(forResource: "team", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Member].self, from: data)
                return jsonData
            } catch {
                presentAlert(title: "Error", message: "\(error)")
            }
        }
        return nil
    }
    
    /// Download single image of the web.
    ///
    /// - Parameters:
    ///   - url: Location of image.
    ///   - imageView: Which uiimageView to load it into.
    func dowmloadImages(url: String, imageView: UIImageView) {
        Alamofire.request(url).responseImage { response in
            if let error = response.error?.localizedDescription {
                self.presentAlert(title: "Load Failed", message: error)
            }
            if let image = response.result.value {
                imageView.image = image
            }
        }
    }
    
    /// Fetch all images from internet.
    func loadImagesIntoView() {
        dowmloadImages(url: imageURLS[10], imageView: mainImage)
        dowmloadImages(url: imageURLS[2], imageView: image1)
        dowmloadImages(url: imageURLS[3], imageView: image2)
        dowmloadImages(url: imageURLS[7], imageView: image3)
        dowmloadImages(url: imageURLS[5], imageView: image4)
        dowmloadImages(url: imageURLS[9], imageView: image5)
    }
    
    /// Reload images in view.
    @IBAction func fetchImages(_ sender: UIBarButtonItem) {
        loadImagesIntoView()
    }
    
    /// Send screenshot in compose email to send to developers.
    @IBAction func saveScreenshot(_ sender: UIBarButtonItem) {
        if let image = takeScreenshot() {
            if MFMailComposeViewController.canSendMail() {
                let mailComposeVC = MFMailComposeViewController()
                mailComposeVC.mailComposeDelegate = self
                mailComposeVC.addAttachmentData(UIImageJPEGRepresentation(image, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "test.jpeg")
                mailComposeVC.setSubject("Screenshot from Riley's coding challenge")
                mailComposeVC.setToRecipients(["cpratt@sofi.org", "tlawson@sofi.org"])
                mailComposeVC.setMessageBody("Screenshot sent from Riley Hooper's coding challenge.", isHTML: false)
                self.present(mailComposeVC, animated: true, completion: nil)
            } else {
                presentAlert(title: "Email not available", message: "Please make sure you are signed into an email account in order to send the message.")
            }
        } else {
            presentAlert(title: "Screenshot failed.", message: "")
        }
    }
    
    /// Remove image from imageView.
    @IBAction func removeImage(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            mainImage.image = nil
        case 2:
            image1.image = nil
        case 3:
            image2.image = nil
        case 4:
            image3.image = nil
        case 5:
            image4.image = nil
        case 6:
            image5.image = nil
        default:
            break
        }
    }
    
    /// Take screenshot of app.
    ///
    /// - Returns: The saved screenshot.
    func takeScreenshot() -> UIImage? {
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshotImage
    }
    
    /// Create and present alert to user.
    ///
    /// - Parameters:
    ///   - title: Title of the alert.
    ///   - message: Body of the alert.
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated:true, completion:nil)
    }
    
    /// Hide status bar.
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
            self.dismiss(animated: true, completion: {
                self.presentAlert(title: "Email sent", message: "")
            })
        case .failed:
            self.dismiss(animated: true, completion: {
                if let error = error?.localizedDescription {
                    self.presentAlert(title: "Email Failed", message: error)
                } else {
                    self.presentAlert(title: "Email failed to send", message: "")
                }
            })
        default:
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}

