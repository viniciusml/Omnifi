//
//  Restaurant.swift
//  Omnifi
//
//  Created by Vinicius Leal on 31/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation

// MARK: - RestaurantElement
struct RestaurantElement: Codable {
    let name: String
    let enableOrderAhead: Enable
    let clickAndCollect: Bool
    let ccVersion: CcVersion
    let voucherBand: VoucherBand
    let additional, bookingID, city: String
    let country: Country
    let fax, latitude, longitude, openFriday: String
    let openMonday, openSaturday, openSunday, openThursday: String
    let openTuesday, openWednesday, postalCode: String
    let region: Region
    let siteID, street, telephone, title: String
    let url: String
    let taxonomy, body: String
    let zonalSiteID: String?
    let deliveryLink: String
    let deliverooDirectLink, uberEatsDirectLink, justEatDirectlink: String?
    let enableDAT: Enable?
    let disableBookings: Bool?
    let enableClickAndCollect: Enable?
    
    enum CodingKeys: String, CodingKey {
        case name, enableOrderAhead, clickAndCollect, ccVersion, voucherBand, additional
        case bookingID = "booking_id"
        case city, country, fax, latitude, longitude
        case openFriday = "open_friday"
        case openMonday = "open_monday"
        case openSaturday = "open_saturday"
        case openSunday = "open_sunday"
        case openThursday = "open_thursday"
        case openTuesday = "open_tuesday"
        case openWednesday = "open_wednesday"
        case postalCode = "postal_code"
        case region
        case siteID = "site_id"
        case street, telephone, title, url, taxonomy, body
        case zonalSiteID = "zonalSiteId"
        case deliveryLink = "delivery_link"
        case deliverooDirectLink, uberEatsDirectLink, justEatDirectlink, enableDAT, disableBookings, enableClickAndCollect
    }
}

enum CcVersion: String, Codable {
    case v2 = "v2"
}

// MARK: - Country
enum Country: String, Codable {
    case countryUK = "UK"
    case empty = ""
    case gb = "gb"
    case uk = "uk"
}

// MARK: - Enable
enum Enable: String, Codable {
    case no = "no"
    case yes = "yes"
}

// MARK: - Region
enum Region: String, Codable, CustomStringConvertible {
    case eastMidlands = "East Midlands"
    case eastOfEngland = "East of England"
    case london = "London"
    case northEast = "North East"
    case northWest = "North West"
    case northernIreland = "Northern Ireland"
    case regionNorthEast = "north east"
    case regionYorkshireAndTheHumber = "Yorkshire And The Humber"
    case scotland = "Scotland"
    case southEast = "South East"
    case southWest = "South West"
    case wales = "Wales"
    case westMidlands = "West Midlands"
    case yorkshireAndTheHumber = "Yorkshire and The Humber"
    
    var description: String {
        return self.rawValue
    }
}

// MARK: - VoucherBand
enum VoucherBand: String, Codable {
    case none = "NONE"
    case siteBandOne = "SITE_BAND_ONE"
    case siteBandThree = "SITE_BAND_THREE"
    case siteBandTwo = "SITE_BAND_TWO"
}

typealias Restaurant = [RestaurantElement]
