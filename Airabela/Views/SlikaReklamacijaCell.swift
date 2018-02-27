//
//  SlikaReklamacijaCell.swift
//  Airabela
//
//  Created by Alen Kirm on 24. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit

class SlikaReklamacijaCell: UICollectionViewCell {
    
    var reklamacijaImage : UIImage? {
        didSet {
            imageView.image = reklamacijaImage
        }
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
//    let deleteButton : UIButton = {
//        let b = UIButton(type: .system)
//        b.setImage(#imageLiteral(resourceName: "izbrisiSliko"), for: .normal)
//        b.tintColor = UIColor.airabelaGray
//        b.contentMode = .scaleAspectFit
//        return b
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // add image view
        addSubview(imageView)
        imageView.anchor(top: topAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: leftAnchor, paddingLeft: 0, bottom: bottomAnchor, paddingBottom: 0, width: 0, height: 0)
        
//        addSubview(deleteButton)
//        deleteButton.anchor(top: topAnchor, paddingTop: 0, right: rightAnchor, paddingRight: 0, left: nil, paddingLeft: 0, bottom: nil, paddingBottom: 0, width: 20, height: 20)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
