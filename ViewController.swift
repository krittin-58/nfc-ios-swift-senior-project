//
//  ViewController.swift
//  CoreNFCSample
//

import UIKit
import CoreNFC
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper

struct Product : Codable{
    let productId: String?
    let productName: String?
    let productBrand: String?
    let productCategory: String?
    let productColor: String?
    let productPrice: String?
    
}

class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {
    
    
    var products = [Product]()
    
    // แสดงข้อมูลจาก Service API
    @IBOutlet weak var infoTextView: UITextView!
    
    // Login Page
    //let URL_USER_LOGIN = "http://www.youite.com/yeen/login.php" // http://www.youite.com/yeen/login.php?username=5806914&password=coptercopter
    //let defaultValues = UserDefaults.standard
    
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    
    @IBAction func buttonLogin(_ sender: UIButton) {
        
        Alamofire.request("http://www.youite.com/yeen/login.php?username=\(textFieldUsername.text!)&password=\(textFieldPassword.text!)").validate(statusCode: 200..<500).responseJSON { (responseData) -> Void in
            //let statusCode = (responseData.response?.statusCode)!
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
                
                
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller")
                self.present(vc!, animated: true, completion: nil)
            }
        
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    private func presentLoginScreenViewController() {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewcontroller")
        self.present(loginVC, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        let nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.alertMessage = "Hold iPhone near NFC tag."
        nfcSession.begin()
        
    } 
    
    @IBAction func startScanTag(_ sender: Any) {
        let nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession.alertMessage = "Hold iPhone near NFC tag."
        nfcSession.begin()
    }
    
    // Save Tag Scan
    @IBAction func saveTagToDB(_ sender: Any) {
    }
    
    // Reset Scan
    @IBAction func resetDataScan(_ sender: Any) {
        self.resetScanTag()
    }
    
    
    public func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Your Session was invalidated - ", error.localizedDescription)
    }
    
    public func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        
        var result = ""
        for record in messages[0].records {
            result += String.init(data: record.payload, encoding: .utf8)!
        }
        
        
        let URL_API = "http://www.youite.com/yeen/productGet.php?productId=20"  // ("Meal: \(mealPreference)")  as String // + result
        Alamofire.request(URL_API).responseJSON { response in
            let json = response.data
            
            do
            {
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                self.products = try decoder.decode([Product].self, from: json!)
                
                //printing all the hero names
                for product in self.products{
                    self.infoTextView.text += "รหัสสินค้า: \(product.productId!) \n\n" + "ชื่อสินค้า: \(product.productName!) \n\n" + "ยี่ห้อสินค้า: \(product.productBrand!) \n\n" + "ประเภทสินค้า: \(product.productCategory!) \n\n" + "สีของสินค้า: \(product.productColor!) \n\n" + "ราคาสินค้า: \(product.productPrice!) บาท"
                }
                
            } catch let err {
                print(err)
            }
        }
        
    } // end readerSession

    // ล้างค่าหลังจาก Scan Tag
    public func resetScanTag() {
        self.infoTextView.text = ""
    }
}

