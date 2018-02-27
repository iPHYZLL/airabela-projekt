//
//  PredmetController.swift
//  Airabela
//
//  Created by Alen Kirm on 16. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class PredmetController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var reklamacija : Reklamacija?
    
    let headerView : UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor.airabelaGray
        return hv
    }()
    
    let logoImageView : UIImageView = {
        let liv = UIImageView()
        liv.image = #imageLiteral(resourceName: "Airabela+podpis")
        liv.contentMode = .scaleAspectFit
        return liv
    }()
    
    let closeButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("PREKLIČI", for: .normal)
        b.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    let naprejButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("NARPREJ", for: .normal)
        b.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    @objc func handleCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNaprejButton() {
        
        // init predmet
        let opisReklamacijeController = OpisReklamacijeController()
        var predmet : Naprava?
        
        if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {

            predmet = ToplotnaCrpalka(tipNaprave: izbranTipNaprave, reklamirnaEnota: izbranaReklamiranaEnota, zunanjaEnotaStevilka: izbranaZunanjaReklamiranaEnota, notranjaEnotaStevilka: izbranaNotranjaReklamiranaEnota)
        } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
            // do klimatska naprava stuff here
            
        } else if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
            
            predmet = Rekuperator(naprava: izbranaNaprava ?? "", oznakaNaprave: oznakaNaprave ?? "")
        } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
            
            predmet = CistilecZraka(naprava: izbranaNaprava ?? "", oznakaNaprave: oznakaNaprave ?? "")
        } else if izbranaVrstaNaprave == VrstaNaprave.Konvektor.rawValue {
            
            predmet = Konvektor(oznakaNaprave: oznakaNaprave ?? "")
        } else if izbranaVrstaNaprave == VrstaNaprave.VRVSistem.rawValue {
            
            predmet = VRVSistem(oznakaNaprave: oznakaNaprave ?? "")
        } else {
            // plinski kotel
            predmet = PlinskiKotel(oznakaNaprave: oznakaNaprave ?? "")
        }
        
        reklamacija?.naprava = predmet
        opisReklamacijeController.reklamacija = reklamacija
//        opisReklamacijeController.predmet = predmet
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(opisReklamacijeController, animated: true)
        
    }
    
    // picker view stuff
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == vrstaNapravePickerView {
            return vrsteNaprav.count
        } else if pickerView == tipNapraveToplotnaCrpalkaPickerView {
            return tipiNapravToplotnaCrpalka.count
        } else if pickerView == reklamiranaEnotaToplotnaCrpalkaPickerView {
            return reklamiraneEnoteToplotnaCrpalka.count
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return visokoTemperaturnaZunanjaToplotnaCrpalkaKoda.count
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return nizkoTemperaturnaZunanjaToplotnaCrpalkaKoda.count
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return hibridnaZunanjaToplotnaCrpalkaKoda.count
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Monoblok.rawValue {
                return monoblokZunanjaToplotnaCrpalkaKoda.count
            }
            
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return nizkoTemperaturnaNotranjaToplotnaCrpalkaKoda.count
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return visokoTemperaturnaNotranjaToplotnaCrpalkaKoda.count
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return hibridnaZunanjaToplotnaCrpalkaKoda.count
                }
            }
           
        } else if pickerView == napravaPickerView {
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
                return rekuperatorNapravaKoda.count
            } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                return cistilecZrakaNapravaKoda.count
            }
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vrstaNapravePickerView {
            return vrsteNaprav[row]
        } else if pickerView == tipNapraveToplotnaCrpalkaPickerView {
            return tipiNapravToplotnaCrpalka[row]
        } else if pickerView == reklamiranaEnotaToplotnaCrpalkaPickerView {
            return reklamiraneEnoteToplotnaCrpalka[row]
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return visokoTemperaturnaZunanjaToplotnaCrpalkaKoda[row]
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return nizkoTemperaturnaZunanjaToplotnaCrpalkaKoda[row]
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return hibridnaZunanjaToplotnaCrpalkaKoda[row]
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Monoblok.rawValue {
                return monoblokZunanjaToplotnaCrpalkaKoda[row]
            }
            
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return visokoTemperaturnaNotranjaToplotnaCrpalkaKoda[row]
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return nizkoTemperaturnaNotranjaToplotnaCrpalkaKoda[row]
                }
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    return hibridnaNotranjaToplotnaCrpalkaKoda[row]
                }
            }
            
        } else if pickerView == napravaPickerView {
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
                return rekuperatorNapravaKoda[row]
            } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                return cistilecZrakaNapravaKoda[row]
            }
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == vrstaNapravePickerView {
            vrstaNapraveTextField.text = vrsteNaprav[row]
            vrstaNapraveTextField.resignFirstResponder()
            
            izbranaVrstaNaprave = vrstaNapraveTextField.text!
        } else if pickerView == tipNapraveToplotnaCrpalkaPickerView {
            tipNapraveToplotnaCrpalkaTextField.text = tipiNapravToplotnaCrpalka[row]
            tipNapraveToplotnaCrpalkaTextField.resignFirstResponder()
            
            izbranTipNaprave = tipNapraveToplotnaCrpalkaTextField.text
        } else if pickerView == reklamiranaEnotaToplotnaCrpalkaPickerView {
            reklamiranaEnotaToplotnaCrpalkaTextField.text = reklamiraneEnoteToplotnaCrpalka[row]
            reklamiranaEnotaToplotnaCrpalkaTextField.resignFirstResponder()
            
            izbranaReklamiranaEnota = reklamiranaEnotaToplotnaCrpalkaTextField.text
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                reklamiranaNotranjaEnotaTextField.text = visokoTemperaturnaNotranjaToplotnaCrpalkaKoda[row]
                reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                
                izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                reklamiranaNotranjaEnotaTextField.text = nizkoTemperaturnaNotranjaToplotnaCrpalkaKoda[row]
                reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                
                izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                reklamiranaNotranjaEnotaTextField.text = hibridnaNotranjaToplotnaCrpalkaKoda[row]
                reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                
                izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
            }
            
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue {
                reklamiranaZunanjaEnotaTextField.text = visokoTemperaturnaZunanjaToplotnaCrpalkaKoda[row]
                reklamiranaZunanjaEnotaTextField.resignFirstResponder()
                
                izbranaZunanjaReklamiranaEnota = reklamiranaZunanjaEnotaTextField.text
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue {
                reklamiranaZunanjaEnotaTextField.text = nizkoTemperaturnaZunanjaToplotnaCrpalkaKoda[row]
                reklamiranaZunanjaEnotaTextField.resignFirstResponder()
                
                izbranaZunanjaReklamiranaEnota = reklamiranaZunanjaEnotaTextField.text
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                reklamiranaZunanjaEnotaTextField.text = hibridnaZunanjaToplotnaCrpalkaKoda[row]
                reklamiranaZunanjaEnotaTextField.resignFirstResponder()
                
                izbranaZunanjaReklamiranaEnota = reklamiranaZunanjaEnotaTextField.text
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Monoblok.rawValue {
                reklamiranaZunanjaEnotaTextField.text = monoblokZunanjaToplotnaCrpalkaKoda[row]
                reklamiranaZunanjaEnotaTextField.resignFirstResponder()
                
                izbranaZunanjaReklamiranaEnota = reklamiranaZunanjaEnotaTextField.text
            } 
            
        } else if pickerView == napravaPickerView {
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
                napravaTextField.text = rekuperatorNapravaKoda[row]
                napravaTextField.resignFirstResponder()
                
                izbranaNaprava = napravaTextField.text
            } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                napravaTextField.text = cistilecZrakaNapravaKoda[row]
                napravaTextField.resignFirstResponder()
                
                izbranaNaprava = napravaTextField.text
            }
        }
        
    }
    
    // predmet info
    
    var izbranaVrstaNaprave : String? {
        
        willSet {
            for subView in predmetContainerView.subviews {
                if !(subView == vrstaNapraveTextField) {
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet {
            // manage # of views in container view
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                predmetContainerView.addSubview(tipNapraveToplotnaCrpalkaTextField)
                tipNapraveToplotnaCrpalkaTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: 20, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                tipNapraveToplotnaCrpalkaTextField.inputView = tipNapraveToplotnaCrpalkaPickerView
                tipNapraveToplotnaCrpalkaPickerView.dataSource = self
                tipNapraveToplotnaCrpalkaPickerView.delegate = self
                
            } else if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue || izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                predmetContainerView.addSubview(napravaTextField)
                napravaTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: 20, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                napravaTextField.inputView = napravaPickerView
                napravaPickerView.delegate = self
                napravaPickerView.dataSource = self
            } else if izbranaVrstaNaprave == VrstaNaprave.Konvektor.rawValue || izbranaVrstaNaprave == VrstaNaprave.VRVSistem.rawValue || izbranaVrstaNaprave == VrstaNaprave.PlinskiKotel.rawValue {
                
                // add oznaka naprave textfield
                predmetContainerView.addSubview(oznakaNapraveTextField)
                oznakaNapraveTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: 20, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
            }
        }
    }
    
    var izbranTipNaprave : String? {
        
        willSet {
            for subView in predmetContainerView.subviews {
                if !(subView == vrstaNapraveTextField) && !(subView == tipNapraveToplotnaCrpalkaTextField) {
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet {
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue || izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue || izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                
                predmetContainerView.addSubview(reklamiranaEnotaToplotnaCrpalkaTextField)
                reklamiranaEnotaToplotnaCrpalkaTextField.anchor(top: tipNapraveToplotnaCrpalkaTextField.bottomAnchor, paddingTop: 20, right: tipNapraveToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: tipNapraveToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaEnotaToplotnaCrpalkaTextField.inputView = reklamiranaEnotaToplotnaCrpalkaPickerView
                reklamiranaEnotaToplotnaCrpalkaPickerView.delegate = self
                reklamiranaEnotaToplotnaCrpalkaPickerView.dataSource = self
                
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Monoblok.rawValue {
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: tipNapraveToplotnaCrpalkaTextField.bottomAnchor, paddingTop: 20, right: tipNapraveToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: tipNapraveToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
            }
            
        }
    }
    
    var izbranaReklamiranaEnota : String? {
        
        willSet {
            for subView in predmetContainerView.subviews {
                if !(subView == vrstaNapraveTextField) && !(subView == tipNapraveToplotnaCrpalkaTextField) && !(subView == reklamiranaEnotaToplotnaCrpalkaTextField) {
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet {
            
            if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                
                // add notranja enota toplotna view
                
                predmetContainerView.addSubview(reklamiranaNotranjaEnotaTextField)
                reklamiranaNotranjaEnotaTextField.anchor(top: reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor, paddingTop: 20, right: reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaNotranjaEnotaTextField.inputView = notranjaEnotaPickerView
                notranjaEnotaPickerView.delegate = self
                notranjaEnotaPickerView.dataSource = self
                
            } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue {
                
                // add zunanja enota toplotna view
                
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor, paddingTop: 20, right: reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
            } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                
                // add both above
                
                predmetContainerView.addSubview(reklamiranaNotranjaEnotaTextField)
                reklamiranaNotranjaEnotaTextField.anchor(top: reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor, paddingTop: 20, right: reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaNotranjaEnotaTextField.inputView = notranjaEnotaPickerView
                notranjaEnotaPickerView.delegate = self
                notranjaEnotaPickerView.dataSource = self
                
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: reklamiranaNotranjaEnotaTextField.bottomAnchor, paddingTop: 20, right: reklamiranaNotranjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaNotranjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
            }
            
        }
        
    }
    
    var izbranaZunanjaReklamiranaEnota : String? {
        didSet {
//            print(izbranaZunanjaReklamiranaEnota)
        }
    }
    
    var izbranaNotranjaReklamiranaEnota : String? {
        didSet {
//            print(izbranaNotranjaReklamiranaEnota)
        }
    }
    
    var izbranaNaprava : String? {
        didSet {
//            print(izbranaNaprava)
        }
    }
    
    var oznakaNaprave : String? {
        didSet {
//            print(oznakaNaprave)
        }
    }
    
    // let predmet views
    
    let predmetContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let vrstaNapraveTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "VRSTA NAPRAVE"
        return tf
    }()
    
    let tipNapraveToplotnaCrpalkaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "TIP NAPRAVE"
        return tf
    }()
    
    let reklamiranaEnotaToplotnaCrpalkaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "REKLAMIRANA ENOTA"
        return tf
    }()
    
    let reklamiranaZunanjaEnotaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "ZUNANJA ENOTA"
        return tf
    }()
    
    let reklamiranaNotranjaEnotaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "NOTRANJA ENOTA"
        return tf
    }()
    
    let napravaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "NAPRAVA:"
        return tf
    }()
    
    let oznakaNapraveTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "OZNAKA NAPRAVE:"
        return tf
    }()
    
    let vrstaNapravePickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let tipNapraveToplotnaCrpalkaPickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()

    let reklamiranaEnotaToplotnaCrpalkaPickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let zunanjaEnotaPickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let notranjaEnotaPickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let napravaPickerView: UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        izbranaZunanjaReklamiranaEnota = nil
        izbranaNotranjaReklamiranaEnota = nil
        izbranaReklamiranaEnota = nil
        
        reklamiranaEnotaToplotnaCrpalkaPickerView.selectRow(0, inComponent: 0, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaGray
        navigationItem.title = "PREDMET"
        
        print(reklamacija?.kupec ?? "")
        
        view.addSubview(headerView)
        if #available(iOS 11.0, *) {
            headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        } else {
            // Fallback on earlier versions
            headerView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        }
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [closeButton, naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        if #available(iOS 11.0, *) {
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        } else {
            // Fallback on earlier versions
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        }
        
        // add container view
        
        view.addSubview(predmetContainerView)
        predmetContainerView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: buttonsStackView.rightAnchor, paddingRight: 0, left: buttonsStackView.leftAnchor, paddingLeft: 0, bottom: buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        predmetContainerView.addSubview(vrstaNapraveTextField)
        vrstaNapraveTextField.anchor(top: predmetContainerView.topAnchor, paddingTop: 0, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        vrstaNapraveTextField.inputView = vrstaNapravePickerView
        vrstaNapravePickerView.dataSource = self
        vrstaNapravePickerView.delegate = self
        
    }
    
}
