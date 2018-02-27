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
    
    var imageArray = [UIImage]()
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
            let cancelAction = UIAlertAction(title: "VREDU", style: .cancel, handler: nil)
            
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
        let size = collectionView.frame.height
        
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
        
        let mailController = MFMailComposeViewController()
        mailController.mailComposeDelegate = self
        mailController.setSubject("Reklamacijski zapisnik")
        mailController.setToRecipients(["alen.kirm@gmail.com"])
        
        // mail controller body
        mailController.setMessageBody(composeBody(), isHTML: false)
        
        // mail controller image
        if imageArray.count > 0 {
            var i = 0
            for image in imageArray {
                i += 1
                mailController.addAttachmentData(UIImageJPEGRepresentation(image, 1.0)!, mimeType: "image/jpeg", fileName: "slika\(i)")
            }
        }
        
        present(mailController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if result == .cancelled {
            dismiss(animated: true, completion: nil)
        } else if result == .sent {
            dismiss(animated: true) {
                self.navigationController?.popToRootViewController(animated: true)
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
        
        var predmetText = "NAPRAVA:\n\n   "
        
        // naprava stuff
        if let naprava = reklamacija?.naprava {
            predmetText += "\(naprava.vrstaNaprave)\n"
            if let toplotnaCrpalka = naprava as? ToplotnaCrpalka {
                if let notranjaNapravaKoda = toplotnaCrpalka.notranjaEnotaStevilka {
                    predmetText += "Notranja enota koda: \(notranjaNapravaKoda)\n"
                }
                
                if let zunanjaNapravaKoda = toplotnaCrpalka.zunanjaEnotaStevilka {
                    predmetText += "Zunanja enota koda: \(zunanjaNapravaKoda)\n"
                }
            }
        }
        
        let serijskaNotranjaText = "SERIJSKA ŠTEVILKA NOTRANJE ENOTE:\n\n   \(reklamacija?.opisReklamacije?.serijskaNotranjeEnote ?? "Neznana")"
        
        let serijskaZunanjaText = "SERIJSKA ŠTEVILKA ZUNANJE ENOTE:\n\n   \(reklamacija?.opisReklamacije?.serijskaZunanjeEnote ?? "Neznana")"
        
        let bodyText = "\n\(naslovText.uppercased())\n\n\(podjetjeText.uppercased())\n\n\(kontaktnaOsebaText.uppercased())\n\n\(predmetText.uppercased())\n\n\(serijskaNotranjaText.uppercased())\n\n\(serijskaZunanjaText.uppercased())\n\n\(kodaNapakeText.uppercased())\n\n\(opisNapakeText.uppercased())\n\n\(kupecText.uppercased())\n\n\(vgradnjaText.uppercased())"
        
        return bodyText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "FOTOGRAFIJE"
        
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
        
        let buttonsStackView = UIStackView(arrangedSubviews: [infoLabel, dodajFotografijoButton, pošljiButton, nazajButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        buttonsStackView.axis = .vertical
        
        view.addSubview(buttonsStackView)
        if #available(iOS 11.0, *) {
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 230)
        } else {
            // Fallback on earlier versions
            buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.layoutMarginsGuide.bottomAnchor, paddingBottom: 20, width: 0, height: 230)
        }
        
    }
    
    
}
