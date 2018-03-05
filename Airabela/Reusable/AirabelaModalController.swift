//
//  AirabelaModalController.swift
//  Airabela
//
//  Created by Alen Kirm on 28. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class AirabelaModalController: UIViewController {
    
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
    
    let logoImageview : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "Airabela+podpis").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.airabelaGray
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let closeButton : UIButton = {
        let b = UIButton(type: .system)
        b.tintColor = UIColor.airabelaGray
        b.setImage(#imageLiteral(resourceName: "izbrisiSliko"), for: .normal)
        b.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return b
    }()
    
    @objc func handleCloseButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
