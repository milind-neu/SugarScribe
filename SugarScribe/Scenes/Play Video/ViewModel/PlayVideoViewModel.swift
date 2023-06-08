//
//  PlayVideoViewModel.swift
//  SugarScribe
//
//  Created by Milind Sharma on 07/06/23.
//

import Foundation

final class PlayVideoViewModel: BaseViewModel {
        
    var youtubeKey: String = ""

    init(youtubeKey: String) {
        super.init()
        self.youtubeKey = youtubeKey
    }
}
