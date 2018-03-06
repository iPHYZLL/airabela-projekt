//
//  PredmetController.swift
//  Airabela
//
//  Created by Alen Kirm on 16. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class PredmetController: ReklamacijaController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var reklamacija : Reklamacija?
    fileprivate var textFieldHeight : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                print("ITS IPHONE SE!!")
                return 45
            }
        }
        return 50
    }
    
    fileprivate var textFieldPadding : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                print("ITS IPHONE SE!!")
                return 5
            }
        }
        return 10
    }
    
    @objc func handleNaprejButton() {
        
        // init predmet
        let opisReklamacijeController = OpisReklamacijeController()
        var predmet : Naprava?
        
        if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {

            predmet = ToplotnaCrpalka(tipNaprave: izbranTipNaprave, reklamirnaEnota: izbranaReklamiranaEnota, zunanjaEnotaStevilka: izbranaZunanjaReklamiranaEnota, notranjaEnotaStevilka: izbranaNotranjaReklamiranaEnota)
        } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
            
            predmet = KlimatskaNaprava(tipNaprave: izbranTipNaprave!, podTipNaprave: izbranPodtipNaprave, reklamiranaEnota: izbranaReklamiranaEnota, oznakaNaprave: oznakaNaprave, zunanjaEnota: izbranaZunanjaReklamiranaEnota, notranjaEnota: izbranaNotranjaReklamiranaEnota)
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
        } else if pickerView == tipNapraveKlimatskaNapravaPickerView {
            return tipiNapravKlimatskeNaprave.count
        } else if pickerView == reklamiranaEnotaToplotnaCrpalkaPickerView {
            return reklamiraneEnoteVrste.count
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                
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
                
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let zunanjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").zunanja"] as? [String] {
                    return zunanjaEnotaKlimatskaNaprava.count
                }
                
            }
            
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
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
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                    return notranjaEnotaKlimatskaNaprava.count
                }
            }
        } else if pickerView == napravaPickerView {
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
                return rekuperatorNapravaKoda.count
            } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                return cistilecZrakaNapravaKoda.count
            }
        } else if pickerView == podtipKlimatskeNapravePickerView {
            if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                if let klimatskePodtipi = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip"] as? [String : Any] {
                    let podtipiArray = Array(klimatskePodtipi.keys)
                    return podtipiArray.count
                }
            }
        } else if pickerView == reklamiranaEnotaKlimatskaNapravaPickerView {
            return reklamiraneEnoteVrste.count
        } 
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == vrstaNapravePickerView {
            return vrsteNaprav[row]
        } else if pickerView == tipNapraveToplotnaCrpalkaPickerView {
            return tipiNapravToplotnaCrpalka[row]
        } else if pickerView == tipNapraveKlimatskaNapravaPickerView {
            return tipiNapravKlimatskeNaprave[row]
        } else if pickerView == reklamiranaEnotaToplotnaCrpalkaPickerView {
            return reklamiraneEnoteVrste[row]
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
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
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let zunanjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").zunanja"] as? [String] {
                    return zunanjaEnotaKlimatskaNaprava[row]
                }
            }
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
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
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                    return notranjaEnotaKlimatskaNaprava[row]
                }
            }
        } else if pickerView == napravaPickerView {
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
                return rekuperatorNapravaKoda[row]
            } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                return cistilecZrakaNapravaKoda[row]
            }
        } else if pickerView == podtipKlimatskeNapravePickerView {
            if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                if let klimatskePodtipi = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip"] as? [String : Any] {
                    let podtipiArray = Array(klimatskePodtipi.keys)
                    print("Podtipi array", podtipiArray)
                    return podtipiArray[row]
                }
            }
            
        } else if pickerView == reklamiranaEnotaKlimatskaNapravaPickerView {
            return reklamiraneEnoteVrste[row]
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
            reklamiranaEnotaToplotnaCrpalkaTextField.text = reklamiraneEnoteVrste[row]
            reklamiranaEnotaToplotnaCrpalkaTextField.resignFirstResponder()
            
            izbranaReklamiranaEnota = reklamiranaEnotaToplotnaCrpalkaTextField.text
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
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
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                    reklamiranaNotranjaEnotaTextField.text = notranjaEnotaKlimatskaNaprava[row]
                    reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                
                    izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                }
            }
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
            
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
                
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let zunanjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").zunanja"] as? [String] {
                    reklamiranaZunanjaEnotaTextField.text = zunanjaEnotaKlimatskaNaprava[row]
                    reklamiranaZunanjaEnotaTextField.resignFirstResponder()
                    
                    izbranaZunanjaReklamiranaEnota = reklamiranaZunanjaEnotaTextField.text
                }
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
        } else if pickerView == tipNapraveKlimatskaNapravaPickerView {
            tipNapraveKlimatskaNapravaTextField.text = tipiNapravKlimatskeNaprave[row]
            tipNapraveKlimatskaNapravaTextField.resignFirstResponder()
            
            izbranTipNaprave = tipNapraveKlimatskaNapravaTextField.text
        } else if pickerView == podtipKlimatskeNapravePickerView {
            if let klimatskePodtipi = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip"] as? [String : Any] {
                let podtipiArray = Array(klimatskePodtipi.keys)
                
                podtipKlimatskeNapraveTextField.text = podtipiArray[row]
                podtipKlimatskeNapraveTextField.resignFirstResponder()
                
                izbranPodtipNaprave = podtipKlimatskeNapraveTextField.text!
            }
        } else if pickerView == reklamiranaEnotaKlimatskaNapravaPickerView {
            reklamiranaEnotaKlimatskaNapravaTextField.text = reklamiraneEnoteVrste[row]
            reklamiranaEnotaKlimatskaNapravaTextField.resignFirstResponder()
            izbranaReklamiranaEnota = reklamiranaEnotaKlimatskaNapravaTextField.text
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
            print("Izbrana vrsta naprave", izbranaVrstaNaprave)
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                predmetContainerView.addSubview(tipNapraveToplotnaCrpalkaTextField)
                tipNapraveToplotnaCrpalkaTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                tipNapraveToplotnaCrpalkaTextField.inputView = tipNapraveToplotnaCrpalkaPickerView
                tipNapraveToplotnaCrpalkaPickerView.dataSource = self
                tipNapraveToplotnaCrpalkaPickerView.delegate = self
                
            } else if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue || izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                predmetContainerView.addSubview(napravaTextField)
                napravaTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                napravaTextField.inputView = napravaPickerView
                napravaPickerView.delegate = self
                napravaPickerView.dataSource = self
            } else if izbranaVrstaNaprave == VrstaNaprave.Konvektor.rawValue || izbranaVrstaNaprave == VrstaNaprave.VRVSistem.rawValue || izbranaVrstaNaprave == VrstaNaprave.PlinskiKotel.rawValue {
                
                // add oznaka naprave textfield
                predmetContainerView.addSubview(oznakaNapraveTextField)
                oznakaNapraveTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                //
                predmetContainerView.addSubview(tipNapraveKlimatskaNapravaTextField)
                tipNapraveKlimatskaNapravaTextField.anchor(top: vrstaNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: vrstaNapraveTextField.rightAnchor, paddingRight: 0, left: vrstaNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                tipNapraveKlimatskaNapravaTextField.inputView = tipNapraveKlimatskaNapravaPickerView
                tipNapraveKlimatskaNapravaPickerView.delegate = self
                tipNapraveKlimatskaNapravaPickerView.dataSource = self
            }
        }
    }
    
    var izbranTipNaprave : String? {
        
        willSet {
            for subView in predmetContainerView.subviews {
                if !(subView == vrstaNapraveTextField) && !(subView == tipNapraveToplotnaCrpalkaTextField) && !(subView == tipNapraveKlimatskaNapravaTextField) {
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet {
            
            print("Izbran tip naprave:", izbranTipNaprave)
            
            if izbranTipNaprave == TipNapraveToplotnaCrpalka.VisokoTemperaturna.rawValue || izbranTipNaprave == TipNapraveToplotnaCrpalka.NizkoTemperaturna.rawValue || izbranTipNaprave == TipNapraveToplotnaCrpalka.Hibridna.rawValue {
                
                predmetContainerView.addSubview(reklamiranaEnotaToplotnaCrpalkaTextField)
                reklamiranaEnotaToplotnaCrpalkaTextField.anchor(top: tipNapraveToplotnaCrpalkaTextField.bottomAnchor, paddingTop: textFieldPadding, right: tipNapraveToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: tipNapraveToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaEnotaToplotnaCrpalkaTextField.inputView = reklamiranaEnotaToplotnaCrpalkaPickerView
                reklamiranaEnotaToplotnaCrpalkaPickerView.delegate = self
                reklamiranaEnotaToplotnaCrpalkaPickerView.dataSource = self
                
            } else if izbranTipNaprave == TipNapraveToplotnaCrpalka.Monoblok.rawValue {
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: tipNapraveToplotnaCrpalkaTextField.bottomAnchor, paddingTop: textFieldPadding, right: tipNapraveToplotnaCrpalkaTextField.rightAnchor, paddingRight: 0, left: tipNapraveToplotnaCrpalkaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
            } else if izbranTipNaprave == TipNapraveKlimatskaNaprava.Stenska.rawValue || izbranTipNaprave == TipNapraveKlimatskaNaprava.Talna.rawValue || izbranTipNaprave == TipNapraveKlimatskaNaprava.Kasetna.rawValue || izbranTipNaprave == TipNapraveKlimatskaNaprava.SkritaStropna.rawValue || izbranTipNaprave == TipNapraveKlimatskaNaprava.Flexi.rawValue {
                // add podtip naprave
                predmetContainerView.addSubview(podtipKlimatskeNapraveTextField)
                podtipKlimatskeNapraveTextField.anchor(top: tipNapraveKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: tipNapraveKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: tipNapraveKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                podtipKlimatskeNapraveTextField.inputView = podtipKlimatskeNapravePickerView
                podtipKlimatskeNapravePickerView.delegate = self
                podtipKlimatskeNapravePickerView.dataSource = self
            }
            
        }
    }
    
    var izbranaReklamiranaEnota : String? {
        
        willSet {
            for subView in predmetContainerView.subviews {
                if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                    if !(subView == vrstaNapraveTextField) && !(subView == tipNapraveToplotnaCrpalkaTextField) && !(subView == reklamiranaEnotaToplotnaCrpalkaTextField) {
                        subView.removeFromSuperview()
                    }
                } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                    if !(subView == vrstaNapraveTextField) && !(subView == tipNapraveKlimatskaNapravaTextField) && !(subView == reklamiranaEnotaKlimatskaNapravaTextField) && !(subView == podtipKlimatskeNapraveTextField) {
                        subView.removeFromSuperview()
                    }
                }
            }
        }
        
        didSet {
            
            var izbranaToplotna = (izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue) ? true : false
            print("Izbrana reklamirana enota", izbranaReklamiranaEnota)
            
            if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                
                // add notranja enota toplotna view
                
                predmetContainerView.addSubview(reklamiranaNotranjaEnotaTextField)
                reklamiranaNotranjaEnotaTextField.anchor(top: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor : reklamiranaEnotaKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor : reklamiranaEnotaKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor : reklamiranaEnotaKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaNotranjaEnotaTextField.inputView = notranjaEnotaPickerView
                notranjaEnotaPickerView.delegate = self
                notranjaEnotaPickerView.dataSource = self
                
                
            } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue {
                
                // add zunanja enota toplotna view
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor : reklamiranaEnotaKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor : reklamiranaEnotaKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor : reklamiranaEnotaKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
                
            } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                
                // add both above
                
                predmetContainerView.addSubview(reklamiranaNotranjaEnotaTextField)
                reklamiranaNotranjaEnotaTextField.anchor(top: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor : reklamiranaEnotaKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor : reklamiranaEnotaKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor : reklamiranaEnotaKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaNotranjaEnotaTextField.inputView = notranjaEnotaPickerView
                notranjaEnotaPickerView.delegate = self
                notranjaEnotaPickerView.dataSource = self
                
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: reklamiranaNotranjaEnotaTextField.bottomAnchor, paddingTop: textFieldPadding, right: reklamiranaNotranjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaNotranjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
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
    
    var izbranPodtipNaprave : String? {
        didSet {
            print("Podtip:", izbranPodtipNaprave)
            predmetContainerView.addSubview(reklamiranaEnotaKlimatskaNapravaTextField)
            reklamiranaEnotaKlimatskaNapravaTextField.anchor(top: podtipKlimatskeNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: podtipKlimatskeNapraveTextField.rightAnchor, paddingRight: 0, left: podtipKlimatskeNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
            reklamiranaEnotaKlimatskaNapravaTextField.inputView = reklamiranaEnotaKlimatskaNapravaPickerView
            reklamiranaEnotaKlimatskaNapravaPickerView.delegate = self
            reklamiranaEnotaKlimatskaNapravaPickerView.dataSource = self
        }
    }
    
    // let predmet views
//    let predmetScrollView : UIScrollView = {
//        let v = UIScrollView()
//        v.backgroundColor = UIColor.airabelaGray
//        return v
//    }()
    
    let predmetContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let tipNapraveKlimatskaNapravaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "TIP NAPRAVE"
        return tf
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
    
    let reklamiranaEnotaKlimatskaNapravaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "REKLAMIRANA ENOTA"
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
    
    let podtipKlimatskeNapraveTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "PODTIP NAPRAVE:"
        return tf
    }()
    
    let podtipKlimatskeNapravePickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let tipNapraveKlimatskaNapravaPickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let vrstaNapravePickerView : UIPickerView = {
        let pv = UIPickerView()
        return pv
    }()
    
    let reklamiranaEnotaKlimatskaNapravaPickerView : UIPickerView = {
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
        
        navigationItem.title = "NAPRAVA"
        
        naprejButton.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [nazajButton, naprejButton])
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
        
//        predmetScrollView.addSubview(predmetContainerView)
//        predmetContainerView.anchor(top: predmetScrollView.topAnchor, paddingTop: 0, right: predmetScrollView.rightAnchor, paddingRight: 0, left: predmetScrollView.leftAnchor, paddingLeft: 0, bottom: predmetScrollView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
//        predmetContainerView.widthAnchor.constraint(equalTo: predmetScrollView.widthAnchor, multiplier: 1).isActive = true
//        predmetContainerView.heightAnchor.constraint(equalTo: predmetScrollView.heightAnchor, multiplier: 1).isActive = true
        
        predmetContainerView.addSubview(vrstaNapraveTextField)
        vrstaNapraveTextField.anchor(top: predmetContainerView.topAnchor, paddingTop: 0, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        vrstaNapraveTextField.inputView = vrstaNapravePickerView
        vrstaNapravePickerView.dataSource = self
        vrstaNapravePickerView.delegate = self
        
    }
    
}
