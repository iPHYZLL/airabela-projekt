//
//  PogojiController.swift
//  Airabela
//
//  Created by Alen Kirm on 13. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class PogojiController: UIViewController {
    
    let headerView : UIView = {
        let hv = UIView()
        hv.backgroundColor = UIColor.airabelaBlue
        return hv
    }()

    let iconLabel : UILabel = {
        let bl = UILabel()
        bl.textColor = UIColor.airabelaGray
        bl.textAlignment = .center
        bl.numberOfLines = 0
        bl.text = "SPLOŠNI POGOJI"
        bl.font = UIFont.boldSystemFont(ofSize: 16)
        return bl
    }()
    
    let iconImage : UIImageView = {
        let bi = UIImageView()
        bi.contentMode = .scaleAspectFit
        bi.image = #imageLiteral(resourceName: "terms").withRenderingMode(.alwaysTemplate)
        bi.tintColor = UIColor.airabelaGray
        return bi
    }()
    
    let textViewContainerView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaGray
        return v
    }()
    
    let pogojiTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.airabelaGray
        tv.isEditable = false
        tv.isScrollEnabled = true
        tv.attributedText = Pogoji.getPogoji()
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let homeScreenButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("STRINJAM SE Z POGOJI", for: .normal)
        b.addTarget(self, action: #selector(showPogojiScreen), for: .touchUpInside)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitleColor(UIColor.airabelaGray, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return b
    }()
    
    @objc func showPogojiScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaBlue
        
        addSubviews()
        
        
        
        
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
        homeScreenButton.anchor(top: nil, paddingTop: 0, right: textViewContainerView.rightAnchor, paddingRight: 20, left: textViewContainerView.leftAnchor, paddingLeft: 20, bottom: textViewContainerView.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        textViewContainerView.addSubview(pogojiTextView)
        pogojiTextView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: textViewContainerView.rightAnchor, paddingRight: 20, left: textViewContainerView.leftAnchor, paddingLeft: 20, bottom: homeScreenButton.topAnchor, paddingBottom: 0, width: 0, height: 0)
        
        pogojiTextView.textContainerInset = UIEdgeInsetsMake(20, 0, 20, 0)
    }
    
}
