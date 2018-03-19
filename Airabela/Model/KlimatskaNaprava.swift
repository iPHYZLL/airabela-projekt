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
                "zunanja" : ["Izberi...", "RXZ 25N", "RXZ 35N", "RXZ 50N", "drugo"],
                "notranja" : ["Izberi...", "FTXZ 25N", "FTXZ 35N", "FTXZ 50N", "drugo"],
                "RXZ 25N" : ["Izberi...", "FTXZ 25N", "drugo"],
                "RXZ 35N" : ["Izberi...", "FTXZ 35N", "drugo"],
                "RXZ 50N" : ["Izberi...", "FTXZ 50N", "drugo"]
            ],
            "FTXJ-M / RXJ-M" : [
                "zunanja" : ["Izberi...", "RXJ 20M", "RXJ 25M", "RXJ 35M", "RXJ 50M", "drugo"],
                "notranja" : ["Izberi...", "FTXJ 20MW", "FTXJ 25MW", "FTXJ 35MW", "FTXJ 50MW", "drugo"],
                "RXJ 20M" : ["Izberi...", "FTXJ 20MW", "drugo"],
                "RXJ 25M" : ["Izberi...", "FTXJ 25MW", "drugo"],
                "RXJ 35M" : ["Izberi...", "FTXJ 35MW", "drugo"],
                "RXJ 50M" : ["Izberi...", "FTXJ 50MW", "drugo"]
            ],
            "FTXM-M / RXM-M" : [
                "zunanja" : ["Izberi...", "RXM 20M", "RXM 20M9", "RXM 25M", "RXM 25M9", "RXM 35M", "RXM 35M9", "RXM 42M", "RXM 42M9", "RXM 50M", "RXM 50M9", "RXM 60M", "RXM 60M9", "RXM 71M", "RXM 71M9", "drugo"],
                "notranja" : ["Izberi...", "FTXM 20M", "FTXM 25M", "FTXM 35M", "FTXM 42M", "FTXM 50M", "FTXM 60M", "FTXM 71M", "drugo"],
                "RXM 20M" : ["Izberi...", "FTXM 20M", "drugo"],
                "RXM 20M9" : ["Izberi...", "FTXM 25M", "drugo"],
                "RXM 25M" : ["Izberi...", "FTXM 35M", "drugo"],
                "RXM 25M9" : ["Izberi...", "FTXM 42M", "drugo"],
                "RXM 35M" : ["Izberi...", "FTXM 50M", "drugo"],
                "RXM 35M9" : ["Izberi...", "FTXM 60M", "drugo"],
                "RXM 42M" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 42M9" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 50M" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 50M9" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 60M" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 60M9" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 71M" : ["Izberi...", "FTXM 71M", "drugo"],
                "RXM 71M9" : ["Izberi...", "FTXM 71M", "drugo"],
            ],
            "FTXP-K3 / RXP-K3" : [
                "zunanja" : ["Izberi...", "RXP 20K3", "RXP 25K3", "RXP 35K3", "RXP 50K3", "RXP 60K3", "RXP 71K3", "drugo"],
                "notranja" : ["Izberi...", "FTXP 20K3", "FTXP 25K3", "FTXP 35K3", "FTXP 50K3", "FTXP 60K3", "FTXP 71K3", "drugo"],
                "RXP 20K3" : ["Izberi...", "FTXP 20K3", "drugo"],
                "RXP 25K3" : ["Izberi...", "FTXP 25K3", "drugo"],
                "RXP 35K3" : ["Izberi...", "FTXP 35K3", "drugo"],
                "RXP 50K3" : ["Izberi...", "FTXP 50K3", "drugo"],
                "RXP 60K3" : ["Izberi...", "FTXP 60K3", "drugo"],
                "RXP 71K3" : ["Izberi...", "FTXP 71K3", "drugo"]
            ],
            "FTXB-C / RXB-C" : [
                "zunanja" : ["Izberi...", "RXB 20C", "RXB 25C", "RXB 35C", "RXB 50C", "RXB 60C", "drugo"],
                "notranja" : ["Izberi...", "FTXB 20C", "FTXB 25C", "FTXB 35C", "FTXB 50C", "FTXB 60C", "drugo"],
                "RXB 20C" : ["Izberi...", "FTXB 20C", "drugo"],
                "RXB 25C" : ["Izberi...", "FTXB 25C", "drugo"],
                "RXB 35C" : ["Izberi...", "FTXB 35C", "drugo"],
                "RXB 50C" : ["Izberi...", "FTXB 50C", "drugo"],
                "RXB 60C" : ["Izberi...", "FTXB 60C", "drugo"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Talna.rawValue : [
        "podtip" : [
            "FVXG-K / RXG-L" : [
                "zunanja" : ["Izberi...", "RXG 25L", "RXG 35L", "RXG 50L", "drugo"],
                "notranja" : ["Izberi...", "FVXG 25K", "FVXG 35K", "FVXG 50K", "drugo"],
                "RXG 25L" : ["Izberi...", "FVXG 25K", "drugo"],
                "RXG 35L" : ["Izberi...", "FVXG 35K", "drugo"],
                "RXG 50L" : ["Izberi...", "FVXG 50K", "drugo"]
            ],
            "FVXS-F / RXS-L" : [
                "zunanja" : ["Izberi...", "RXS 25L3", "RXS 35L3", "RXS 50L3", "drugo"],
                "notranja" : ["Izberi...", "FVXS 25F", "FVXS 35F", "FVXS 50F", "drugo"],
                "RXS 25L3" : ["Izberi...", "FVXS 25F", "drugo"],
                "RXS 35L3" : ["Izberi...", "FVXS 35F", "drugo"],
                "RXS 50L3" : ["Izberi...", "FVXS 50F", "drugo"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Kasetna.rawValue : [
        "podtip" : [
            "FCQG-F / RXS-L" : [
                "zunanja" : ["Izberi...", "RXS 35L3", "RXS 50L3", "RXS 60L3", "drugo"],
                "notranja" : ["Izberi...", "FCQG 35F", "FCQG 50F", "FCQG 60F", "drugo"],
                "RXS 35L3" : ["Izberi...", "FCQG 35F", "drugo"],
                "RXS 50L3" : ["Izberi...", "FCQG 50F", "drugo"],
                "RXS 60L3" : ["Izberi...", "FCQG 60F", "drugo"]
            ],
            "FFQ-C / RXS-L" : [
                "zunanja" : ["Izberi...", "RXS 25L3", "RXS 35L3", "RXS 50L3", "RXS 60L3", "drugo"],
                "notranja" : ["Izberi...", "FFQ 25C", "FFQ 35C", "FFQ 50C", "FFQ 60C", "drugo"],
                "RXS 25L3" : ["Izberi...", "FFQ 25C", "drugo"],
                "RXS 35L3" : ["Izberi...", "FFQ 35C", "drugo"],
                "RXS 50L3" : ["Izberi...", "FFQ 50C", "drugo"],
                "RXS 60L3" : ["Izberi...", "FFQ 60C", "drugo"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.SkritaStropna.rawValue : [
        "podtip" : [
            "FDXS-F / RXS-L" : [
                "zunanja" : ["Izberi...", "RXS 25L3", "RXS 35L3", "RXS 50L3", "RXS 60L3", "drugo"],
                "notranja" : ["Izberi...", "FDXS 25F", "FDXS 35F", "FDXS 50F", "FDXS 60F", "drugo"],
                "RXS 25L3" : ["Izberi...", "FDXS 25F", "drugo"],
                "RXS 35L3" : ["Izberi...", "FDXS 35F", "drugo"],
                "RXS 50L3" : ["Izberi...", "FDXS 50F", "drugo"],
                "RXS 60L3" : ["Izberi...", "FDXS 60F", "drugo"]
            ]
        ]
    ],
    TipNapraveKlimatskaNaprava.Flexi.rawValue : [
        "podtip" : [
            "FLXS-B / RXS-L" : [
                "zunanja" : ["Izberi...", "RXS 25L3", "RXS 35L3", "RXS 50L3", "drugo"],
                "notranja" : ["Izberi...", "FLXS 25B", "FLXS 35B", "FLXS 50B", "drugo"],
                "RXS 25L3" : ["Izberi...", "FLXS 25B", "drugo"],
                "RXS 35L3" : ["Izberi...", "FLXS 35B", "drugo"],
                "RXS 50L3" : ["Izberi...", "FLXS 50B", "drugo"]
            ]
        ]
    ]
]





