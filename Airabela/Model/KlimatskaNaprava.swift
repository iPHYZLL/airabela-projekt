//
//  KlimatskaNaprava.swift
//  Airabela
//
//  Created by Alen Kirm on 21. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import Foundation

enum TipNapraveKlimatskaNaprava : String {
    
    case Stenska = "Stenska"
    case Talna = "Talna"
    case Kasetna = "Kasetna"
    case SkritaStropna = "Skrita stropna"
    case Flexi = "Flexi"
    case Nordic = "NORDIC"
    case MultiSplitSistem = "Multi Split Sistem"
    
}

class KlimatskaNaprava : Naprava {
    
    var tipNaprave : String?
    var podTipNaprave : String?
    var reklamiranaEnota : String?
    var oznakaNaprave : String?
    var zunanjaEnotaStevilka : String?
    var notranjaEnotaStevilka : String?
    
    init(tipNaprave : String?, podTipNaprave : String?, reklamiranaEnota : String?, oznakaNaprave : String?, zunanjaEnota : String?, notranjaEnota : String?) {
        self.tipNaprave = tipNaprave
        self.podTipNaprave = podTipNaprave
        self.reklamiranaEnota = reklamiranaEnota
        self.oznakaNaprave = oznakaNaprave
        self.zunanjaEnotaStevilka = zunanjaEnota
        self.notranjaEnotaStevilka = notranjaEnota
        super.init(vrstaNaprave: .KlimatskaNaprava)
    }
    
}

let tipiNapravKlimatskeNaprave = ["Izberi...", "Stenska", "Talna", "Kasetna", "Skrita stropna", "Flexi", "NORDIC", "Multi Split Sistem"]

let klimatskeNapraveDictionary : [String : Any] = [
    TipNapraveKlimatskaNaprava.Stenska.rawValue : [
        "podtip" : [
            "FTXZ-N / RXZ-N" : [
                "zunanja" : ["RXZ 25N", "RXZ 35N", "RXZ 50N"],
                "notranja" : ["FTXZ 25N", "FTXZ 35N", "FTXZ 50N"]
            ],
            "FTXJ-M / RXJ-M" : [
                "zunanja" : ["RXJ 20M", "RXJ 25M", "RXJ 35M", "RXJ 50M"],
                "notranja" : ["FTXJ 20MW", "FTXJ 25MW", "FTXJ 35MW", "FTXJ 50MW"]
            ],
            "FTXM-M / RXM-M" : [
                "zunanja" : ["RXM 20M", "RXM 20M9", "RXM 25M", "RXM 25M9", "RXM 35M", "RXM 35M9", "RXM 42M", "RXM 42M9", "RXM 50M", "RXM 50M9", "RXM 60M", "RXM 60M9", "RXM 71M", "RXM 71M9"],
                "notranja" : ["FTXM 20M", "FTXM 25M", "FTXM 35M", "FTXM 42M", "FTXM 50M", "FTXM 60M", "FTXM 71M"]
            ],
            "FTXP-K3 / RXP-K3" : [
                "zunanja" : ["RXP 20K3", "RXP 25K3", "RXP 35K3", "RXP 50K3", "RXP 60K3", "RXP 71K3"],
                "notranja" : ["FTXP 20K3", "FTXP 25K3", "FTXP 35K3", "FTXP 50K3", "FTXP 60K3", "FTXP 71K3"]
            ],
            "FTXB-C / RXB-C" : [
                "zunanja" : ["RXB 20C", "RXB 25C", "RXB 35C", "RXB 50C", "RXB 60C"],
                "notranja" : ["FTXB 20C", "FTXB 25C", "FTXB 35C", "FTXB 50C", "FTXB 60C"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Talna.rawValue : [
        "podtip" : [
            "FVXG-K / RXG-L" : [
                "zunanja" : ["RXG 25L", "RXG 35L", "RXG 50L"],
                "notranja" : ["FVXG 25K", "FVXG 35K", "FVXG 50K"]
            ],
            "FVXS-F / RXS-L" : [
                "zunanja" : ["RXS 25L3", "RXS 35L3", "RXS 50L3"],
                "notranja" : ["FVXS 25F", "FVXS 35F", "FVXS 50F"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Kasetna.rawValue : [
        "podtip" : [
            "FCQG-F / RXS-L" : [
                "zunanja" : ["RXS 35L3", "RXS 50L3", "RXS 60L3"],
                "notranja" : ["FCQG 35F", "FCQG 50F", "FCQG 60F"]
            ],
            "FFQ-C / RXS-L" : [
                "zunanja" : ["RXS 25L3", "RXS 35L3", "RXS 50L3", "RXS 60L3"],
                "notranja" : ["FFQ 25C", "FFQ 35C", "FFQ 50C", "FFQ 60C"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.SkritaStropna.rawValue : [
        "podtip" : [
            "FDXS-F / RXS-L" : [
                "zunanja" : ["RXS 25L3", "RXS 35L3", "RXS 50L3", "RXS 60L3"],
                "notranja" : ["FDXS 25F", "FDXS 35F", "FDXS 50F", "FDXS 60F"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Flexi.rawValue : [
        "podtip" : [
            "FLXS-B / RXS-L" : [
                "zunanja" : ["RXS 25L3", "RXS 35L3", "RXS 50L3"],
                "notranja" : ["FLXS 25B", "FLXS 35B", "FLXS 50B"]
            ]
        ]
    ]
]





