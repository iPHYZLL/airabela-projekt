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
    
    fileprivate func isValid() -> Bool {
        
        for case let textField as UITextField in predmetContainerView.subviews {
            if textField.text == "" || textField.text == "Izberi..." {
                return false
            }
        }
        
        return true
        
    }
    
    fileprivate func getOznakaNaprave() -> String? {
        
        if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaEnota.rawValue || izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
            return oznakaNapraveTextField.text ?? nil
        } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
            return "Drugo - Zunanja : \(oznakaNapraveDrugoZunanjaEnotaTextField.text ?? "\(izbranaZunanjaReklamiranaEnota ?? nil)"), Drugo - Notranja : \(oznakaNapraveDrugoNotranjaEnotaTextField.text ?? "\(izbranaNotranjaReklamiranaEnota ?? nil)")"
        }
        
        return oznakaNapraveTextField.text ?? nil
    }
    
    fileprivate func getZunanja() -> String? {
        if izbranaZunanjaReklamiranaEnota == "drugo" {
            return "\(izbranaZunanjaReklamiranaEnota ?? "") - \(oznakaNapraveDrugoZunanjaEnotaTextField.text ?? "")"
        }
        return izbranaZunanjaReklamiranaEnota ?? nil
    }
    
    fileprivate func getNotranja() -> String? {
        if izbranaNotranjaReklamiranaEnota == "drugo" {
            return "\(izbranaNotranjaReklamiranaEnota ?? "") - \(oznakaNapraveDrugoNotranjaEnotaTextField.text ?? "")"
        }
        return izbranaNotranjaReklamiranaEnota ?? nil
    }
    
    @objc func handleNaprejButton() {
        
        // init predmet
        let opisReklamacijeController = OpisReklamacijeController()
        var predmet : Naprava?
        
        if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {

            predmet = ToplotnaCrpalka(tipNaprave: izbranTipNaprave, reklamirnaEnota: izbranaReklamiranaEnota, zunanjaEnotaStevilka: getZunanja(), notranjaEnotaStevilka: getNotranja())

        } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
            
            predmet = KlimatskaNaprava(tipNaprave: izbranTipNaprave!, podTipNaprave: izbranPodtipNaprave, reklamiranaEnota: izbranaReklamiranaEnota, oznakaNaprave: getOznakaNaprave(), zunanjaEnota: getZunanja(), notranjaEnota: getNotranja())
        } else if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue {
            
            predmet = Rekuperator(naprava: izbranaNaprava ?? "", oznakaNaprave: getOznakaNaprave())
        } else if izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
            
            predmet = CistilecZraka(naprava: izbranaNaprava ?? "", oznakaNaprave: getOznakaNaprave())
        } else if izbranaVrstaNaprave == VrstaNaprave.Konvektor.rawValue {
            
            predmet = Konvektor(oznakaNaprave: getOznakaNaprave())
        } else if izbranaVrstaNaprave == VrstaNaprave.VRVSistem.rawValue {
            
            predmet = VRVSistem(oznakaNaprave: getOznakaNaprave())
        } else {
            // plinski kotel
            predmet = PlinskiKotel(oznakaNaprave: getOznakaNaprave())
        }
        
        reklamacija?.naprava = predmet
        
        if isValid() {
            
            opisReklamacijeController.reklamacija = reklamacija
            
            navigationController?.pushViewController(opisReklamacijeController, animated: true)
            
        } else {
            
            showAlert()
        
        }
    }
    
    fileprivate func showAlert() {
        
        let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika potrebujemo vse podatke reklamirane naprave.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "V REDU", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
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
                
                if let zunanjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Zunanja enota"] as? [String] {
                    return zunanjaEnotaToplotnaCrpalka.count
                }
                
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let zunanjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").zunanja"] as? [String] {
                    return zunanjaEnotaKlimatskaNaprava.count
                }
                
            }
            
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                        return notranjaEnotaToplotnaCrpalka.count
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                            return notranjaEnotaToplotnaCrpalka.count
                        }
                    } else {
                        if let filtriranaNotranja = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            return filtriranaNotranja.count
                        }
                    }
                    
                }
                
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                        return notranjaEnotaKlimatskaNaprava.count
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                            return notranjaEnotaKlimatskaNaprava.count
                        }
                    } else {
                        if let filriranaNotranja = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            return filriranaNotranja.count
                        }
                    }
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
                
                if let zunanjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Zunanja enota"] as? [String] {
                    return zunanjaEnotaToplotnaCrpalka[row]
                }
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if let zunanjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").zunanja"] as? [String] {
                    return zunanjaEnotaKlimatskaNaprava[row]
                }
                
            }
        } else if pickerView == notranjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                        return notranjaEnotaToplotnaCrpalka[row]
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                            return notranjaEnotaToplotnaCrpalka[row]
                        }
                    } else {
                        if let filtriranaNotranja = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            return filtriranaNotranja[row]
                        }
                    }
                    
                    
                }
                
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                        return notranjaEnotaKlimatskaNaprava[row]
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                            return notranjaEnotaKlimatskaNaprava[row]
                        }
                    } else {
                        if let filriranaNotranja = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            return filriranaNotranja[row]
                        }
                    }
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
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                        reklamiranaNotranjaEnotaTextField.text = notranjaEnotaToplotnaCrpalka[row]
                        reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                        
                        izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Notranja enota"] as? [String] {
                            reklamiranaNotranjaEnotaTextField.text = notranjaEnotaToplotnaCrpalka[row]
                            reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                            
                            izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                        }
                    } else {
                        if let filtriranaNotranja = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            reklamiranaNotranjaEnotaTextField.text = filtriranaNotranja[row]
                            reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                            
                            izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                        }
                    }
                    
                }
            
            } else if izbranaVrstaNaprave == VrstaNaprave.KlimatskaNaprava.rawValue {
                
                if izbranaReklamiranaEnota == ReklamiranaEnota.NotranjaEnota.rawValue {
                    if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                        reklamiranaNotranjaEnotaTextField.text = notranjaEnotaKlimatskaNaprava[row]
                        reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                        
                        izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                    }
                } else if izbranaReklamiranaEnota == ReklamiranaEnota.ZunanjaInNotranjaEnota.rawValue {
                    
                    if izbranaZunanjaReklamiranaEnota == "drugo" {
                        if let notranjaEnotaKlimatskaNaprava = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").notranja"] as? [String] {
                            reklamiranaNotranjaEnotaTextField.text = notranjaEnotaKlimatskaNaprava[row]
                            reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                            
                            izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                        }
                    } else {
                        
                        if let filriranaNotranja = klimatskeNapraveDictionary[keyPath : "\(izbranTipNaprave ?? "").podtip.\(izbranPodtipNaprave ?? "").\(izbranaZunanjaReklamiranaEnota ?? "")"] as? [String] {
                            reklamiranaNotranjaEnotaTextField.text = filriranaNotranja[row]
                            reklamiranaNotranjaEnotaTextField.resignFirstResponder()
                            
                            izbranaNotranjaReklamiranaEnota = reklamiranaNotranjaEnotaTextField.text
                        }
                    }
                }
            }
        } else if pickerView == zunanjaEnotaPickerView {
            
            if izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue {
                
                if let zunanjaEnotaToplotnaCrpalka = toplotneCrpalkeDictionary[keyPath : "\(izbranTipNaprave ?? "").Zunanja enota"] as? [String] {
                    reklamiranaZunanjaEnotaTextField.text = zunanjaEnotaToplotnaCrpalka[row]
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
            
            oznakaNapraveTextField.text == ""
            
            napravaTextField.text = ""
            napravaPickerView.selectRow(0, inComponent: 0, animated: true)
            
            for subView in predmetContainerView.subviews {
                if !(subView == vrstaNapraveTextField) {
                    subView.removeFromSuperview()
                }
            }
        }
        
        didSet {
            
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
            } else if izbranTipNaprave == TipNapraveKlimatskaNaprava.Nordic.rawValue || izbranTipNaprave == TipNapraveKlimatskaNaprava.MultiSplitSistem.rawValue {
                //add oznaka naprave
                predmetContainerView.addSubview(oznakaNapraveTextField)
                oznakaNapraveTextField.anchor(top: tipNapraveKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: tipNapraveKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: tipNapraveKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
            }
            
        }
    }
    
    fileprivate func showReklamiranaEnotaTextFieldsIfNeeded() {
        if reklamiranaNotranjaEnotaTextField.isHidden {
            reklamiranaNotranjaEnotaTextField.isHidden = !(reklamiranaNotranjaEnotaTextField.isHidden)
        }
        
        if reklamiranaZunanjaEnotaTextField.isHidden {
            reklamiranaZunanjaEnotaTextField.isHidden = !(reklamiranaZunanjaEnotaTextField.isHidden)
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
                
                showReklamiranaEnotaTextFieldsIfNeeded()
            }
            
            // reset zunajna in notranja koda
            zunanjaEnotaPickerView.selectRow(0, inComponent: 0, animated: false)
            reklamiranaZunanjaEnotaTextField.text = nil
            izbranaZunanjaReklamiranaEnota = nil
            notranjaEnotaPickerView.selectRow(0, inComponent: 0, animated: false)
            reklamiranaNotranjaEnotaTextField.text = nil
            izbranaNotranjaReklamiranaEnota = nil
        }
        
        didSet {
            
            var izbranaToplotna = (izbranaVrstaNaprave == VrstaNaprave.ToplotnaCrpalka.rawValue) ? true : false
            
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
                
                predmetContainerView.addSubview(reklamiranaZunanjaEnotaTextField)
                reklamiranaZunanjaEnotaTextField.anchor(top: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.bottomAnchor : reklamiranaEnotaKlimatskaNapravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.rightAnchor : reklamiranaEnotaKlimatskaNapravaTextField.rightAnchor, paddingRight: 0, left: izbranaToplotna ? reklamiranaEnotaToplotnaCrpalkaTextField.leftAnchor : reklamiranaEnotaKlimatskaNapravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaZunanjaEnotaTextField.inputView = zunanjaEnotaPickerView
                zunanjaEnotaPickerView.delegate = self
                zunanjaEnotaPickerView.dataSource = self
                
                predmetContainerView.addSubview(reklamiranaNotranjaEnotaTextField)
                reklamiranaNotranjaEnotaTextField.anchor(top: reklamiranaZunanjaEnotaTextField.bottomAnchor, paddingTop: textFieldPadding, right: reklamiranaZunanjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaZunanjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                reklamiranaNotranjaEnotaTextField.inputView = notranjaEnotaPickerView
                notranjaEnotaPickerView.delegate = self
                notranjaEnotaPickerView.dataSource = self
                
            }
            
        }
        
    }
    
    var izbranaZunanjaReklamiranaEnota : String? {
        
        willSet {
            oznakaNapraveDrugoZunanjaEnotaTextField.removeFromSuperview()
        }
        
        didSet {
            
            reklamiranaNotranjaEnotaTextField.text = nil
            notranjaEnotaPickerView.selectRow(0, inComponent: 0, animated: true)
            
            // check if drugo
            guard let zunanja = izbranaZunanjaReklamiranaEnota else { return }
            
            if zunanja.lowercased() == "drugo" {
                if izbranaReklamiranaEnota == "Zunanja enota" {
                    predmetContainerView.addSubview(oznakaNapraveDrugoZunanjaEnotaTextField)
                    oznakaNapraveDrugoZunanjaEnotaTextField.anchor(top: reklamiranaZunanjaEnotaTextField.bottomAnchor, paddingTop: textFieldPadding, right: reklamiranaZunanjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaZunanjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                } else if izbranaReklamiranaEnota == "Zunanja in notranja enota" {
                    
                    reklamiranaZunanjaEnotaTextField.isHidden = true
                    predmetContainerView.addSubview(oznakaNapraveDrugoZunanjaEnotaTextField)
                    oznakaNapraveDrugoZunanjaEnotaTextField.anchor(top: reklamiranaZunanjaEnotaTextField.topAnchor, paddingTop: 0, right: reklamiranaZunanjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaZunanjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                }
            }
        }
    }
    
    var izbranaNotranjaReklamiranaEnota : String? {
        
        willSet {
            oznakaNapraveDrugoNotranjaEnotaTextField.removeFromSuperview()
        }
        
        didSet {
            // check if drugo
            guard let notranja = izbranaNotranjaReklamiranaEnota else { return }
            
            if notranja.lowercased() == "drugo" {
                if izbranaReklamiranaEnota == "Notranja enota" {
                    predmetContainerView.addSubview(oznakaNapraveDrugoNotranjaEnotaTextField)
                    oznakaNapraveDrugoNotranjaEnotaTextField.anchor(top: reklamiranaNotranjaEnotaTextField.bottomAnchor, paddingTop: textFieldPadding, right: reklamiranaNotranjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaNotranjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                } else if izbranaReklamiranaEnota == "Zunanja in notranja enota" {
                    
                    reklamiranaNotranjaEnotaTextField.isHidden = true
                    predmetContainerView.addSubview(oznakaNapraveDrugoNotranjaEnotaTextField)
                    oznakaNapraveDrugoNotranjaEnotaTextField.anchor(top: reklamiranaNotranjaEnotaTextField.topAnchor, paddingTop: 0, right: reklamiranaNotranjaEnotaTextField.rightAnchor, paddingRight: 0, left: reklamiranaNotranjaEnotaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                }
                
            }
        }
    }
    
    var izbranaNaprava : String? {
        
        willSet {
            oznakaNapraveTextField.removeFromSuperview()
        }
        
        didSet {
            
            if izbranaVrstaNaprave == VrstaNaprave.Rekuperator.rawValue || izbranaVrstaNaprave == VrstaNaprave.CistilecZraka.rawValue {
                
                if izbranaNaprava == "Drugo" {
                    predmetContainerView.addSubview(oznakaNapraveTextField)
                    oznakaNapraveTextField.anchor(top: napravaTextField.bottomAnchor, paddingTop: textFieldPadding, right: napravaTextField.rightAnchor, paddingRight: 0, left: napravaTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                }
            }
        }
    }
    
    var oznakaNaprave : String?
    
    var izbranPodtipNaprave : String? {
        didSet {
            predmetContainerView.addSubview(reklamiranaEnotaKlimatskaNapravaTextField)
            reklamiranaEnotaKlimatskaNapravaTextField.anchor(top: podtipKlimatskeNapraveTextField.bottomAnchor, paddingTop: textFieldPadding, right: podtipKlimatskeNapraveTextField.rightAnchor, paddingRight: 0, left: podtipKlimatskeNapraveTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
            reklamiranaEnotaKlimatskaNapravaTextField.inputView = reklamiranaEnotaKlimatskaNapravaPickerView
            reklamiranaEnotaKlimatskaNapravaPickerView.delegate = self
            reklamiranaEnotaKlimatskaNapravaPickerView.dataSource = self
        }
    }

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
    
    let oznakaNapraveDrugoZunanjaEnotaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "OZNAKA ZUNANJE ENOTE:"
        return tf
    }()
    
    let oznakaNapraveDrugoNotranjaEnotaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.placeholder = "OZNAKA NOTRANJE ENOTE:"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "NAPRAVA"
        
        self.navigationItem.hidesBackButton = true
        
        let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backImage"), style: .plain, target: self, action: #selector(handleNazajButton))
        backBtn.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0)
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        naprejButton.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [nazajButton, naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        // add scroll view
        
        view.addSubview(predmetContainerView)
        predmetContainerView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: buttonsStackView.rightAnchor, paddingRight: 0, left: buttonsStackView.leftAnchor, paddingLeft: 0, bottom: buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        predmetContainerView.addSubview(vrstaNapraveTextField)
        vrstaNapraveTextField.anchor(top: predmetContainerView.topAnchor, paddingTop: 0, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        vrstaNapraveTextField.inputView = vrstaNapravePickerView
        vrstaNapravePickerView.dataSource = self
        vrstaNapravePickerView.delegate = self
        
    }
    
}
