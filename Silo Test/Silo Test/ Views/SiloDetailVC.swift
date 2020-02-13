//
//  SiloDetailVC.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import CoreLocation
import MapKit

class SiloDetailVC: UIViewController {
    @IBOutlet weak var collectionVImages: UICollectionView!
    @IBOutlet weak var colAmenities: UICollectionView!
    @IBOutlet weak var colEquipment: UICollectionView!
    var fetchedData = [String:AnyObject]()
    @IBOutlet weak var lblTimeOpen: UILabel!
    @IBOutlet weak var daysOpenedLbl: UILabel!
    @IBOutlet weak var siloAddress: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var siloDetails: UILabel!
    @IBOutlet weak var siloName: UILabel!
    @IBOutlet weak var siloLocationInfo: UITextView!
    var imageList: Array<String> = [];
    var amenList: Array<String> = [];
    var eqipList: Array<String> = [];
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapPin()
        setUpInfo()
    }
    func setUpInfo(){
        let strRate =  Int( truncating: fetchedData["rate"]! as! NSNumber)
        let footage = Int( truncating: fetchedData["square_footage"]! as! NSNumber)
        let peopleMax = Int( truncating: fetchedData["max_capacity"]! as! NSNumber)
        imageList = fetchedData["image_urls"] as! Array<String>
        amenList = fetchedData["amenities"] as! Array<String>
        eqipList = fetchedData["equipments"] as! Array<String>
        siloDetails.text = "From " + String(strRate) + " hr . " +  String(footage) + " sq feet . up to " + String(peopleMax) + " people"
        siloName.text = fetchedData["name"] as? String
        siloAddress.text = fetchedData["address"] as? String
        siloLocationInfo.text = fetchedData["description"] as? String
        lblTimeOpen.text = fetchedData["open_days"] as? String
        daysOpenedLbl.text = fetchedData["open_hours"] as? String
    }
    
    func setUpMapPin(){
        
        let silo = MKPointAnnotation()
        silo.title = fetchedData["name"] as? String
        silo.coordinate = CLLocationCoordinate2D(latitude: fetchedData["latitude"] as! CLLocationDegrees, longitude:fetchedData["longitude"] as! CLLocationDegrees)
        map.addAnnotation(silo)
        self.map.showAnnotations(self.map.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView()
        if (fetchedData["status"] as? String == "coming_soon"){
            annotationView.pinTintColor = .red
        }
        else{
            annotationView.pinTintColor = .green
        }
        return annotationView
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SiloDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionVImages{
            return imageList.count ;
        }else if collectionView == colAmenities{
            return amenList.count ;
        }else{
            return eqipList.count ;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionVImages{
            let siloCellImg:scrollColCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath as IndexPath) as! scrollColCell
            siloCellImg.imgSilo.sd_setImage(with: NSURL(string: imageList[indexPath.row] as String) as URL? as URL?, completed: nil)
            
            return siloCellImg
        }else if collectionView == colAmenities{
            let siloCellAmen:siloDetailEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenCell", for: indexPath as IndexPath) as! siloDetailEntityCell
            siloCellAmen.lblCell.text = amenList[indexPath.row] as String
            siloCellAmen.layer.borderWidth = 1
            siloCellAmen.layer.cornerRadius = 1
            return siloCellAmen
            
        }else{
            let siloCellEquip:siloDetailEntityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eqipCell", for: indexPath as IndexPath) as! siloDetailEntityCell
            siloCellEquip.lblCell.text = eqipList[indexPath.row] as String
            siloCellEquip.layer.borderWidth = 1
            siloCellEquip.layer.cornerRadius = 1
            return siloCellEquip
        }
        
    }
   
}
