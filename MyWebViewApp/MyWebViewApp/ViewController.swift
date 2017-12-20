//
//  ViewController.swift
//  MyWebViewApp
//
//  Created by Teerapat Thong-o on 20/12/17.
//  Copyright © 2017 Teerapat Thong-o. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myWebView.navigationDelegate = self
        let myURL = URL(string: "https://www.google.co.th/maps/place/True+Incube+Space")
        let myRequest = URLRequest(url: myURL!)
        myWebView.load(myRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // set hide status bar if true
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        let alertController = UIAlertController(title: "เกิดข้อผิดพลาด", message: "ไม่สามารถเชื่อมต่ออินเทอร์เน็ตได้", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default)
        { (action) -> Void in
            exit(0)
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }

}

