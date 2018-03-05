//
//  ToplotnaCrpalka.swift
//  Airabela
//
//  Created by Alen Kirm on 21. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

enum TipNapraveToplotnaCrpalka : String {
    
    case VisokoTemperaturna = "Visokotemperaturna"
    case NizkoTemperaturna = "Nizkotemperaturna"
    case Hibridna = "Hibridna"
    case Monoblok = "Monoblok"
    
}

class ToplotnaCrpalka : Naprava {
    
    var tipNaprave : String?
    var reklamirnaEnota : String?
    var zunanjaEnotaStevilka : String?
    var notranjaEnotaStevilka : String?
    
    init(tipNaprave : String?, reklamirnaEnota : String?, zunanjaEnotaStevilka : String?, notranjaEnotaStevilka : String?) {
        self.tipNaprave = tipNaprave
        self.reklamirnaEnota = reklamirnaEnota
        self.zunanjaEnotaStevilka = zunanjaEnotaStevilka
        self.notranjaEnotaStevilka = notranjaEnotaStevilka
        super.init(vrstaNaprave: .ToplotnaCrpalka)
    }
    
}

let visokoTemperaturnaZunanjaToplotnaCrpalkaKoda = ["Izberi...","ERRQ011AV1", "ERRQ011AY1", "ERRQ014AV1", "ERRQ014AY1", "ERRQ016AV1", "ERRQ016AY1", "drugo"]
let visokoTemperaturnaNotranjaToplotnaCrpalkaKoda = ["Izberi...","EKHBRD011ACV1", "EKHBRD011ACY1", "EKHBRD014ACV1", "EKHBRD014ACY1", "EKHBRD016ACV1", "EKHBRD016ACY1", "drugo"]
let nizkoTemperaturnaZunanjaToplotnaCrpalkaKoda = ["Izberi...","ERLQ004CV3", "ERLQ006CV3", "ERLQ008CV3", "ERLQ11CV3", "ERLQ11CW1", "ERLQ14CV3", "ERLQ14CW1", "ERLQ16CV3", "ERLQ16CW1"]
let nizkoTemperaturnaNotranjaToplotnaCrpalkaKoda = ["Izberi...","EHBH04C3V", "EHBX04C3V", "EHVH04S18C3V", "EHVX04S18C3V", "EHBH08C3V", "EHBX08C3V", "EHBH08C9W", "EHBX08C9W", "EHVH08S18C3V", "EHVX08S18C3V", "EHVH08S26C9W", "EHVX08S26C9W", "EHBH11C3V", "EHBX11C3V", "EHBH11C9W", "EHBX11C9W", "EHVH11S18C3V", "EHVX11S18C3V", "EHVH11S26C9W", "EHVX11S26C9W", "EHBH16C3V", "EHBX16C3V", "EHBH16C9W", "EHBX16C9W", "EHVH16S18C3V", "EHVX16S18C3V", "EHVH16S26C9W", "EHVX16S26C9W", "drugo"]
let hibridnaZunanjaToplotnaCrpalkaKoda = ["Izberi...","EVLQ05CV3", "EVLQ08CV3", "drugo"]
let hibridnaNotranjaToplotnaCrpalkaKoda = ["Izberi...","EHYHBH05AV3", "EHYHBH08AV3", "EHYHBX08AV3", "drugo"]

let reklamiraneEnoteVrste = ["Izberi...", "Zunanja enota", "Notranja enota", "Zunanja in notranja enota"]
let tipiNapravToplotnaCrpalka = ["Izberi...","Visokotemperaturna", "Nizkotemperaturna", "Hibridna", "Monoblok"]

let visokoTemperaturnaZunanjaInNotranjaCrpalkaKoda = [["Izberi...","ERRQ011AV1", "ERRQ011AY1", "ERRQ014AV1", "ERRQ014AY1", "ERRQ016AV1", "ERRQ016AY1", "drugo"],["Izberi...","EKHBRD011ACV1", "EKHBRD011ACY1", "EKHBRD014ACV1", "EKHBRD014ACY1", "EKHBRD016ACV1", "EKHBRD016ACY1", "drugo"]]
let nizkoTemperaturnaZunanjaInNotranjaCrpalkaKoda = [["Izberi...","ERLQ004CV3", "ERLQ006CV3", "ERLQ008CV3", "ERLQ11CV3", "ERLQ11CW1", "ERLQ14CV3", "ERLQ14CW1", "ERLQ16CV3", "ERLQ16CW1"], ["Izberi...","EHBH04C3V", "EHBX04C3V", "EHVH04S18C3V", "EHVX04S18C3V", "EHBH08C3V", "EHBX08C3V", "EHBH08C9W", "EHBX08C9W", "EHVH08S18C3V", "EHVX08S18C3V", "EHVH08S26C9W", "EHVX08S26C9W", "EHBH11C3V", "EHBX11C3V", "EHBH11C9W", "EHBX11C9W", "EHVH11S18C3V", "EHVX11S18C3V", "EHVH11S26C9W", "EHVX11S26C9W", "EHBH16C3V", "EHBX16C3V", "EHBH16C9W", "EHBX16C9W", "EHVH16S18C3V", "EHVX16S18C3V", "EHVH16S26C9W", "EHVX16S26C9W", "drugo"]]

let monoblokZunanjaToplotnaCrpalkaKoda = ["Izberi...","EDLQ05CV3", "EDLQ07CV3", "EDLQ11BB6V3", "EDLQ14BB6V3", "EDLQ16BB6V3", "EDLQ11BB6W1", "EDLQ14BB6W1", "EDLQ16BB6W1", "EBLQ05CAV3", "EBLQ07CAV3", "EBLQ11BB6V3", "EBLQ14BB6V3", "EBLQ16BB6V3", "EBLQ11BB6W1", "EBLQ14BB6W1", "EBLQ16BB6W1", "drugo"]

