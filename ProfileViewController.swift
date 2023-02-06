//
//  ProfileViewController.swift
//  CoreNFCSample
//

import UIKit

class ProfileViewController: UIViewController {

    var username:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LabelUsername?.text = username

        // Do any additional setup after loading the view.
        //getting user data from defaults
        
    }
    
    
    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBOutlet weak var LabelUsername: UILabel!
    
    @IBOutlet weak var DeviceID: UILabel!
    
    @IBOutlet weak var LatestScan: UITableView!

}
