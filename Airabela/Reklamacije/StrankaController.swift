//
//  KupecController1.swift
//  Airabela
//
//  Created by Alen Kirm on 27. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class StrankaController : ReklamacijaController {
    
    var reklamacija : Reklamacija?
    fileprivate var textFieldHeight : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                return 45
            }
        }
        return 50
    }
    
    fileprivate var textFieldPadding : CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            if UIScreen.main.nativeBounds.height == 1136 {
                return 5
            }
        }
        return 10
    }
    
    let imeKupcaTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "IME STRANKE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let priimekKupcaTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "PRIIMEK STRANKE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let naslovVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "NASLOV VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let krajVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "KRAJ VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let datumVgradnjeTextView : HoshiTextField = {
        let tf = HoshiTextField()
        tf.placeholder = "DATUM VGRADNJE"
        tf.borderActiveColor = UIColor.airabelaBlue
        tf.borderInactiveColor = UIColor.airabelaBlue
        return tf
    }()
    
    let datePicker : UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.locale = Locale.init(identifier: "sl_SI")
        return dp
    }()
    
    @objc func handleNaprejButton() {
        
        
        if let imeKupca = imeKupcaTextView.text, imeKupca.count > 0, let priimekKupca = priimekKupcaTextView.text, priimekKupca.count > 0, let naslovVgradnje = naslovVgradnjeTextView.text, naslovVgradnje.count > 0, let krajVgradnje = krajVgradnjeTextView.text, krajVgradnje.count > 0, let datumVgradnje = datumVgradnjeTextView.text, datumVgradnje.count > 0 {
            
            let kupec = Kupec(ime: imeKupca, priimek: priimekKupca, naslovVgradnje: naslovVgradnje, krajVgradnje: krajVgradnje, datumVgradnje: datumVgradnje)
            
            reklamacija = Reklamacija(kupec: kupec, naprava: nil, opisReklamacije: nil, fotografijeReklamacije: nil)
            
            let predmetViewController = PredmetController()
            predmetViewController.reklamacija = reklamacija
            
            navigationController?.pushViewController(predmetViewController, animated: true)
            
        } else {
            
            let alertController = UIAlertController(title: "NAPAKA", message: "Za nadaljevanje reklamacijskega zapisnika morate navesti vse podatke o kupcu.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "V REDU", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func handleDatePicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.init(identifier: "sl_SI")
        
        datumVgradnjeTextView.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let flexible2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(title: "IZBERI", style: .done, target: self, action: #selector(handleDatePicked))
        toolbar.setItems([flexible1, doneButton, flexible2], animated: true)
        toolbar.barTintColor = UIColor.airabelaBlue
        toolbar.tintColor = UIColor.airabelaGray
        toolbar.isTranslucent = false
        
        datumVgradnjeTextView.inputAccessoryView = toolbar
        datumVgradnjeTextView.inputView = datePicker
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "STRANKA"
        
        self.navigationItem.hidesBackButton = true
        
        let backBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "backImage"), style: .plain, target: self, action: #selector(handleNazajButton))
        backBtn.imageInsets = UIEdgeInsetsMake(0, -8, 0, 0)
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        naprejButton.addTarget(self, action: #selector(handleNaprejButton), for: .touchUpInside)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [naprejButton])
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 10
        
        view.addSubview(buttonsStackView)
        
        buttonsStackView.anchor(top: nil, paddingTop: 0, right: view.rightAnchor, paddingRight: 40, left: view.leftAnchor, paddingLeft: 40, bottom: view.bottomAnchor, paddingBottom: 20, width: 0, height: 40)
        
        view.addSubview(imeKupcaTextView)
        imeKupcaTextView.anchor(top: headerView.bottomAnchor, paddingTop: 0, right: buttonsStackView.rightAnchor, paddingRight: 0, left: buttonsStackView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
        view.addSubview(priimekKupcaTextView)
        priimekKupcaTextView.anchor(top: imeKupcaTextView.bottomAnchor, paddingTop: textFieldPadding, right: imeKupcaTextView.rightAnchor, paddingRight: 0, left: imeKupcaTextView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
        view.addSubview(naslovVgradnjeTextView)
        naslovVgradnjeTextView.anchor(top: priimekKupcaTextView.bottomAnchor, paddingTop: textFieldPadding, right: priimekKupcaTextView.rightAnchor, paddingRight: 0, left: priimekKupcaTextView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
        view.addSubview(krajVgradnjeTextView)
        krajVgradnjeTextView.anchor(top: naslovVgradnjeTextView.bottomAnchor, paddingTop: textFieldPadding, right: naslovVgradnjeTextView.rightAnchor, paddingRight: 0, left: naslovVgradnjeTextView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
        view.addSubview(datumVgradnjeTextView)
        datumVgradnjeTextView.anchor(top: krajVgradnjeTextView.bottomAnchor, paddingTop: textFieldPadding, right: krajVgradnjeTextView.rightAnchor, paddingRight: 0, left: krajVgradnjeTextView.leftAnchor, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 0, height: textFieldHeight)
        
        
        createDatePicker()
        
    }
    
}
