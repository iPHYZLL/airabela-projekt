//
//  AirabelaController.swift
//  Airabela
//
//  Created by Alen Kirm on 15. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class AirabelaController: UIViewController {
    
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
    
    let nazivLabel : UILabel = {
        let l = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Airabela d.o.o", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        l.attributedText = attributedText
        l.textAlignment = .center
        return l
    }()
    
    let lokacijaLabel : UILabel = {
        let l = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Šmartinska cesta 58a\n1000 Ljubljana", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        l.attributedText = attributedText
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()

    
    let davcnaLabel : UILabel = {
        let l = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "SI 79240518", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        l.attributedText = attributedText
        l.textAlignment = .center
        return l
    }()
    
    let telefonLabel : UILabel = {
        let l = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Tel.: 082053025", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 14)])
        
        l.attributedText = attributedText
        l.textAlignment = .center
        return l
    }()
    
    let stranButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("www.airabela.si", for: .normal)
        b.addTarget(self, action: #selector(handleStranButton), for: .touchUpInside)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return b
    }()
    
    let podjetjeContainerView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "slika-o-podjetju")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let imageEffectView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.80)
        return view
    }()
    
    // handle contact type
    
    @objc func handleCall(sender : UIButton) {
        
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        guard let url = URL(string: "tel://\(buttonTitle)") else { return }
        
        UIApplication.shared.open(url, options: [ : ])
        
    }
    
    @objc func handleEmail(sender : UIButton) {
        
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        guard let url = URL(string: "mailto:\(buttonTitle)") else { return }
        
        UIApplication.shared.open(url, options: [ : ])
        
    }
    
    // direktor stuff
    
    let direktorOseba : UILabel = {
        let l = UILabel()
        l.text = "URBAN MARTINUČ"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let callDirektorButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("040-131-706", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleCall(sender:)), for: .touchUpInside)
        return button
    }()
    
    let mailDirektorButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("info@airabela.si", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleEmail(sender:)), for: .touchUpInside)
        return button
    }()
    
    // podpora stuff
    
    let podporaOseba : UILabel = {
        let l = UILabel()
        l.text = "ŽIGA HRIBAR"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let callPodporaButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("040-176-706", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleCall(sender:)), for: .touchUpInside)
        return button
    }()
    
    let mailPodporaButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("podpora@airabela.si", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleEmail(sender:)), for: .touchUpInside)
        return button
    }()
    
    //narocila stuff
    
    let narocilaOseba : UILabel = {
        let l = UILabel()
        l.text = "FRANKO TROHA"
        l.font = UIFont.boldSystemFont(ofSize: 14)
        l.textAlignment = .center
        return l
    }()
    
    let callNarocilaButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("040-176-703", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleCall(sender:)), for: .touchUpInside)
        return button
    }()
    
    let mailNarocilaButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("narocila@airabela.si", for: .normal)
        button.setTitleColor(UIColor.airabelaBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(handleEmail(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func handleCloseButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.alpha = 0
        }) { (success) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleStranButton(sender : UIButton) {
        
        guard let senderTitle = sender.titleLabel?.text else { return }
        let urlString = "http://\(senderTitle)"
        guard let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurEffect = UIBlurEffect(style: .dark)
        let bluredView = UIVisualEffectView(effect: blurEffect)
        bluredView.frame = view.bounds
        view.addSubview(bluredView)
        
    }
    
    let direktorView : ContentView = {
        let v = ContentView()
        v.textLabel.text = "DIREKTOR"
        return v
    }()
        
    let podporaView : ContentView = {
        let v = ContentView()
        v.textLabel.text = "PODPORA"
        return v
    }()
    
    let narocilaView : ContentView = {
        let v = ContentView()
        v.textLabel.text = "NAROČILA"
        return v
    }()
    
    func addSubviews() {
        view.addSubview(contentView)
        contentView.alpha = 0
        
        if #available(iOS 11.0, *) {
            contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
            contentView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 20, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        }
        
        contentView.addSubview(headerView)
        headerView.anchor(top: contentView.topAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(logoImageview)
        logoImageview.anchorCenter(to: headerView, withHeight: 40, andWidth: 0)
        
        headerView.addSubview(closeButton)
        closeButton.anchor(top: headerView.topAnchor, paddingTop: 10, right: headerView.rightAnchor, paddingRight: 10, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 25, height: 25)
        
        // text labels
        
        contentView.addSubview(podjetjeContainerView)
        podjetjeContainerView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: contentView.frame.height / 3)
        
        podjetjeContainerView.addSubview(imageEffectView)
        imageEffectView.anchor(top: podjetjeContainerView.topAnchor, paddingTop: 0, right: podjetjeContainerView.rightAnchor, paddingRight: 0, left: podjetjeContainerView.leftAnchor, paddingLeft: 0, bottom: podjetjeContainerView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        let infoStackView = UIStackView(arrangedSubviews: [nazivLabel, lokacijaLabel, davcnaLabel, telefonLabel, stranButton])
        infoStackView.distribution = .fillProportionally
        infoStackView.spacing = 5
        infoStackView.axis = .vertical
        
        imageEffectView.addSubview(infoStackView)
        infoStackView.anchor(top: imageEffectView.topAnchor, paddingTop: 20, right: imageEffectView.rightAnchor, paddingRight: 20, left: imageEffectView.leftAnchor, paddingLeft: 20, bottom: imageEffectView.bottomAnchor, paddingBottom: 20, width: 0, height: 0)
        
        // role views
        
        // direktor stackview
        let direktorStack = UIStackView(arrangedSubviews: [direktorOseba, mailDirektorButton, callDirektorButton])
        direktorStack.axis = .vertical
        direktorStack.distribution = .fillEqually
        
        direktorView.rightView.addSubview(direktorStack)
        direktorStack.anchorCenter(to: direktorView.rightView, withHeight: 60, andWidth: 0)
        
        // podpora stackview
        let podporaStack = UIStackView(arrangedSubviews: [podporaOseba, mailPodporaButton, callPodporaButton])
        podporaStack.axis = .vertical
        podporaStack.distribution = .fillEqually
        
        podporaView.rightView.addSubview(podporaStack)
        podporaStack.anchorCenter(to: podporaView.rightView, withHeight: 60, andWidth: 0)
        
        // narocila stackview
        let narocilaStack = UIStackView(arrangedSubviews: [narocilaOseba, mailNarocilaButton, callNarocilaButton])
        narocilaStack.axis = .vertical
        narocilaStack.distribution = .fillEqually
        
        narocilaView.rightView.addSubview(narocilaStack)
        narocilaStack.anchorCenter(to: narocilaView.rightView, withHeight: 60, andWidth: 0)
        
        let rolesStackView = UIStackView(arrangedSubviews: [direktorView, podporaView, narocilaView])
        rolesStackView.axis = .vertical
        rolesStackView.spacing = 5
        rolesStackView.distribution = .fillEqually

        contentView.addSubview(rolesStackView)
        rolesStackView.anchor(top: podjetjeContainerView.bottomAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: contentView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        UIView.animate(withDuration: 0.5) {
            self.contentView.alpha = 1
        }
    }
    
}
