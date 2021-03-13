//
//  CaptureViewController.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/13/21.
//

import UIKit
import AlamofireImage
import Alamofire
import Parse

class CaptureViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //posts to parstagram
    @IBAction func Post(_ sender: Any) {
        //can put keys and values in here
        //creates dictionary
        let posts = PFObject(className: "Posts")
        
        posts["Caption"] = commentField.text!
        posts["Author"] = PFUser.current()
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        posts["image"] = file
        
        posts.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            }
            else{
                print("error")
            }
        }
    }
    
    //opens camera
    @IBAction func onCameraTap(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated:true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width:300, height:300)
        
        let image_scale = image.af_imageScaled(to: size)
        imageView.image = image_scale
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
