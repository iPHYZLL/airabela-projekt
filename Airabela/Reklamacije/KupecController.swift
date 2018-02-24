//
//  KupecController.swift
//  Airabela
//
//  Created by Alen Kirm on 16. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class KupecController: UIViewController {
    
    var reklamacija : Reklamacija?
    var kupec : Kupec?
    
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
        let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika morate navesti vse podatke o kupcu.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        
//        if let imeKupca = imeKupcaTextView.text, imeKupca.count > 0, let priimekKupca = priimekKupcaTextView.text, priimekKupca.count > 0, let naslovVgradnje = naslovVgradnjeTextView.text, naslovVgradnje.count > 0, let krajVgradnje = krajVgradnjeTextView.text, krajVgradnje.count > 0, let datumVgradnje = datumVgradnjeTextView.text, datumVgradnje.count > 0 {
//
//            kupec = Kupec(ime: imeKupca, priimek: priimekKupca, naslovVgradnje: naslovVgradnje, krajVgradnje: krajVgradnje, datumVgradnje: datumVgradnje)
//
//            reklamacija = Reklamacija(kupec: kupec, predmet: nil)
//
//            let predmetViewController = PredmetController()
//            predmetViewController.reklamacija = reklamacija
//
//            let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
//
//            self.navigationItem.backBarButtonItem = backButton
//
//            navigationController?.pushViewController(predmetViewController, animated: true)
//
//        } else {
//            present(alertController, animated: true, completion: nil)
//        }
        
        let predmetViewController = PredmetController()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(predmetViewController, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaGray
        navigationItem.title = "KUPEC"
        
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [closeButton, naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        let kupecStackView = UIStackView(arrangedSubviews: [imeKupcaTextView, priimekKupcaTextView, naslovVgradnjeTextView, krajVgradnjeTextView, datumVgradnjeTextView])
        kupecStackView.distribution = .fillEqually
        kupecStackView.axis = .vertical
        kupecStackView.spacing = 10
        
        view.addSubview(kupecStackView)
        kupecStackView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        
    }
    
    
}
