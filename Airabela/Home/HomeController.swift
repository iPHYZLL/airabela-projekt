//
//  HomeController.swift
//  Airabela
//
//  Created by Alen Kirm on 12. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    var isLoggedIn = false
    
    let reklamacijskiZapisnikView : HomeView = {
        let view = HomeView(withStyle: .left)
        view.image = #imageLiteral(resourceName: "slika-reklamacijski-zapisnik")
        view.btnTitle = "REKLAMACIJSKI\nZAPISNIK"
        view.btnIcon = #imageLiteral(resourceName: "reklamacijskiZapisnik")
        return view
    }()
    
    let uporabniskiProfilView : HomeView = {
        let view = HomeView(withStyle: .right)
        view.image = #imageLiteral(resourceName: "slika-uporabniski-profil")
        view.btnTitle = "UPORABNIŠKI\nPROFIL"
        view.btnIcon = #imageLiteral(resourceName: "user")
        return view
    }()
    
    let opodjetjuView : HomeView = {
        let view = HomeView(withStyle: .left)
        view.image = #imageLiteral(resourceName: "slika-o-podjetju")
        view.btnTitle = "O\nAIRABELI"
        view.btnIcon = #imageLiteral(resourceName: "airabelaLogo")
        return view
    }()
    
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
    
    let reklamacijskiZapisnikButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(reklamacijskiZapisnikButtonTapped), for: .touchUpInside)
        return b
    }()
    
    let uporabniskiProfilButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(uporabniskiProfilButtonTapped), for: .touchUpInside)
        return b
    }()
    
    let oPodjetjuButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(oPodjetjuButtonTapped), for: .touchUpInside)
        return b
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationItem.title = "REKLAMACIJE"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "jeRegistriran")
        if !isLoggedIn {
            let registrationController = UserRegistrationController()
            present(registrationController, animated: true, completion: nil)
        }
        
        view.addSubview(headerView)
        if #available(iOS 11.0, *) {
            headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 100)
        } else {
            // Fallback on earlier versions
            headerView.anchor(top: view.layoutMarginsGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 100)

        }
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
        let stackView = UIStackView(arrangedSubviews: [reklamacijskiZapisnikView, uporabniskiProfilView, opodjetjuView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        if #available(iOS 11.0, *) {
            stackView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
            stackView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        }
        
        addButtonsToMenuViews()
    }
    
    fileprivate func addButtonsToMenuViews() {
        let reklamacijskiBtnView = reklamacijskiZapisnikView.buttonView
        let uporabniskiBtnView = uporabniskiProfilView.buttonView
        let opodjetjuBtnView = opodjetjuView.buttonView
        
        reklamacijskiBtnView.addSubview(reklamacijskiZapisnikButton)
        reklamacijskiZapisnikButton.anchor(top: reklamacijskiBtnView.topAnchor, paddingTop: 0, right: reklamacijskiBtnView.rightAnchor, paddingRight: 0, left: reklamacijskiBtnView.leftAnchor, paddingLeft: 0, bottom: reklamacijskiBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        uporabniskiBtnView.addSubview(uporabniskiProfilButton)
        uporabniskiProfilButton.anchor(top: uporabniskiBtnView.topAnchor, paddingTop: 0, right: uporabniskiBtnView.rightAnchor, paddingRight: 0, left: uporabniskiBtnView.leftAnchor, paddingLeft: 0, bottom: uporabniskiBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        opodjetjuBtnView.addSubview(oPodjetjuButton)
        oPodjetjuButton.anchor(top: opodjetjuBtnView.topAnchor, paddingTop: 0, right: opodjetjuBtnView.rightAnchor, paddingRight: 0, left: opodjetjuBtnView.leftAnchor, paddingLeft: 0, bottom: opodjetjuBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
    }
    
//    fileprivate func userIsRegistered() -> Bool {
//        return false
//    }
    
    // Actions to show certain views
    
    @objc func reklamacijskiZapisnikButtonTapped() {
        
        let kupecViewController = KupecController()
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
        
        navigationController?.pushViewController(kupecViewController, animated: true)
    }
    
    @objc func uporabniskiProfilButtonTapped() {
        let viewController = UserProfileController()
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        present(viewController, animated: true) {
            viewController.addSubviews()
        }
    }
    
    @objc func oPodjetjuButtonTapped() {
        let viewController = AirabelaController()
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        present(viewController, animated: true) {
            viewController.addSubviews()
        }
    }
    
    
    
    
    
    
}
