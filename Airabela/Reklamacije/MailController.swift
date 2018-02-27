//
//  MailController.swift
//  Airabela
//
//  Created by Alen Kirm on 25. 02. 18.
//  Copyright © 2018 Alen Kirm. All rights reserved.
//

import UIKit
import MessageUI

class MailController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mailComposeDelegate = self
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    }
    
}
