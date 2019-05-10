//
//  FailVideoView.swift
//  LivestreamFailsUnofficial
//
//  Created by Marcelo Vitoria on 20/04/19.
//  Copyright © 2019 Marcelo Vitoria. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Kingfisher

protocol FailVideoViewDelegate: AnyObject {
    func changeElapsedTimeText(_ elapsedTimeText: String)
    func resetElapsedTimeText()
}

class FailVideoView: UIView {
    private let defaultFontSize: CGFloat = 17
    private var streamerNameLabel: UILabel!
    private var failDescriptionLabel: UILabel!
    private var timeObserverToken: Any?

    weak var delegate: FailVideoViewDelegate?

    private var playerLayer: AVPlayerLayer {
        return self.layer as! AVPlayerLayer
    }

    private var player: AVPlayer? {
        get {
            return self.playerLayer.player
        }

        set {
            self.playerLayer.player = newValue
        }
    }

    private var playerObserver: NSObjectProtocol?

    var summary: FailSummary? {
        didSet {
            self.setStreamerAndGameText()
            self.failDescriptionLabel.text = self.summary?.description ?? "N/A"
        }
    }

    var details: FailDetails? {
        didSet {
            guard let videoURL = self.details?.videoURL else {
                return
            }

            let asset = AVAsset(url: videoURL)
            let playerItem = AVPlayerItem(asset: asset)

            self.playerLayer.videoGravity = .resizeAspect
            self.player = AVPlayer(playerItem: playerItem)
            self.play()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    private var currentDuration: CMTime?

    private func addPeriodicTimeObserver() {
        guard let player = self.player else {
            return
        }

        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1, preferredTimescale: timeScale)
        let tick: (CMTime) -> Void = { [weak self] time in
            guard let certainSelf = self else {
                return
            }

            certainSelf.handlePlaybackTimeChange(time)
        }

        self.timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                                queue: .main,
                                                                using: tick)
    }

    private func removePeriodicTimeObserver() {
        guard let player = self.player else {
            return
        }

        if let timeObserverToken = self.timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }

    private func handlePlaybackTimeChange(_ time: CMTime) {
        guard let currentItem = self.player?.currentItem else {
            return
        }

        if self.currentDuration == nil {
            self.currentDuration = currentItem.duration
        }

        guard let duration = self.currentDuration else {
            return
        }

        let durationSec = duration.value / Int64(duration.timescale)
        let elapsed = time.value / Int64(time.timescale)
        let newTimeSec = durationSec - elapsed
        let newTimeMin = newTimeSec / 60
        let newTimeHour = newTimeSec / 60 / 60

        let formattedElapsedText = String(format: "%02d:%02d:%02d",
                                          newTimeHour,
                                          newTimeMin,
                                          newTimeSec)

        self.delegate?.changeElapsedTimeText(formattedElapsedText)
    }

    func play() {
        self.addPeriodicTimeObserver()
        self.enableVideoLoop()
        self.player?.play()
    }

    func stop() {
        self.removePeriodicTimeObserver()
        self.disableVideoLoop()
        self.player?.pause()
        self.player = nil
        self.currentDuration = nil
        self.delegate?.resetElapsedTimeText()
    }

    private func initialize() {
        self.backgroundColor = UIColor.themeBackgroundColor()

        self.configureFailDescriptionLabel()

        self.configureStreamerNameLabel()
    }

    private func configureFailDescriptionLabel() {
        self.failDescriptionLabel = UILabel()
        self.failDescriptionLabel.numberOfLines = 0
        self.failDescriptionLabel.font = UIFont.systemFont(ofSize: self.defaultFontSize, weight: .regular)
        self.failDescriptionLabel.textColor = UIColor.white

        self.addSubview(self.failDescriptionLabel)

        let margin: CGFloat = 20.0
        let layoutGuide = self.layoutMarginsGuide
        self.failDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.failDescriptionLabel.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin).isActive = true
        self.failDescriptionLabel.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -margin).isActive = true
        self.failDescriptionLabel.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margin).isActive = true
    }

    private func configureStreamerNameLabel() {
        self.streamerNameLabel = UILabel()
        self.streamerNameLabel.numberOfLines = 0
        self.streamerNameLabel.font = UIFont.systemFont(ofSize: self.defaultFontSize, weight: .bold)
        self.streamerNameLabel.textColor = UIColor.white

        self.addSubview(self.streamerNameLabel)

        self.streamerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.streamerNameLabel.leadingAnchor.constraint(equalTo: self.failDescriptionLabel.leadingAnchor).isActive = true
        self.streamerNameLabel.trailingAnchor.constraint(equalTo: self.failDescriptionLabel.trailingAnchor).isActive = true
        self.streamerNameLabel.bottomAnchor.constraint(equalTo: self.failDescriptionLabel.topAnchor, constant: -5).isActive = true
    }

    private func setStreamerAndGameText() {
        let fontBold = UIFont.systemFont(ofSize: defaultFontSize, weight: .bold)
        let fontRegular = UIFont.systemFont(ofSize: defaultFontSize)

        let boldAttributes: [NSAttributedString.Key: Any] = [.font: fontBold]
        let regularAttributes: [NSAttributedString.Key: Any] = [.font: fontRegular]

        let streamerName = NSMutableAttributedString(string: self.summary?.streamerName ?? "N/A", attributes: boldAttributes)
        let gameTitle = NSAttributedString(string: " playing ", attributes: regularAttributes)
        let gameName = NSAttributedString(string: self.summary?.gameName ?? "N/A", attributes: boldAttributes)

        streamerName.append(gameTitle)
        streamerName.append(gameName)

        self.streamerNameLabel.attributedText = streamerName
    }

    private func enableVideoLoop() {
        guard let player = self.player else {
            return
        }

        let loop: (Notification) -> Void = { _ in
            player.seek(to: CMTime.zero)
            player.play()
        }

        self.playerObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                                     object: player.currentItem,
                                                                     queue: nil,
                                                                     using: loop)
    }

    private func disableVideoLoop() {
        guard let observer = self.playerObserver else {
            return
        }

        NotificationCenter.default.removeObserver(observer)
    }
}
