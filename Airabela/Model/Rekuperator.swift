//
//  Rekuperator.swift
//  Airabela
//
//  Created by Alen Kirm on 21. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

class Rekuperator : Naprava {
    
    var naprava : String
    var oznakaNaprave : String
    
    init(naprava : String, oznakaNaprave : String) {
        self.naprava = naprava
        self.oznakaNaprave = oznakaNaprave
        super.init(vrstaNaprave: .Rekuperator)
    }
    
}

let rekuperatorNapravaKoda = ["Izberi...","VAM150", "VAM250", "VAM350", "VAM500", "VAM650", "VAM800", "VAM1000", "VAM1500", "VAM2000", "Drugo"]
