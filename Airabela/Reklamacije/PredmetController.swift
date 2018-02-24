//
//  PredmetController.swift
//  Airabela
//
//  Created by Alen Kirm on 16. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class PredmetController: UIViewController {
    
    var reklamacija : Reklamacija?
    let vrsteNaprav = ["Toplotna črpalka", "Klimatska naprava", "Rekuperator", "Čistilec zraka", "Konvektor", "VRV Sistem", "Plinski kotel"]
    var izbranaVrstaNaprave : VrstaNaprave?
    
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
        let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika morate navesti vse podatke o kupcu.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let opisReklamacijeController = OpisReklamacijeController()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(opisReklamacijeController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaGray
        navigationItem.title = "PREDMET"
        
        print(reklamacija?.kupec ?? "")
        
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [closeButton, naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        // add subviews
        
        view.addSubview(vrsteNapravTableView)
        vrsteNapravTableView.anchor(top: headerView.bottomAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: buttonsStackView.topAnchor, paddingBottom: 20, width: 0, height: 0)
        
        
    }
    
}
