//
//  Constants.swift
//  KSExpandableTableView-Swift
//
//  Created by Mac on 3/20/17.
//  Copyright © 2017 Home. All rights reserved.
//

import Foundation

class Constants{
    
    // tag value used for more/less row cells
    static let TAG_FOR_ROW_MORE: Int = 99
    static let TAG_FOR_ROW_LESS: Int = 100
    
    /* Minimum number of rows that should be displayed in each section initially. The number of items in each array for keys in temporaty dicionary (dictTempItems in MainController) should be map this number */
    static let MIN_ROW_IN_SECTION: Int = 3
    
    // table cell identifier
    static let SimpleTableIdentifier: String? = "SimpleTableIdentifier"
    
    // table section header keys
    static let PLANETS = "PLANETS"
    static let INSTRUMENTS = "MUSICAL INSTRUMENTS"
    static let PHONES = "SMART PHONES"
    static let FRUITS = "FRUITS"
    static let SAARC = "SAARC COUNTRIES"
}
