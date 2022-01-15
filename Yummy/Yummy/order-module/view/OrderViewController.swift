//
//  OrderViewController.swift
//  Yummy
//
//  Created by varol on 15.01.2022.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var addressTextLabel: UITextField!
    @IBOutlet weak var bankTextLabel: UITextField!
    @IBOutlet weak var noteTextLabel: UITextField!
    @IBOutlet weak var orderView: UIView!
    
    var orderPresenterObject: ViewToPresenterOrderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderView.layer.cornerRadius = 10.0
        OrderRouter.createModule(ref: self)

    }

    @IBAction func orderButton(_ sender: Any) {
        if let address = addressTextLabel.text,  let bank = bankTextLabel.text{
            if !address.isEmpty && !bank.isEmpty {
                orderPresenterObject?.orderInteractor?.order()
                
                
                let alertController = UIAlertController(title: "Sipariş", message: "Siparişiniz alındı.", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
                    print("iptal seçildi")
                }
                alertController.addAction(iptalAction)
                self.present(alertController, animated: true)
                 
                performSegue(withIdentifier: "toHomeByOrder", sender: nil)

            } else {
                let alertController = UIAlertController(title: "Hata", message: "Lütfen kredi kartı ve adres kısmını doldurun", preferredStyle: .alert)
                let iptalAction = UIAlertAction(title: "Tamam", style: .destructive) { action in
                    print("iptal seçildi")
                }
                alertController.addAction(iptalAction)
                self.present(alertController, animated: true)
            }
        }
    }
}
