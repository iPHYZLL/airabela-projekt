//
//  Utilities.swift
//  Airabela
//
//  Created by Alen Kirm on 20. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

enum VrstaNaprave : String {
    case ToplotnaCrpalka = "Toplotna črpalka"
    case KlimatskaNaprava = "Klimatska Naprava"
    case Rekuperator = "Rekuperator"
    case CistilecZraka = "Čistilec zraka"
    case Konvektor = "Konvektor"
    case VRVSistem = "VRV Sistem"
    case PlinskiKotel = "Plinski kotel"
}

enum ReklamiranaEnota : String {
    case ZunanjaEnota = "Zunanja enota"
    case NotranjaEnota = "Notranja enota"
    case ZunanjaInNotranjaEnota = "Zunanja in notranja enota"
}

let vrsteNaprav = ["Izberi...","Toplotna črpalka", "Klimatska naprava", "Rekuperator", "Čistilec zraka", "Konvektor", "VRV Sistem", "Plinski kotel"]

