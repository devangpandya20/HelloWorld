//
//  ViewController.swift
//  HelloWorld
//
//  Created by Devang Pandya on 03/02/17.
//  Copyright © 2017 Zensar. All rights reserved.
//

import UIKit
import Spring
import Gifu


class ViewController: UIViewController, LocationServiceDelegate {
    @IBOutlet weak var todayView : SpringLabel!
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var imageView : SpringImageView!
    
    let locationManager = LocationManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.todayView.textColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        self.todayView.font = UIFont(name: "Avenir-Light", size: 30)
        self.todayView.textAlignment = NSTextAlignment.center
        
        imageView.prepareForAnimation(withGIFNamed: "wine1")
        
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
        todayView.delay = 3.0;
        todayView.animateToNext {
//            self.todayView.animation = "zoomOut"
            self.todayView.text = "Not Dry Day"
            self.todayView.animateTo()
            
            self.imageView.animation = "wobble"
            self.imageView.animate()
            self.showAnimationWithGIF(gifname:"wine1")
        }
    }
    
    func showAnimationWithGIF(gifname:String){
        imageView.startAnimatingGIF()
    }
    
    
    func tracingCity(cityName : String){
        cityLabel.text = cityName
    }
    func errorLocatingCity(error : Error){
        print(error)
    }
}
extension UIImageView: GIFAnimatable {
    private struct AssociatedKeys {
        static var AnimatorKey = "gifu.animator.key"
    }
    
    override open func display(_ layer: CALayer) {
        updateImageIfNeeded()
    }
    
    public var animator: Animator? {
        get {
            guard let animator = objc_getAssociatedObject(self, &AssociatedKeys.AnimatorKey) as? Animator else {
                let animator = Animator(withDelegate: self)
                self.animator = animator
                return animator
            }
            
            return animator
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.AnimatorKey, newValue as Animator?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

