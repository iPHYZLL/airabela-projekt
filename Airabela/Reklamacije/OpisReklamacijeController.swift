//
//  OpisReklamacijeController.swift
//  Airabela
//
//  Created by Alen Kirm on 20. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class OpisReklamacijeController: UIViewController {
    
    let predmetContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
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
    
    let kodaNapakeTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.placeholder = "KODA NAPAKE:"
        return tf
    }()
    
    let opisNapakeTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.placeholder = "OPIS NAPAKE:"
        return tf
    }()
    
    let serijskaStevilkaZunanjeEnoteTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.placeholder = "SERIJSKA ŠTEVILKA ZUNANJE ENOTE:"
        return tf
    }()
    
    let serijskaStevilkaNotranjeEnoteTextField : HoshiTextField = {
        let tf = HoshiTextField()
        tf.borderInactiveColor = UIColor.airabelaBlue
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.placeholder = "SERIJSKA ŠTEVILKA NOTRANJE ENOTE:"
        return tf
    }()
    
    @objc func handleCloseButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleNaprejButton() {
        
        if isOpisValid() {
            
            let slikaReklamacijaController = SlikaReklamacijaController()
            slikaReklamacijaController.reklamacija = reklamacija
            
            let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            
            self.navigationItem.backBarButtonItem = backButton
            
            navigationController?.pushViewController(slikaReklamacijaController, animated: true)
            
        } else {
            
            let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika potrebujemo izpolnjen opis reklamacije.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func isOpisValid() -> Bool {
        
        if let kodaNapake = kodaNapakeTextField.text, kodaNapake.count > 0, let opisNapake = opisNapakeTextField.text, opisNapake.count > 0 {
            let zunanjaKoda = serijskaStevilkaZunanjeEnoteTextField.text ?? ""
            let notranjaKoda = serijskaStevilkaNotranjeEnoteTextField.text ?? ""
            
            reklamacija?.opisReklamacije = OpisReklamacije(kodaNapake: kodaNapake, opisNapake: opisNapake, serijskaZunanjeEnote: zunanjaKoda, serijskaNotranjeEnote: notranjaKoda)
            
            return true
        }
        
        return false
        
    }
    
    var reklamacija : Reklamacija? {
        
        willSet {
            predmetContainerView.addSubview(kodaNapakeTextField)
            kodaNapakeTextField.anchor(top: predmetContainerView.topAnchor, paddingTop: 0, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
            predmetContainerView.addSubview(opisNapakeTextField)
            opisNapakeTextField.anchor(top: kodaNapakeTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        }
        
        didSet {
            
            if let naprava = reklamacija?.naprava as? ToplotnaCrpalka {
                
                if naprava.zunanjaEnotaStevilka != nil && naprava.notranjaEnotaStevilka != nil {
                    // add both
                    predmetContainerView.addSubview(serijskaStevilkaZunanjeEnoteTextField)
                    serijskaStevilkaZunanjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                    predmetContainerView.addSubview(serijskaStevilkaNotranjeEnoteTextField)
                    serijskaStevilkaNotranjeEnoteTextField.anchor(top: serijskaStevilkaZunanjeEnoteTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                } else if naprava.zunanjaEnotaStevilka != nil && naprava.notranjaEnotaStevilka == nil {
                    // add serijska zunanja subview
                    predmetContainerView.addSubview(serijskaStevilkaZunanjeEnoteTextField)
                    serijskaStevilkaZunanjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                } else if naprava.notranjaEnotaStevilka != nil && naprava.zunanjaEnotaStevilka == nil {
                    // add serijska notranja subview
                    predmetContainerView.addSubview(serijskaStevilkaNotranjeEnoteTextField)
                    serijskaStevilkaNotranjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaGray
        navigationItem.title = "OPIS"
        
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
        
        predmetContainerView.addSubview(kodaNapakeTextField)
        kodaNapakeTextField.anchor(top: predmetContainerView.topAnchor, paddingTop: 0, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        predmetContainerView.addSubview(opisNapakeTextField)
        opisNapakeTextField.anchor(top: kodaNapakeTextField.bottomAnchor, paddingTop: 20, right: predmetContainerView.rightAnchor, paddingRight: 0, left: predmetContainerView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 50)
        
    }
    
}
