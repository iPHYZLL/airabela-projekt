//
//  CistilecZraka.swift
//  Airabela
//
//  Created by Alen Kirm on 21. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

class CistilecZraka : Naprava, OznakaNaprave {
    
    var naprava : String
    var oznakaNaprave : String
    
    init(naprava : String, oznakaNaprave : String) {
        self.naprava = naprava
        self.oznakaNaprave = oznakaNaprave
        super.init(vrstaNaprave: .CistilecZraka)
    }
    
}

var cistilecZrakaNapravaKoda = ["izberi...", "MC70L", "MCK75JVM-K", "Drugo"]
