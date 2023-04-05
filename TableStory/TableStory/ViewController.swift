//
//  ViewController.swift
//  TableStory
//
//  Created by Fay, Hannah M on 3/22/23.
//

import UIKit
import MapKit

let data = [
    Item(name: "Pecan Street Market", neighborhood: "Pflugerville", desc: "Fresh custom florals, same day and pre-orders orders. Gift shop and clothing boutique.", lat: 30.4400401, long: -97.620699, imageName: "rest1"),
    Item(name: "Ruffles and Rust", neighborhood: "Pflugerville", desc: "The perfect place to find gifts, ladies fashions, and Southern staples for every occasion. Women owned small business.", lat:30.43986, long: -97.6212, imageName: "rest2"),
    Item(name: "Pflour Shop", neighborhood: "Pflugerville", desc: "Pflour Shop Bakery are your favorite local carb dealers. Decorated cookies, custom cakes and carbs.", lat: 30.484350, long:  -97.583740, imageName: "rest3"),
    Item(name: "West Pecan Coffee + Beer", neighborhood: "Pflugerville", desc: "Locally owned coffee shop in downtown Pflugerville on tap. Perfectly cozy, clean and modern. ", lat: 30.440330, long: -97.621000, imageName: "rest4"),
    Item(name: "Mays Street Boutique ", neighborhood: "Round Rock", desc: "Best boutique in Round Rock, Texas 4th time winner. Women's, men's, baby and home decor.", lat: 30.529170, long: -97.687780, imageName: "rest5")
   
]

struct Item {
    var name: String
    var neighborhood: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource

 {
    
    
 
   
    @IBOutlet weak var theTable: UITableView!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return data.count
  }


  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
      let item = data[indexPath.row]
      cell?.textLabel?.text = item.name
      let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
      return cell!
  }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
         
       
    override func viewDidLoad() {
        
        super.viewDidLoad()
        theTable.delegate = self
        theTable.dataSource = self
        
        // Do any additional setup after loading the view.
        
        //set center, zoom level and region of the map
            let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
            let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(region, animated: true)
            
         // loop through the items in the dataset and place them on the map
             for item in data {
                let annotation = MKPointAnnotation()
                let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                annotation.coordinate = eachCoordinate
                    annotation.title = item.name
                    mapView.addAnnotation(annotation)
                    }
    }


}

