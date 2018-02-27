//
//  ReklamacijaContentView.swift
//  Airabela
//
//  Created by Alen Kirm on 20. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class ContentView : UIView {
    
    let textLabel : UILabel = {
        let l = UILabel()
        l.textColor  = UIColor.airabelaGray
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    let leftView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaBlue
        return v
    }()
    
    let rightView : UIView = {
        let v = UIView()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [leftView, rightView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)

        leftView.addSubview(textLabel)
        textLabel.anchorCenter(to: leftView, withHeight: 0, andWidth: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
