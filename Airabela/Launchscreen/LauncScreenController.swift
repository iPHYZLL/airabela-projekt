//
//  LauncScreenController.swift
//  Airabela
//
//  Created by Alen Kirm on 25. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class LauncScreenController: UIViewController {

    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "Airabela+podpis").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.airabelaGray
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.airabelaBlue
        
        view.addSubview(imageView)
        imageView.anchorCenter(to: view, withHeight: 100, andWidth: 175)
    }
}
