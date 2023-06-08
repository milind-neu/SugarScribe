//
//  Constants.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth  = screenSize.size.width

let appDelegate = UIApplication.shared.delegate as? AppDelegate

func getYoutubeId(youtubeUrl: String) -> String? {
    return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
}
