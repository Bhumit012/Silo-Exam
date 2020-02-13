//
//  SiloListVC.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import CoreLocation

class SiloListVC: UIViewController, CLLocationManagerDelegate {
    var SiloData = [[String:AnyObject]]()
    let locationManager = CLLocationManager()
    var myCordinate = CLLocation()
    var SiloCordinate = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationService()
    }
    
    func locationService(){
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        myCordinate = CLLocation(latitude: 5.0, longitude: 5.0)
        SiloCordinate = CLLocation(latitude: 5.0, longitude: 3.0)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        myCordinate = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        
    }
    @IBAction func mapView(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
    
}
extension SiloListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SiloData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let siloCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SiloColCell", for: indexPath as IndexPath) as! SiloColCell
        //  gifCell.layer.borderColor = UIColor.white.cgColor
        siloCell.layer.borderWidth = 1
        siloCell.layer.cornerRadius = 1
        let imageList = self.SiloData[indexPath.row]["image_urls"] as! Array<String>
        siloCell.imgCollection.sd_setImage(with: URL(string:imageList.first!), completed: nil)
        
        let strRate =  Int( truncating: self.SiloData[indexPath.row]["rate"]! as! NSNumber)
        let footage = Int( truncating: self.SiloData[indexPath.row]["square_footage"]! as! NSNumber)
        let peopleMax = Int( truncating: self.SiloData[indexPath.row]["max_capacity"]! as! NSNumber)

       siloCell.lblDescription.text = "From " + String(strRate) + " hr . " +  String(footage) + " sq feet . up to " + String(peopleMax) + " people"

        siloCell.addressLabel.text = (self.SiloData[indexPath.row]["name"] as! String)
        SiloCordinate = CLLocation(latitude: self.SiloData[indexPath.row]["latitude"] as! CLLocationDegrees, longitude: self.SiloData[indexPath.row]["longitude"] as! CLLocationDegrees)
        siloCell.distance.text = String(format:"%.0f", (myCordinate.distance(from: SiloCordinate))/1000) + "KM"
     
        return siloCell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let siloDetail = self.storyboard?.instantiateViewController(withIdentifier: "SiloDetailVC") as! SiloDetailVC
        siloDetail.fetchedData = self.SiloData[indexPath.row]
          self.navigationController!.pushViewController(siloDetail, animated: true)
      }

}
