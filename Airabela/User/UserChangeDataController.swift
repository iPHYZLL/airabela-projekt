//
//  UserChangeDataController.swift
//  Airabela
//
//  Created by Alen Kirm on 16. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class UserChangeDataController: UIViewController, UITextFieldDelegate {
    
    let userDefaults = UserDefaults.standard
    
    let headerView : UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor.airabelaBlue
        return hv
    }()
    
    let podjetjeTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Podjetje"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.alphabet
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let naslovTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Naslov"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.alphabet
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let postnaStTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Poštna številka"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let krajTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Kraj"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.alphabet
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let davcnaStTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Davčna številka"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let kontaktnaOsebaTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Kontaktna oseba"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.alphabet
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let kontaktniEnaslovTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Kontaktni e-naslov"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let kontaktnaTelefonskaStTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "Kontaktna telefonska številka"
        tf.backgroundColor = UIColor.airabelaGray
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.keyboardType = UIKeyboardType.phonePad
        tf.font = UIFont.boldSystemFont(ofSize: 14)
        return tf
    }()
    
    let contentView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let iconLabel : UILabel = {
        let bl = UILabel()
        bl.textColor = UIColor.airabelaGray
        bl.textAlignment = .center
        bl.numberOfLines = 0
        bl.text = "SPREMENI PODATKE"
        bl.font = UIFont.boldSystemFont(ofSize: 16)
        return bl
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
    
    let spremeniButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("SHRANI", for: .normal)
        b.addTarget(self, action: #selector(handleSpremeniUserPodatke), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    var registrationStackView : UIStackView?
    
    @objc func handleSpremeniUserPodatke() {
        
        guard let registrationStackView = registrationStackView else { return }
        
        let alertController = UIAlertController(title: "NAPAKA", message: "Podatke ni možno izbrisati. Prosimo vas, da zapolnete vsa polja.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        var canProceed = true
        
        registrationStackView.subviews.forEach { (view) in
            if view.isKind(of: HoshiTextField.self) {
                guard let textField = view as? UITextField else { return }
                
                if textField.text == "" {
                    canProceed = !canProceed
                    present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        
        let podjetjeText = podjetjeTextField.text
        let naslovText = naslovTextField.text
        let krajText = krajTextField.text
        let postnaSt = postnaStTextField.text
        let davcnaSt = davcnaStTextField.text
        let kontaktnaOseba = kontaktnaOsebaTextField.text
        let kontaktniEmail = kontaktniEnaslovTextField.text
        let kontaktnaTelefonskaSt = kontaktnaTelefonskaStTextField.text
        
        if canProceed {
            userDefaults.set(podjetjeText, forKey: "podjetje")
            userDefaults.set(naslovText, forKey: "naslov")
            userDefaults.set(krajText, forKey: "kraj")
            userDefaults.set(postnaSt, forKey: "postnaSt")
            userDefaults.set(davcnaSt, forKey: "davcnaSt")
            userDefaults.set(kontaktnaOseba, forKey: "kontaktnaOseba")
            userDefaults.set(kontaktniEmail, forKey: "kontaktniEnaslov")
            userDefaults.set(kontaktnaTelefonskaSt, forKey: "kontaktnaTelefonskaSt")
            userDefaults.synchronize()
            
            if let parentVC = self.presentingViewController as? UserProfileController {
                parentVC.updateTextFields()
            }
            
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    func getData() {
        
        if let podjetje = userDefaults.object(forKey: "podjetje") as? String {
            podjetjeTextField.text = podjetje
        }
        
        if let naslov = userDefaults.object(forKey: "naslov") as? String {
            naslovTextField.text = naslov
        }
        
        if let kraj = userDefaults.object(forKey: "kraj") as? String {
            krajTextField.text = kraj
        }
        
        if let postnaSt = userDefaults.object(forKey: "postnaSt") as? String {
            postnaStTextField.text = postnaSt
        }
        
        if let davcnaSt = userDefaults.object(forKey: "davcnaSt") as? String {
            davcnaStTextField.text = davcnaSt
        }
        
        if let kontaktnaOseba = userDefaults.object(forKey: "kontaktnaOseba") as? String {
            kontaktnaOsebaTextField.text = kontaktnaOseba
        }
        
        if let kontaktniEnaslov = userDefaults.object(forKey: "kontaktniEnaslov") as? String {
            kontaktniEnaslovTextField.text = kontaktniEnaslov
        }
        
        if let kontaktnaTelefonskaSt = userDefaults.object(forKey: "kontaktnaTelefonskaSt") as? String {
            kontaktnaTelefonskaStTextField.text = kontaktnaTelefonskaSt
        }
    }
    
    @objc func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        view.addSubview(contentView)
        
        if #available(iOS 11.0, *) {
            contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
            contentView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        }
        
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(iconLabel)
        iconLabel.anchorCenter(to: headerView, withHeight: 0, andWidth: 0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [closeButton, spremeniButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        contentView.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: contentView.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        registrationStackView = UIStackView(arrangedSubviews: [podjetjeTextField ,naslovTextField, postnaStTextField, krajTextField, davcnaStTextField, kontaktnaOsebaTextField, kontaktniEnaslovTextField, kontaktnaTelefonskaStTextField])
        
        guard let registrationStackView = registrationStackView else { return }
        
        registrationStackView.subviews.forEach { (view) in
            guard let textView = view as? UITextField else { return }
            textView.delegate = self
        }
        
        registrationStackView.axis = .vertical
        registrationStackView.distribution = .fillEqually
        registrationStackView.spacing = 5
        
        contentView.addSubview(registrationStackView)
        registrationStackView.anchor(top: headerView.bottomAnchor, paddingTop: 10, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: buttonsStackView.topAnchor, paddingBottom: 10, width: 0, height: 0)
        
    }
    
}
