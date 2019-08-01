//
//  HelperClass.swift
//  notes
//
//  Created by Pedro Ramos on 7/30/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import UIKit

@objc class HelperClass: NSObject {

    public static var dateFormat = "EEEE, MMM d, yyyy"
    
    @objc public static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat;
        return dateFormatter.string(from: date)
    }
}
