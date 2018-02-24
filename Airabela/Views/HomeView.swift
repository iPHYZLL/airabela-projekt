//
//  HomeView.swift
//  Airabela
//
//  Created by Alen Kirm on 12. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

enum HomeViewStyle {
    case left
    case right
}

class HomeView: UIView {
    
    var style : HomeViewStyle?
    
    var image : UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var btnIcon : UIImage? {
        didSet {
            buttonIcon.image = btnIcon?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var btnTitle : String? {
        didSet {
            buttonLabel.text = btnTitle
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let buttonView : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.airabelaBlue
        return v
    }()
    
    let buttonLabel : UILabel = {
        let bl = UILabel()
        bl.textColor = UIColor.airabelaGray
        bl.textAlignment = .center
        bl.numberOfLines = 0
        bl.font = UIFont.boldSystemFont(ofSize: 14)
        return bl
    }()
    
    let buttonIcon : UIImageView = {
        let bi = UIImageView()
        bi.contentMode = .scaleAspectFit
        bi.tintColor = UIColor.airabelaGray
        return bi
    }()
    
    init(withStyle style: HomeViewStyle = .left) {
        
        self.style = style
        super.init(frame: UIScreen.main.bounds)
        
        initViews()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    fileprivate func initViews() {
        backgroundColor = UIColor.airabelaGray
        addSubview(imageView)
        addSubview(buttonView)
        
        if style == .right {
            buttonView.anchor(top: topAnchor, paddingTop: 0, right: centerXAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
            
            imageView.anchor(top: topAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: centerXAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        } else {
            imageView.anchor(top: topAnchor, paddingTop: 0, right: centerXAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
            
            buttonView.anchor(top: topAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: centerXAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        }
        
        let stackView = UIStackView(arrangedSubviews: [buttonIcon, buttonLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        buttonView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
