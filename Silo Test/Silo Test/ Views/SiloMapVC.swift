//
//  SiloMapVC.swift
//  Silo Test
//
//  Created by Bhumit Muchhadia on 2020-02-12.
//  Copyright © 2020 Bhumit Muchhadia. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit

class SiloMapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapSilo: MKMapView!
    var apiGetData = APIData();
    var fetchedFata = [[String:AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapSilo.delegate = self;
        fetchSiloData()
        self.navigationController?.navigationBar.isHidden
            = true
    }
    
    func fetchSiloData(){
        apiGetData.getSiloFirebaseData { (siloData) in
            let snapshotValue = siloData.value as! [String: AnyObject]
            for keys in snapshotValue.keys{
                self.fetchedFata.append( snapshotValue[keys] as! [String:AnyObject])
            }
            self.addPinsToMap()
        }
    }
    
    func addPinsToMap(){
        for data in self.fetchedFata{
            let silo = MKPointAnnotation()
            silo.title = data["name"] as? String
            
            silo.coordinate = CLLocationCoordinate2D(latitude: data["latitude"] as! CLLocationDegrees, longitude:data["longitude"] as! CLLocationDegrees)
            mapSilo.addAnnotation(silo)
        }
        self.mapSilo.showAnnotations(self.mapSilo.annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView()
        for data in self.fetchedFata{
            if (annotation.title == data["name"] as? String){
                if (data["status"] as? String == "coming_soon"){
                    annotationView.pinTintColor = .red
                }
                else{
                    annotationView.pinTintColor = .green
                }
            }
        }
        return annotationView
    }
    
    
    @IBAction func btnLogOut(_ sender: Any) {
        let logoutAlert = UIAlertController(title: "Log Out?", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { (action: UIAlertAction) in
            UserDefaults.standard.setValue("false", forKey: "LoggedStatus")
            LoginManager().logOut()
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SiloViewController") as! SiloViewController
            self.navigationController?.setViewControllers([viewController], animated: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        logoutAlert.addAction(logOut)
        logoutAlert.addAction(cancelAction)
        self.present(logoutAlert, animated: true, completion: nil)
        
    }
    @IBAction func listAction(_ sender: Any) {
        let SiloListV = self.storyboard?.instantiateViewController(withIdentifier: "SiloListVC") as! SiloListVC
        SiloListV.SiloData = fetchedFata
        self.navigationController?.pushViewController(SiloListV, animated: true)
    }
    
}
