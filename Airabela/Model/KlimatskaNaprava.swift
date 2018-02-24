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
    case SkritaStropna = "Skrita stropna"
    case Flexi = "Flexi"
    case Nordic = "NORDIC"
    case MultiSplitSistem = "Multi Split Sistem"
    
}

class KlimatskaNaprava : Naprava {
    
    var tipNaprave : TipNapraveKlimatskaNaprava
    var podTipNaprave : String?
    var reklamiranaEnota : ReklamiranaEnota?
    var oznakaNaprave : String?
    
    init(tipNaprave : TipNapraveKlimatskaNaprava, podTipNaprave : String?, reklamiranaEnota : ReklamiranaEnota?, oznakaNaprave : String?) {
        self.tipNaprave = tipNaprave
        self.podTipNaprave = podTipNaprave
        self.reklamiranaEnota = reklamiranaEnota
        self.oznakaNaprave = oznakaNaprave
        super.init(vrstaNaprave: .KlimatskaNaprava)
    }
    
}
