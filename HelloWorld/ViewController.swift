//
//  ViewController.swift
//  HelloWorld
//
//  Created by Devang Pandya on 03/02/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {
    @IBOutlet weak var todayView : SpringView!
    let locationManager = LocationManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        
        
        animateAndShowToday()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func animateAndShowToday(){
        todayView.animation = "zoomIn"
        todayView.animate()
        todayView.delay = 2.0;
        todayView.animateToNext {
            self.todayView.animation = "zoomOut"
            self.todayView.animateTo()
        }
    }


}

