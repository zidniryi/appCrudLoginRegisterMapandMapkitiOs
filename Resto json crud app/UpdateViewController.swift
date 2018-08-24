//
//  UpdateViewController.swift
//  Resto json crud app
//
//  Created by hint on 21/08/18.
//  Copyright © 2018 ZidniRyi. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON

class UpdateViewController: UIViewController {
    
    var nameTampung : String? = nil
    var priceTampung : String? = nil
    var stockTampung : String? = nil
    var idTampung : String? = nil
    
    
    @IBOutlet weak var etName: UITextField!
    @IBOutlet weak var etHarga: UITextField!
    @IBOutlet weak var etStock: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//    Tampung
        
        etStock.text = stockTampung
        etName.text = nameTampung
        etHarga.text = priceTampung
        
        // Do any additional setup after loading the view.
        

    
    }

    @IBAction func updateAction(_ sender: Any) {
        let url = "http://192.168.20.140/server_resto/index.php/api/updateMakanan"
        
        let params: [String : String] = ["name" : etName.text!,
                                         "price" : etHarga.text!,
                                         "stok" : etStock.text!,
                                         "id" : idTampung!]
        
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
                //            self.alert(title: "informasi", msg: pesan)
                
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
