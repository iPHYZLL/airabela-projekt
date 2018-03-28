//
//  PlinskiKotel.swift
//  Airabela
//
//  Created by Alen Kirm on 21. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

class PlinskiKotel : Naprava, OznakaNaprave {
    
    var oznakaNaprave : String?
    
    init(oznakaNaprave : String?) {
        self.oznakaNaprave = oznakaNaprave
        super.init(vrstaNaprave: .PlinskiKotel)
    }
}
