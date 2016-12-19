//
//  LocationVC
//  rainyshinycloudy
//
//  Created by Marc Cruz on 12/3/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit

class LocationVC: UIViewController {

    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var coordsView: UIView!

    @IBOutlet weak var selectorChoice: UISegmentedControl!
    
    var _selectedLat: Double!
    var _selectedLong: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        latitude.text = "\(_selectedLat!)"
        longitude.text = "\(_selectedLong!)"
        
//        latitude.returnKeyType = UIReturnKeyType.done
//        longitude.returnKeyType = UIReturnKeyType.done
        
        coordsView.isHidden = false
        mapView.isHidden = true
        selectorChoice.selectedSegmentIndex = 0
        
    }
    
    @IBAction func hideKeyboard(_ sender: Any) {
        latitude.resignFirstResponder()
        longitude.resignFirstResponder()
    }

    @IBAction func cancelSelection(_ sender: UIButton) {
        print("Cancel button pressed...")
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmSelection(_ sender: UIButton) {
        if let selectedLat = Double(latitude.text!) {
            
            _selectedLat = selectedLat
            
            print("Latitude: \(_selectedLat!)")
        }
        
        if let selectedLong = Double(longitude.text!) {
            
            _selectedLong = selectedLong
            
            print("Longitude: \(_selectedLong!)")
        }
        
        performSegue(withIdentifier: "WeatherVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! WeatherVC
        destinationVC.selectedLat = _selectedLat
        destinationVC.selectedLong = _selectedLong
    }

    @IBAction func selectorChoiceValueChanged(_ sender: Any) {
        let choiceIndex = selectorChoice.selectedSegmentIndex
        print("Choice Index: \(choiceIndex)")
        
        switch choiceIndex {
            case 0:
                coordsView.isHidden = false
                mapView.isHidden = true
                break
            case 1:
                coordsView.isHidden = true
                mapView.isHidden = false
                break
                
            default:
                break
        }
    }
    
}
