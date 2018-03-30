//
//  SlikaReklamacijaController.swift
//  Airabela
//
//  Created by Alen Kirm on 23. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import MessageUI

class SlikaReklamacijaController: ReklamacijaController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    var imageArray = [UIImage]() {
        didSet {
            if imageArray.count > 0 {
                izbrisiSlikoNotificationLabel.isHidden = false
            } else {
                izbrisiSlikoNotificationLabel.isHidden = true
            }
        }
    }
    let reklamacijaCellId = "reklamacijaCell"
    var reklamacija : Reklamacija?
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    
    let infoLabel : UILabel = {
        let l = UILabel()
        l.text = "Fotografije so zaželjene.\nMaksimalno število fotografij je 3."
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.textColor = UIColor.black
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    let izbrisiSlikoNotificationLabel : UILabel = {
        let l = UILabel()
        l.text = "Za odstranitev fotografije kliknite nanjo."
        l.font = UIFont.boldSystemFont(ofSize: 12)
        l.textColor = UIColor.black
        l.textAlignment = .center
        l.numberOfLines = 0
        l.isHidden = true
        return l
    }()
    
    @objc func dodajFotografijoButtonTapped() {
        
        let alertController = UIAlertController(title: "DODAJ FOTOGRAFIJO", message: "Kako želite dodati fotografijo?", preferredStyle: .actionSheet)
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        let galerijaAction = UIAlertAction(title: "Galerija", style: .default) { (action) in
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(picker, animated: true)
        }
        
        let slikajAction = UIAlertAction(title: "Kamera", style: .default) { (action) in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Prekliči", style: .destructive, handler: nil)
        
        alertController.addAction(galerijaAction)
        alertController.addAction(slikajAction)
        alertController.addAction(cancelAction)
        
        if imageArray.count < 3 {
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "NAPAKA", message: "Maksimalno število slik je 3.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "V REDU", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        print(selectedImage)
        
        imageArray.append(selectedImage)
        collectionView?.reloadData()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            print("image picker dismissed")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reklamacijaCellId, for: indexPath) as? SlikaReklamacijaCell {
            
            cell.reklamacijaImage = imageArray[indexPath.item]
        
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = collectionView.frame.height
        
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                size = collectionView.frame.height - CGFloat(20)
            }
        }
        
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageArray.remove(at: indexPath.item)
        collectionView.reloadData()
    }
    
    let pošljiButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.airabelaBlue
        b.setTitle("POŠLJI ZAPISNIK", for: .normal)
        b.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        b.tintColor = UIColor.airabelaGray
        return b
    }()
    
    let dodajFotografijoButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .white
        b.setTitle("  DODAJ FOTOGRAFIJO", for: .normal)
        b.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        b.tintColor = UIColor.airabelaBlue
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        b.addTarget(self, action: #selector(dodajFotografijoButtonTapped), for: .touchUpInside)
        return b
    }()
    
    @objc func handleNaprejButton() {
        
        let alertController = UIAlertController(title: "POŠLJI ZAPISNIK", message: "Reklamacijski zapisnik je pripravljen za pošiljanje. V naslednjem koraku se bo pojavila Apple Mail aplikacija za pošiljanje zapisnika.", preferredStyle: .alert)
        
        let nadaljujAction = UIAlertAction(title: "NADALJUJ", style: .default) { (action) in
            
            let kontaktniEmail = UserDefaults.standard.object(forKey: "kontaktniEnaslov") as? String ?? ""
            
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject("Reklamacijski zapisnik")
            mailController.setToRecipients(["podpora@airabela.si", kontaktniEmail])
            
            // mail controller body
            mailController.setMessageBody(self.composeBody(), isHTML: false)
            
            // mail controller image
            if self.imageArray.count > 0 {
                var i = 0
                for image in self.imageArray {
                    i += 1
                    mailController.addAttachmentData(UIImageJPEGRepresentation(image, 1.0)!, mimeType: "image/jpeg", fileName: "slika\(i)")
                }
            }
            
            self.present(mailController, animated: true, completion: nil)
            
        }
        
        let prekliciAction = UIAlertAction(title: "PREKLIČI", style: .destructive, handler: nil)
        
        alertController.addAction(prekliciAction)
        alertController.addAction(nadaljujAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .cancelled {
            dismiss(animated: true, completion: nil)
        } else if result == .sent {
            dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)
                
                let alertController = UIAlertController(title: nil, message: "Hvala, ker uporabljate našo aplikacijo. V primeru uspešno poslane reklamacije, boste na naveden kontaktni e-naslov prejeli potrditveni email.", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "V REDU", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    func composeBody() -> String {
        
        let defaults = UserDefaults.standard
        let podjetje = defaults.object(forKey: "podjetje") as? String ?? ""
        let naslov = defaults.object(forKey: "naslov") as? String ?? ""
        let krajInPostna = "\(defaults.object(forKey: "postnaSt") as? String ?? "") \(defaults.object(forKey: "kraj") as? String ?? "")"
        let davcna = defaults.object(forKey: "davcnaSt") as? String ?? ""
        let kontaktnaOseba = defaults.object(forKey: "kontaktnaOseba") as? String ?? ""
        let kontaktniEmail = defaults.object(forKey: "kontaktniEnaslov") as? String ?? ""
        let telefonska = defaults.object(forKey: "kontaktnaTelefonskaSt") as? String ?? ""
        
        // text
        let naslovText = "----- REKLAMACIJSKI ZAPISNIK -----"
        
        let podjetjeText = "PODJETJE:\n\n   \(podjetje)\n   \(naslov)\n   \(krajInPostna)\n   \(davcna)"
        
        let kontaktnaOsebaText = "KONTAKTNA OSEBA:\n\n   \(kontaktnaOseba)\n   \(kontaktniEmail)\n   \(telefonska)"
        
        let kupecText = "KUPEC:\n\n   \(reklamacija?.kupec.ime ?? "") \(reklamacija?.kupec.priimek ?? "")"
        
        let vgradnjaText = "VGRADNJA:\n\n   \(reklamacija?.kupec.krajVgradnje ?? "")\n   \(reklamacija?.kupec.naslovVgradnje ?? "")\n   \(reklamacija?.kupec.datumVgradnje ?? "")"
        
        let kodaNapakeText = "KODA NAPAKE:\n\n   \(reklamacija?.opisReklamacije?.kodaNapake ?? "")"
        
        let opisNapakeText = "OPIS NAPAKE:\n\n   \(reklamacija?.opisReklamacije?.opisNapake ?? "")"
        
        var predmetText = "PREDMET REKLAMACIJE:\n\n"
        
        // naprava stuff
        if let naprava = reklamacija?.naprava {
            
            let vrstaNaprave = naprava.vrstaNaprave
            
            if let naprava = naprava as? ZunanjaInNotranja {
                if let notranjaNapravaKoda = naprava.notranjaEnotaStevilka, notranjaNapravaKoda != "" {
                    predmetText += "  \(notranjaNapravaKoda)\n"
                }
                
                if let zunanjaNapravaKoda = naprava.zunanjaEnotaStevilka, zunanjaNapravaKoda != "" {
                    predmetText += "  \(zunanjaNapravaKoda)\n"
                }
                
                if let notranjaSerijska = reklamacija?.opisReklamacije?.serijskaNotranjeEnote, notranjaSerijska != "" {
                    predmetText += "\nNotranja serijska:\n\n  \(notranjaSerijska)\n"
                }
                
                if let zunanjaSerijska = reklamacija?.opisReklamacije?.serijskaZunanjeEnote, zunanjaSerijska != "" {
                    predmetText += "\nZunanja serijska:\n\n  \(zunanjaSerijska)\n"
                }
            }
            
            // if conformed to oznakaNaprave protocol so it has .oznakaNaprave and .naprava property
            if let naprava = naprava as? OznakaNaprave {
                
                predmetText += "  \(vrstaNaprave)\n\n"
                
                // it definitely has oznakaNaprave property so ...
                if let oznaka = naprava.oznakaNaprave, oznaka != "" {
                    predmetText += "OZNAKA NAPRAVE:\n\n   \(oznaka)\n"
                }
                
                if let stevilkaNaprave = naprava.naprava, stevilkaNaprave != "" {
                    predmetText += "STEVILKA NAPRAVE:\n\n   \(stevilkaNaprave)\n"
                }
                
            }
        }
        
        let nogaText = "Poslano iz mobilne aplikacije Reklamacije, podjetja Airabela d.o.o."
        
        let bodyText = "\n\(naslovText.uppercased())\n\n\(podjetjeText.uppercased())\n\n\(kontaktnaOsebaText.uppercased())\n\n\(predmetText.uppercased())\n\(kodaNapakeText.uppercased())\n\n\(opisNapakeText.uppercased())\n\n\(kupecText.uppercased())\n\n\(vgradnjaText.uppercased())\n\n\(nogaText)"
        
        return bodyText
    }
    
    @objc override func handleNazajButton() {
        
        let alertController = UIAlertController(title: "KORAK NAZAJ", message: "Ste prepričani, da se želite vrniti korak nazaj? Izgubili boste fotografije, ki ste jih priložili.", preferredStyle: .alert)
        
        let nadaljujAction = UIAlertAction(title: "NADALJUJ", style: .destructive) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        let prekliciAction = UIAlertAction(title: "PREKLIČI", style: .default, handler: nil)
        
        alertController.addAction(nadaljujAction)
        alertController.addAction(prekliciAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "FOTOGRAFIJE"
        
        self.navigationItem.hidesBackButton = true
        
        let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backImage"), style: .plain, target: self, action: #selector(handleNazajButton))
        backBtn.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0)
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        
        nazajButton.addTarget(self, action: #selector(handleNazajButton), for: .touchUpInside)
        naprejButton.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        
        // add subviews
        
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = UIColor.airabelaGray
        
        collectionView?.register(SlikaReklamacijaCell.self, forCellWithReuseIdentifier: reklamacijaCellId)
        
        view.addSubview(collectionView!)
        collectionView?.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: nil, paddingBottom: 0, width: 0, height: 100)
        
        view.addSubview(izbrisiSlikoNotificationLabel)
        izbrisiSlikoNotificationLabel.anchor(top: collectionView!.bottomAnchor, paddingTop: 0, right: view.rightAnchor, paddingRight: 20, left: view.leftAnchor, paddingLeft: 20, bottom: nil, paddingBottom: 0, width: 0, height: 20)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [infoLabel, dodajFotografijoButton, pošljiButton, nazajButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        buttonsStackView.axis = .vertical
        
        view.addSubview(buttonsStackView)
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.bottomAnchor, paddingBottom: 20, width: 0, height: 230)
        
    }
    
    
}
