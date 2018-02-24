//
//  SlikaReklamacijaController.swift
//  Airabela
//
//  Created by Alen Kirm on 23. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class SlikaReklamacijaController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    let galerijaImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "slika_galerija")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let slikajImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "slika_fotografiraj")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let brezSlikeImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "slika_brez_foto")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
//        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let galerijaButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(galerijaButtonTapped), for: .touchUpInside)
        return b
    }()
    
    let fotografijaButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(fotografijaButtonTapped), for: .touchUpInside)
        return b
    }()
    
    let brezSlikeButton : UIButton = {
        let b = UIButton(type: .system)
        b.addTarget(self, action: #selector(brezSlikeButtonTapped), for: .touchUpInside)
        return b
    }()

    
    let galerijaView : HomeView = {
        let view = HomeView(withStyle: .left)
        view.image = #imageLiteral(resourceName: "slika_galerija")
        view.btnTitle = "DODAJ IZ\nGALERIJE"
        view.btnIcon = #imageLiteral(resourceName: "galerija")
        return view
    }()
    
    let fotografijaView : HomeView = {
        let view = HomeView(withStyle: .right)
        view.image = #imageLiteral(resourceName: "slika_fotografiraj")
        view.btnTitle = "USTVARI\nFOTOGRAFIJO"
        view.btnIcon = #imageLiteral(resourceName: "camera")
        return view
    }()
    
    let brezSlikeView : HomeView = {
        let view = HomeView(withStyle: .left)
        view.image = #imageLiteral(resourceName: "slika_brez_foto")
        view.btnTitle = "NADALJUJ BREZ\nFOTOGRAFIJ"
        view.btnIcon = #imageLiteral(resourceName: "brez-slike")
        return view
    }()
    
    @objc func galerijaButtonTapped() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true) {
            print("image picker presented")
        }
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        print(selectedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            print("image picker dismissed")
        }
    }
    
    @objc func fotografijaButtonTapped() {
        print("fotografija btn tapped")
    }
    
    @objc func brezSlikeButtonTapped() {
        print("brez slike btn tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.airabelaGray
        navigationItem.title = "FOTOGRAFIJE"
        
        view.addSubview(headerView)
        headerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: 80)
        
        headerView.addSubview(logoImageView)
        
        logoImageView.anchorCenter(to: headerView, withHeight: 50, andWidth: 0)
        
        // add subviews
        let stackView = UIStackView(arrangedSubviews: [galerijaView, fotografijaView, brezSlikeView])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 0, left: view.leftAnchor, paddingLeft: 0, bottom: view.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        addButtonsToMenuViews()
        
    }
    
    fileprivate func addButtonsToMenuViews() {
        let galerijaBtnView = galerijaView.buttonView
        let fotografijaBtnView = fotografijaView.buttonView
        let brezSlikeBtnView = brezSlikeView.buttonView
        
        galerijaBtnView.addSubview(galerijaButton)
        galerijaButton.anchor(top: galerijaBtnView.topAnchor, paddingTop: 0, right: galerijaBtnView.rightAnchor, paddingRight: 0, left: galerijaBtnView.leftAnchor, paddingLeft: 0, bottom: galerijaBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        fotografijaBtnView.addSubview(fotografijaButton)
        fotografijaButton.anchor(top: fotografijaBtnView.topAnchor, paddingTop: 0, right: fotografijaBtnView.rightAnchor, paddingRight: 0, left: fotografijaBtnView.leftAnchor, paddingLeft: 0, bottom: fotografijaBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
        brezSlikeBtnView.addSubview(brezSlikeButton)
        brezSlikeButton.anchor(top: brezSlikeBtnView.topAnchor, paddingTop: 0, right: brezSlikeBtnView.rightAnchor, paddingRight: 0, left: brezSlikeBtnView.leftAnchor, paddingLeft: 0, bottom: brezSlikeBtnView.bottomAnchor, paddingBottom: 0, width: 0, height: 0)

    }
    
}
