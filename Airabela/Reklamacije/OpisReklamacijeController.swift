//
//  OpisReklamacijeController.swift
//  Airabela
//
//  Created by Alen Kirm on 20. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class OpisReklamacijeController: ReklamacijaController {
    
    fileprivate var textFieldHeight : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                return 45
            }
        }
        return 50
    }
    
    fileprivate var textFieldPadding : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                return 5
            }
        }
        return 10
    }
    
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
    
    @objc func handleTest() {
        print("test")
    }
    
    @objc func handleNaprejButton() {
        
        if isOpisValid() {
            
            let slikaReklamacijaController = SlikaReklamacijaController()
            slikaReklamacijaController.reklamacija = reklamacija
            
            navigationController?.pushViewController(slikaReklamacijaController, animated: true)
            
        } else {
            
            let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika potrebujemo izpolnjen opis reklamacije.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "V REDU", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    func isOpisValid() -> Bool {
        
        if let kodaNapake = kodaNapakeTextField.text, kodaNapake.count > 0, let opisNapake = opisNapakeTextField.text, opisNapake.count > 0 {
            
            var zunanja : String?
            var notranja : String?
            
            if let naprava = reklamacija?.naprava as? ZunanjaInNotranja {
                
                if naprava.zunanjaEnotaStevilka != nil {
                    if let serijskaZunanja = serijskaStevilkaZunanjeEnoteTextField.text, serijskaZunanja != "" {
                        zunanja = serijskaZunanja
                    } else { return false }
                }
                
                if naprava.notranjaEnotaStevilka != nil {
                    if let serijskaNotranja = serijskaStevilkaNotranjeEnoteTextField.text, serijskaNotranja != "" {
                        notranja = serijskaNotranja
                    } else { return false }
                }
                
            }
            
            reklamacija?.opisReklamacije = OpisReklamacije(kodaNapake: kodaNapake, opisNapake: opisNapake, serijskaZunanjeEnote: zunanja ?? "", serijskaNotranjeEnote: notranja ?? "")
            
            return true
        }
        
        return false
        
    }
    
    var reklamacija : Reklamacija? {
        
        didSet {
            
            if let naprava = reklamacija?.naprava as? ZunanjaInNotranja {
                
                if naprava.zunanjaEnotaStevilka != nil && naprava.notranjaEnotaStevilka != nil {
                    
                    // add both
                    view.addSubview(serijskaStevilkaZunanjeEnoteTextField)
                    serijskaStevilkaZunanjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: textFieldPadding, right: opisNapakeTextField.rightAnchor, paddingRight: 0, left: opisNapakeTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                    view.addSubview(serijskaStevilkaNotranjeEnoteTextField)
                    serijskaStevilkaNotranjeEnoteTextField.anchor(top: serijskaStevilkaZunanjeEnoteTextField.bottomAnchor, paddingTop: textFieldPadding, right: serijskaStevilkaZunanjeEnoteTextField.rightAnchor, paddingRight: 0, left: serijskaStevilkaZunanjeEnoteTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                    
                }
                
                if naprava.zunanjaEnotaStevilka != nil && naprava.notranjaEnotaStevilka == nil {
                    
                    // add serijska zunanja subview
                    view.addSubview(serijskaStevilkaZunanjeEnoteTextField)
                    serijskaStevilkaZunanjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: textFieldPadding, right: opisNapakeTextField.rightAnchor, paddingRight: 0, left: opisNapakeTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                    
                }
                
                if naprava.notranjaEnotaStevilka != nil && naprava.zunanjaEnotaStevilka == nil {
                    
                    // add serijska notranja subview
                    view.addSubview(serijskaStevilkaNotranjeEnoteTextField)
                    serijskaStevilkaNotranjeEnoteTextField.anchor(top: opisNapakeTextField.bottomAnchor, paddingTop: textFieldPadding, right: opisNapakeTextField.rightAnchor, paddingRight: 0, left: opisNapakeTextField.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
                    
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "OPIS"
        
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
        
        // add container view
        
        view.addSubview(kodaNapakeTextField)
        kodaNapakeTextField.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: buttonsStackView.rightAnchor, paddingRight: 0, left: buttonsStackView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        view.addSubview(opisNapakeTextField)
        opisNapakeTextField.anchor(top: kodaNapakeTextField.bottomAnchor, paddingTop: textFieldPadding, right: buttonsStackView.rightAnchor, paddingRight: 0, left: buttonsStackView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
    }
    
}
