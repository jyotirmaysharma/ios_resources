//
//  ApiData.swift
//  anomaly_mix
//
//  Created by Jyotirmay Sharma on 23/07/20.
//  Copyright © 2020 Jyotirmay Sharma. All rights reserved.
//

import Foundation

struct ApiData: Decodable{
    let iss_position: Iss_position
}

struct Iss_position: Decodable{
    let latitude: String
    let longitude: String
}

struct ApiDataPerson: Decodable{
    let number: Int
    let people: People
}

struct People: Decodable{
    let people = [String : String]()
}
