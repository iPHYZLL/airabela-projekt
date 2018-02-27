//
//  KupecController1.swift
//  Airabela
//
//  Created by Alen Kirm on 27. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class KupecController : ReklamacijaController {
    
    var reklamacija : Reklamacija?
    
    let imeKupcaTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "IME KUPCA"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let priimekKupcaTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "PRIIMEK KUPCA"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let naslovVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "NASLOV VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let krajVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "KRAJ VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let datumVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "DATUM VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    @objc func handleNaprejButton() {
        let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika morate navesti vse podatke o kupcu.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let imeKupca = imeKupcaTextView.text, imeKupca.count > 0, let priimekKupca = priimekKupcaTextView.text, priimekKupca.count > 0, let naslovVgradnje = naslovVgradnjeTextView.text, naslovVgradnje.count > 0, let krajVgradnje = krajVgradnjeTextView.text, krajVgradnje.count > 0, let datumVgradnje = datumVgradnjeTextView.text, datumVgradnje.count > 0 {
            
            let kupec = Kupec(ime: imeKupca, priimek: priimekKupca, naslovVgradnje: naslovVgradnje, krajVgradnje: krajVgradnje, datumVgradnje: datumVgradnje)
            
            reklamacija = Reklamacija(kupec: kupec, naprava: nil, opisReklamacije: nil, fotografijeReklamacije: nil)
            
            let predmetViewController = PredmetController()
            predmetViewController.reklamacija = reklamacija
            
            let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            
            self.navigationItem.backBarButtonItem = backButton
            
            navigationController?.pushViewController(predmetViewController, animated: true)
            
        } else {
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "KUPEC"
        
        naprejButton.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        if #available(iOS 11.0, *) {
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        } else {
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        }
        
        let kupecStackView = UIStackView(arrangedSubviews: [imeKupcaTextView, priimekKupcaTextView, naslovVgradnjeTextView, krajVgradnjeTextView, datumVgradnjeTextView])
        kupecStackView.distribution = .fillEqually
        kupecStackView.axis = .vertical
        kupecStackView.spacing = 10
        
        view.addSubview(kupecStackView)
        kupecStackView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom:  buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 0)
    }
    
}
