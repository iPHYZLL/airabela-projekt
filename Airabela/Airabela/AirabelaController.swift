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
    
    let direktorInfoView : UILabel = {
        let l = UILabel()
        let attributedText = NSMutableAttributedString(string: "Urban Martinuč", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: "\ninfo@airabela.si", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n040 131 706", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        
        l.attributedText = attributedText
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let podporaInfoView : UILabel = {
        let l = UILabel()
        let attributedText = NSMutableAttributedString(string: "Žiga Hribar", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: "\npodpora@airabela.si", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n040 176 706", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        
        l.attributedText = attributedText
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let narocilaInfoView : UILabel = {
        let l = UILabel()
        let attributedText = NSMutableAttributedString(string: "Franko Troha", attributes: [NSAttributedStringKey.foregroundColor : UIColor.black, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: "\nnarocila@airabela.si", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: "\n040 176 703", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)]))
        
        l.attributedText = attributedText
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
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
        direktorView.rightView.addSubview(direktorInfoView)
        direktorInfoView.anchor(top: direktorView.rightView.topAnchor, paddingTop: 0, right: direktorView.rightView.rightAnchor, paddingRight: 0, left: direktorView.rightView.leftAnchor, paddingLeft: 0, bottom: direktorView.rightView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        podporaView.rightView.addSubview(podporaInfoView)
        podporaInfoView.anchor(top: podporaView.rightView.topAnchor, paddingTop: 0, right: podporaView.rightView.rightAnchor, paddingRight: 0, left: podporaView.rightView.leftAnchor, paddingLeft: 0, bottom: podporaView.rightView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        narocilaView.rightView.addSubview(narocilaInfoView)
        narocilaInfoView.anchor(top: narocilaView.rightView.topAnchor, paddingTop: 0, right: narocilaView.rightView.rightAnchor, paddingRight: 0, left: narocilaView.rightView.leftAnchor, paddingLeft: 0, bottom: narocilaView.rightView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        let rolesStackView = UIStackView(arrangedSubviews: [direktorView, podporaView, narocilaView])
        rolesStackView.axis = .vertical
        rolesStackView.distribution = .fillEqually

        contentView.addSubview(rolesStackView)
        rolesStackView.anchor(top: podjetjeContainerView.bottomAnchor, paddingTop: 0, right: contentView.rightAnchor, paddingRight: 0, left: contentView.leftAnchor, paddingLeft: 0, bottom: contentView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        UIView.animate(withDuration: 0.5) {
            self.contentView.alpha = 1
        }
    }
    
}
