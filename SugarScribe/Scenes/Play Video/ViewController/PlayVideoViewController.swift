//
//  PlayVideoViewController.swift
//  SugarScribe
//
//  Created by Milind Sharma on 07/06/23.
//

import UIKit
import WebKit

final class PlayVideoViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var videoPlayer: UIView!
    
    // MARK: - Variables
    var viewModel: PlayVideoViewModel!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Helper Methods
    func setupUI() {
        self.setNavigationAttributes(title: "")
        videoPlayer.backgroundColor = .white
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        DispatchQueue.main.async {
            let player = WKWebView(frame: self.videoPlayer.bounds, configuration: config)
            self.videoPlayer.addSubview(player)
            
            guard let videoURL = URL(string: "https://www.youtube.com/embed/\(self.viewModel.youtubeKey)") else { return }
            let urlRequest = URLRequest(url: videoURL)
            player.load(urlRequest)
        }
    }
}
