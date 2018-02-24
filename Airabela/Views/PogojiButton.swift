//
//  PogojiButton.swift
//  Airabela
//
//  Created by Alen Kirm on 14. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    var isChecked : Bool = true {
        didSet {
            if isChecked {
                setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            } else {
                setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkboxTapped() {
        isChecked = !isChecked
    }
    
}
