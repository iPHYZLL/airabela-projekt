//
//  OznakaNaprave.swift
//  Airabela
//
//  Created by Alen Kirm on 19. 03. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

@objc protocol OznakaNaprave {
    
    var oznakaNaprave : String? { get set }
    @objc optional  var naprava : String { get set }
    
}

protocol ZunanjaInNotranja {
    
    var zunanjaEnotaStevilka : String? { get set }
    var notranjaEnotaStevilka : String? { get set }
    
}
