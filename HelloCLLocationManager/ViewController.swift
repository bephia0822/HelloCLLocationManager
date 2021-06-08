//
//  ViewController.swift
//  HelloCLLocationManager
//
//  Created by Sophia Wang on 2021/3/26.
//

import UIKit
import MapKit
import CoreLocation    //為了知道使用者位置

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest  //精準度
        locationManager?.activityType = .automotiveNavigation  //模式（xcode會根據模式來設定省電模式之類）
        locationManager?.startUpdatingLocation()  //每次手機移動更新地點時會觸發
        
        if let coordinate = locationManager?.location?.coordinate{
            let xScale: CLLocationDegrees = 0.01
            let yScale: CLLocationDegrees = 0.01
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: yScale, longitudeDelta: xScale)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            map.setRegion(region, animated: true)
        }
        map.userTrackingMode = .followWithHeading   //讓使用者所在位置保持在中心點
    }
    
    //得到新的座標
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("-------------------------------------------")
        print(locations[0].coordinate.latitude)
        print(locations[0].coordinate.longitude)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager?.stopUpdatingLocation()    //離開畫面就不再更新地理資訊
    }


}

