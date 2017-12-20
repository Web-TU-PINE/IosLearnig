//
//  DetailViewController.swift
//  MyMapViewApp
//
//  Created by user on 11/25/2560 BE.
//  Copyright © 2560 teerapat. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var myLocationName : String = ""
    var myLocatioStreet: String = ""
    var myLocationLat: Double = 0.0
    var myLocationLong: Double = 0.0

    
    
    

    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationLat: UILabel!
    @IBOutlet weak var locationLong: UILabel!
    @IBOutlet weak var locationStreet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = myLocationName
        locationName.text = myLocationName
        locationStreet.text = myLocatioStreet
        locationLat.text = String(myLocationLat)
        locationLong.text = String(myLocationLong)

        // Do any additional setup after loading the view.
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
