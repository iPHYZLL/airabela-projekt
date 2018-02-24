//
//  UserProfileController.swift
//  Airabela
//
//  Created by Alen Kirm on 15. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class UserProfileController: UIViewController {
    
    let contentView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let headerView : UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor.airabelaBlue
        return hv
    }()
    
    let closeButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("ZAPRI", for: .normal)
        b.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    let spremeniButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("SPREMENI", for: .normal)
        b.addTarget(self, action: #selector(handleSpremeniUserPodatke), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    let iconLabel : UILabel = {
        let bl = UILabel()
        bl.textColor = UIColor.airabelaGray
        bl.textAlignment = .center
        bl.numberOfLines = 0
        bl.text = "UPORABNIŠKI PROFIL"
        bl.font = UIFont.boldSystemFont(ofSize: 16)
        return bl
    }()
    
    let podjetjeInfoLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.airabelaBlue
        l.text = "PODJETJE"
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let podjetjeLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let podjetje = UserDefaults.standard.object(forKey: "podjetje") as? String
        l.text = podjetje?.uppercased()
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let naslovLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let podjetje = UserDefaults.standard.object(forKey: "naslov") as? String
        l.text = podjetje?.uppercased()
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let krajInPostnaStLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let kraj = UserDefaults.standard.object(forKey: "kraj") as? String
        let postnaSt = UserDefaults.standard.object(forKey: "postnaSt") as? String
        l.text = "\(postnaSt ?? "0") \(kraj?.uppercased() ?? "")"
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let davcnaStLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let davcnaSt = UserDefaults.standard.object(forKey: "davcnaSt") as? String
        l.text = davcnaSt
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let kontaktnaOsebaInfoLabel : UILabel = {
        let l = UILabel()
        l.textColor = UIColor.airabelaBlue
        l.text = "KONTAKTNA OSEBA"
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let kontaktnaOsebaLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let kontaktnaOseba = UserDefaults.standard.object(forKey: "kontaktnaOseba") as? String
        l.text = kontaktnaOseba?.uppercased()
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let kontaktniEnaslovLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let kontaktniEnaslov = UserDefaults.standard.object(forKey: "kontaktniEnaslov") as? String
        l.text = kontaktniEnaslov?.uppercased()
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let kontaktnaTelefonskaStLabel : UILabel = {
        let l = UILabel()
        l.font = UIFont.boldSystemFont(ofSize: 14)
        let kontaktnaTelefonskaSt = UserDefaults.standard.object(forKey: "kontaktnaTelefonskaSt") as? String
        l.text = kontaktnaTelefonskaSt?.uppercased()
        l.textAlignment = .center
        return l
    }()
    
    let splosniPogojiButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("SPLOŠNI POGOJI", for: .normal)
        b.addTarget(self, action: #selector(showPogoji), for: .touchUpInside)
        b.setTitleColor(UIColor.airabelaBlue, for: .normal)
        b.backgroundColor = UIColor.white
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return b
    }()
    
    @objc func showPogoji() {
        
        let pogojiController = PogojiController()
        pogojiController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        pogojiController.homeScreenButton.setTitle("NAZAJ", for: .normal)
        
        present(pogojiController, animated: true, completion: nil)
    }
    
    @objc func handleSpremeniUserPodatke() {
        
        let changeDataController = UserChangeDataController()
        
        changeDataController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        present(changeDataController, animated: true, completion: nil)
    }
    
    @objc func handleCloseButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateTextFields() {
        let defaults = UserDefaults.standard
        podjetjeLabel.text = (defaults.object(forKey: "podjetje") as? String ?? "").uppercased()
        naslovLabel.text = (defaults.object(forKey: "naslov") as? String ?? "").uppercased()
        let krajInPostna = "\(defaults.object(forKey: "postnaSt") as? String ?? "") \(defaults.object(forKey: "kraj") as? String ?? "")"
        krajInPostnaStLabel.text = krajInPostna.uppercased()
        davcnaStLabel.text = (defaults.object(forKey: "davcnaSt") as? String ?? "").uppercased()
        kontaktnaOsebaLabel.text = (defaults.object(forKey: "kontaktnaOseba") as? String ?? "").uppercased()
        kontaktniEnaslovLabel.text = (defaults.object(forKey: "kontaktniEnaslov") as? String ?? "").uppercased()
        kontaktnaTelefonskaStLabel.text = (defaults.object(forKey: "kontaktnaTelefonskaSt") as? String ?? "").uppercased()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.frame = view.bounds
        view.addSubview(bluredView)
        
    }
    
    func addSubviews() {
        view.addSubview(contentView)
        contentView.alpha = 0
        
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(iconLabel)
        iconLabel.anchorCenter(to: headerView, withHeight: 0, andWidth: 0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [closeButton, spremeniButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        contentView.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: contentView.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        contentView.addSubview(splosniPogojiButton)
        splosniPogojiButton.anchor(top: nil, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 40)
        
        let podjetjeStackView = UIStackView(arrangedSubviews: [podjetjeInfoLabel,podjetjeLabel, naslovLabel, krajInPostnaStLabel, davcnaStLabel])
        podjetjeStackView.distribution = .fillProportionally
        podjetjeStackView.axis = .vertical
        
        let kontaktnaOsebaStackView = UIStackView(arrangedSubviews: [kontaktnaOsebaInfoLabel, kontaktnaOsebaLabel, kontaktniEnaslovLabel, kontaktnaTelefonskaStLabel])
        kontaktnaOsebaStackView.distribution = .fillProportionally
        kontaktnaOsebaStackView.axis = .vertical

        let uporabniskiProfilStackView = UIStackView(arrangedSubviews: [podjetjeStackView, kontaktnaOsebaStackView])
        uporabniskiProfilStackView.axis = .vertical
        uporabniskiProfilStackView.distribution = .fillProportionally
        uporabniskiProfilStackView.spacing = 5
        
        contentView.addSubview(uporabniskiProfilStackView)
        uporabniskiProfilStackView.anchor(top: headerView.bottomAnchor, paddingTop: 20, right: contentView.rightAnchor, paddingRight: 20, left: contentView.leftAnchor, paddingLeft: 20, bottom: splosniPogojiButton.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        UIView.animate(withDuration: 0.5) {
            self.contentView.alpha = 1
        }
    }
    
}
