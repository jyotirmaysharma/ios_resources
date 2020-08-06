//
//  IssViewController.swift
//  anomaly_mix
//
//  Created by Jyotirmay Sharma on 21/07/20.
//  Copyright © 2020 Jyotirmay Sharma. All rights reserved.
//

import UIKit

class IssViewController: UIViewController{

    var lat: Double = 0
    var lon: Double = 0
    var number: Int = 5
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var numberPeopleLabel: UILabel!
    
    var peopleUrl = "http://api.open-notify.org/astros.json"
    var locationUrl = "http://api.open-notify.org/iss-now.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFetchEnvironment()
    }
    
    func setFetchEnvironment(){
        performRequestPeople(urlString: peopleUrl)
        performRequestLocation(urlString: locationUrl)
    }
    
    func performRequestLocation(urlString: String){
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            if let safeData = data{
                self.parseJsonLocation(apiData: safeData)
            }
        }
        task.resume()
    }
    
    func parseJsonLocation(apiData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ApiData.self, from: apiData)
            
            lat = Double(decodedData.iss_position.latitude)!
            lon = Double(decodedData.iss_position.longitude)!
        }catch{
            print(error)
        }
    }
    
    func performRequestPeople(urlString: String){
        let url = URL(string: urlString)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            
            if let safeData = data{
                self.parseJsonPeople(apiDataPerson: safeData)
            }
        }
        task.resume()
    }
    
    func parseJsonPeople(apiDataPerson: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ApiDataPerson.self, from: apiDataPerson)
            
            number = decodedData.number
        }catch{
            print(error)
        }
    }
    
    @IBAction func findPressed(_ sender: UIButton) {
        latitudeLabel.text = "ISS LAT: \(String())"
        longitudeLabel.text = "ISS LON: \(String(lon))"
        numberPeopleLabel.text = "Number of People in Space right now:\(number)"
    }
}
