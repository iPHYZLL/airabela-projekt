//
//  ReklamacijaController.swift
//  Airabela
//
//  Created by Alen Kirm on 27. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class ReklamacijaController : UIViewController {
    
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
    
    let nazajButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("NAZAJ", for: .normal)
        b.addTarget(self, action: #selector(handleNazajButton), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    let naprejButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("NAPREJ", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        return b
    }()
    
    @objc func handleNazajButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handlePreklici() {
        let alertController = UIAlertController(title: "PREKLIC REKLAMACIJE", message: "Ste prepričani da želite preklicati reklamacijo in se vrniti na začetni zaslon?", preferredStyle: .alert)
        let prekliciAction = UIAlertAction(title: "DA", style: .destructive) { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let nadaljujAction = UIAlertAction(title: "NE", style: .cancel, handler: nil)
        
        alertController.addAction(nadaljujAction)
        alertController.addAction(prekliciAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.airabelaGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(handlePreklici))
        
        view.addSubview(headerView)
        if #available(iOS 11.0, *) {
            headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        } else {
            // Fallback on earlier versions
            headerView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        }
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
    }
    
}
