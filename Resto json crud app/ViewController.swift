//
//  ViewController.swift
//  Resto json crud app
//
//  Created by hint on 21/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etPrice: UITextField!
    @IBOutlet weak var etStock: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func insertServer(_ sender: Any) {
        
//        Cek text filed kosong apa gak
        
        if etStock.text == "" && etPrice.text == "" && etName.text == "" {
//            Tampil Alert
        }else{
         
//            Pastekan ke Update Action
            let url = "http://192.168.20.140/server_resto/index.php/api/tambahMakanan"
            
            let params: [String : String] = ["name" : etName.text!,
                          "price" : etPrice.text!,
                          "stok" : etStock.text!]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON(completionHandler: { (responeseInsert) in
                
//                Get respones
                let json = JSON(responeseInsert.result.value as Any)
                let pesan = json["pesan"].stringValue
                let sukses = json["sukses"].boolValue
                
//                Check response
                if sukses{
                    
//                    Pindah ke menu resto
                    
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    
                }else{
                    self.alert(title: "informasi", msg: pesan)
                    
                }
                
            })
            
        }
    }
    
//    Membuat Functiion Alert
    func alert(title : String, msg : String){
        let alert = UIAlertController(title: title, message : msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion : nil)
    }
    
}

