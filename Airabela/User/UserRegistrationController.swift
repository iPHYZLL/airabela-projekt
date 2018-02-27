//
//  UserRegistrationController.swift
//  Airabela
//
//  Created by Alen Kirm on 13. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class UserRegistrationController: UIViewController, UITextFieldDelegate {
    
    var pogojiChecked : Bool = false
    
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
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
        tf.addTarget(self, action: #selector(formValid), for: UIControlEvents.editingChanged)
        return tf
    }()
    
    let iconLabel : UILabel = {
        let bl = UILabel()
        bl.textColor = UIColor.airabelaGray
        bl.textAlignment = .center
        bl.numberOfLines = 0
        bl.text = "REGISTRACIJA UPORABNIKA"
        bl.font = UIFont.boldSystemFont(ofSize: 16)
        return bl
    }()
    
    let iconImage : UIImageView = {
        let bi = UIImageView()
        bi.contentMode = .scaleAspectFit
        bi.image = #imageLiteral(resourceName: "user").withRenderingMode(.alwaysTemplate)
        bi.tintColor = UIColor.airabelaGray
        return bi
    }()
    
    let textViewContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let homeScreenButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("SHRANI", for: .normal)
        b.addTarget(self, action: #selector(showHomeScreen), for: .touchUpInside)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return b
    }()
    
    let splosniPogojiButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("SPLOŠNI POGOJI", for: .normal)
        b.addTarget(self, action: #selector(showPogoji), for: .touchUpInside)
        b.setTitleColor(UIColor.airabelaBlue, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return b
    }()
    
    let pogojiLabel : UILabel = {
        let pl = UILabel()
        pl.text = "Strinjam se z pogoji uporabe"
        pl.font = UIFont.systemFont(ofSize: 10)
        pl.textColor = .black
        return pl
    }()
    
    let pogojiBtn : UIButton = {
        let b = UIButton(type: .system)
        b.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        b.tintColor = UIColor.airabelaBlue
        b.addTarget(self, action: #selector(handleSeStrinjaZPogoji), for: .touchUpInside)
        return b
    }()
    
    @objc func handleSeStrinjaZPogoji() {
        pogojiChecked = !pogojiChecked
        print(pogojiChecked)
        if pogojiChecked {
            pogojiBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
        } else {
            pogojiBtn.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
    @objc func showPogoji() {
        let pogojiController = PogojiController()
        present(pogojiController, animated: true, completion: nil)
        
        pogojiChecked = true
        pogojiBtn.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
    }
    
    @objc func showHomeScreen() {
        
        if pogojiChecked && formValid() {
            registerUser()
            
            let homeController = HomeController()
            let mainNavigationViewController = UINavigationController(rootViewController: homeController)
            if #available(iOS 11.0, *) {
                mainNavigationViewController.navigationBar.prefersLargeTitles = true
            }
            mainNavigationViewController.navigationBar.isTranslucent = false
            mainNavigationViewController.navigationBar.barTintColor = UIColor.airabelaBlue
            mainNavigationViewController.navigationBar.tintColor = UIColor.airabelaGray
            present(mainNavigationViewController, animated: true, completion: nil)
        } else {
            let actionController = UIAlertController(title: "Napaka", message: "\nZa registracijo se morate strinjati z pogoji uporabe ter izpolniti vsa polja.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Prekliči", style: .cancel, handler: nil)
            actionController.addAction(cancelAction)
            
            present(actionController, animated: true, completion: nil)
            
            return
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.airabelaBlue
        
        addSubviews()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func formValid() -> Bool{
        
        let isFormValid = podjetjeTextField.text?.count ?? 0 > 0 && naslovTextField.text?.count ?? 0 > 0 && krajTextField.text?.count ?? 0 > 0 && postnaStTextField.text?.count ?? 0 > 0 && davcnaStTextField.text?.count ?? 0 > 0 && kontaktnaOsebaTextField.text?.count ?? 0 > 0 && kontaktniEnaslovTextField.text?.count ?? 0 > 0 && kontaktnaTelefonskaStTextField.text?.count ?? 0 > 0
        
        return isFormValid
    }
    
    fileprivate func registerUser() {
        
        guard let podjetje = podjetjeTextField.text else { return }
        guard let naslov = naslovTextField.text else { return }
        guard let kraj = krajTextField.text else { return }
        guard let postnaSt = postnaStTextField.text else { return }
        guard let davcnaSt = davcnaStTextField.text else { return }
        guard let kontaktnaOseba = kontaktnaOsebaTextField.text else { return }
        guard let kontaktniEnaslov = kontaktniEnaslovTextField.text else { return }
        guard let kontaktnaTelefonskaSt = kontaktnaTelefonskaStTextField.text else { return }
        
        let davcnaStevilka = "SI\(davcnaSt)"
        
        let defaults = UserDefaults.standard
        defaults.set(podjetje, forKey: "podjetje")
        defaults.set(naslov, forKey: "naslov")
        defaults.set(kraj, forKey: "kraj")
        defaults.set(postnaSt, forKey: "postnaSt")
        defaults.set(davcnaStevilka, forKey: "davcnaSt")
        defaults.set(kontaktnaOseba, forKey: "kontaktnaOseba")
        defaults.set(kontaktniEnaslov, forKey: "kontaktniEnaslov")
        defaults.set(kontaktnaTelefonskaSt, forKey: "kontaktnaTelefonskaSt")
        defaults.set(true, forKey: "jeRegistriran")
        
    }
    
    fileprivate func addSubviews() {
        view.addSubview(headerView)
        if #available(iOS 11.0, *) {
            headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        } else {
            // Fallback on earlier versions
            headerView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        }
        
        let stackView = UIStackView(arrangedSubviews: [iconImage, iconLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        
        headerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        view.addSubview(textViewContainerView)
        textViewContainerView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        textViewContainerView.addSubview(homeScreenButton)
        
        if #available(iOS 11.0, *) {
            homeScreenButton.anchor(top: nil, paddingTop: 0, right: textViewContainerView.rightAnchor, paddingRight: 20, left: textViewContainerView.leftAnchor, paddingLeft: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 50)
        } else {
            // Fallback on earlier versions
            homeScreenButton.anchor(top: nil, paddingTop: 0, right: textViewContainerView.rightAnchor, paddingRight: 20, left: textViewContainerView.leftAnchor, paddingLeft: 20, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 50)
        }
        
        let pogojiStackView = UIStackView(arrangedSubviews: [pogojiBtn, pogojiLabel])
        pogojiStackView.distribution = .fillProportionally
        pogojiStackView.spacing = 5
        
        textViewContainerView.addSubview(pogojiStackView)
        pogojiStackView.anchor(top: nil, paddingTop: 10, right: nil, paddingRight: 0, left: nil, paddingLeft: 0, bottom: homeScreenButton.topAnchor, paddingBottom: 10, width: 0, height: 20)
        
        textViewContainerView.addSubview(splosniPogojiButton)
        splosniPogojiButton.anchor(top: nil, paddingTop: 0, right: textViewContainerView.rightAnchor, paddingRight: 60, left: textViewContainerView.leftAnchor, paddingLeft: 40, bottom: pogojiStackView.topAnchor, paddingBottom: 10, width: 0, height: 20)
        
        pogojiStackView.centerXAnchor.constraint(equalTo: splosniPogojiButton.centerXAnchor).isActive = true
        
        let registrationStackView = UIStackView(arrangedSubviews: [podjetjeTextField ,naslovTextField, postnaStTextField, krajTextField, davcnaStTextField, kontaktnaOsebaTextField, kontaktniEnaslovTextField, kontaktnaTelefonskaStTextField])
        
        registrationStackView.subviews.forEach { (view) in
            guard let textView = view as? UITextField else { return }
            textView.delegate = self
        }
        
        registrationStackView.axis = .vertical
        registrationStackView.distribution = .fillEqually
        registrationStackView.spacing = 5
        
        textViewContainerView.addSubview(registrationStackView)
        registrationStackView.anchor(top: headerView.bottomAnchor, paddingTop: 20, right: textViewContainerView.rightAnchor, paddingRight: 40, left: textViewContainerView.leftAnchor, paddingLeft: 40, bottom: splosniPogojiButton.topAnchor, paddingBottom: 10, width: 0, height: 0)
    }

}





















