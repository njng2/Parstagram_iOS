//
//  LoginViewController.swift
//  Parstagram
//
//  Created by Nancy Ng  on 3/12/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func OnSignIn(_ sender: Any) {
        let user_login = usernameField.text!
        let password_login = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: user_login, password: password_login) { (user, error) in
            if user != nil{
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else{
                print("Error: \(error?.localizedDescription)")
                
            }
        }
      
        
    }
    
    @IBAction func OnSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground {(success,error) in
            if success{
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
            else{
                print("Error: \(error?.localizedDescription)")
            }
            
            
        }
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
