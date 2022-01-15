//
//  SignViewController.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import UIKit
import Firebase

class SignViewController: UIViewController {

    @IBOutlet weak var userNameTextLabel: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    @IBOutlet weak var viewLayer: UIView!
    
    var signPresenterObject: ViewToPresenterSignProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewLayer.layer.cornerRadius = 10
        

    }
    
    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: userNameTextLabel.text!, password: passwordTextLabel.text!){ authResult, error in
            if let error = error {
                print(error)
                let alertController = UIAlertController(title: "Üyelik", message: "Lütfen geçerli input girin", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
                    
                }
                alertController.addAction(iptalAction)
                self.present(alertController, animated: true)
                return
            }
            else {
                let alertController = UIAlertController(title: "Üyelik", message: "Üyelik işleminiz tamamlandı", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
                    
                }
                alertController.addAction(iptalAction)
                self.present(alertController, animated: true)
            }
          }
    }
    
    @IBAction func signInButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: userNameTextLabel.text!, password: passwordTextLabel.text!) { [weak self] authResult, error in
            if let error = error {
                print(error)
                let alertController = UIAlertController(title: "Hata", message: "Hatalı giriş yaptınız", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
                    
                }
                alertController.addAction(iptalAction)
                self?.present(alertController, animated: true)
                return
            } else {
                self?.performSegue(withIdentifier: "toHome", sender: nil)
            }
        }
    }
    
}
