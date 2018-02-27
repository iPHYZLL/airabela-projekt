//
//  Reklamacija.swift
//  Airabela
//
//  Created by Alen Kirm on 20. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

struct Reklamacija {
    var kupec : Kupec
    var naprava : Naprava?
    var opisReklamacije : OpisReklamacije?
    var fotografijeReklamacije : [UIImage]?
}

struct OpisReklamacije {
    var kodaNapake : String
    var opisNapake : String
    var serijskaZunanjeEnote : String
    var serijskaNotranjeEnote : String
}
