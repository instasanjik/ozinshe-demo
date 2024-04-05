//
//  MoviePlayerViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import UIKit
import SnapKit
import YoutubePlayerView

class MoviePlayerViewController: UIViewController {
    
    var movieName: String = ""
    var movieType: String = "MOVIE"
    
    var movieLink: String = ""
    var seasons: [Season] = []
    
    var seasonIndex = 0
    var episodeIndex = 0
    
    private var isButtonVisible = false
    
    var videoDuration: TimeInterval = 0 {
        didSet {
            self.totalTimeCodeLabel.text = Float(videoDuration).timeCodeValue
            self.movieTimelineSlider.maximumValue = Float(videoDuration)
        }
    }
    var currentTime: Float = 0 {
        didSet {
            self.currentTimeCodeLabel.text = currentTime.timeCodeValue
            self.movieTimelineSlider.value = currentTime
        }
    }
    var timeLeft: Int { return Int(videoDuration) - Int(currentTime) }
    var currentEpisode: Series {
        guard !seasons.isEmpty else { return Series() }
        return seasons[seasonIndex].videos[episodeIndex]
    }
    
    
    var isPause: Bool = false {
        didSet {
            let imageName = isPause ? "play.fill" : "pause.fill"
            playButton.setImage(UIImage(systemName: imageName), for: .normal)
            if isPause {
                pauseImageView.alpha = 1
                playerView.pause()
            } else {
                playerView.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.pauseImageView.alpha = 0
                }
            }
        }
    }
    
    private lazy var playerView: YoutubePlayerView = {
        let view = YoutubePlayerView()
        let playerVars: [String: Any] = [
            "controls": 0,
            "modestbranding": 1,
            "playsinline": 1,
            "rel": 0,
            "showinfo": 0,
            "autoplay": 1,
            "disablekb": 1,
        ]
        view.delegate = self
        if movieType == "MOVIE" {
            view.loadWithVideoId(movieLink, with: playerVars)
        } else {
            view.loadWithVideoId(currentEpisode.youtubeID, with: playerVars)
        }
        return view
    }()
    
    private lazy var pauseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var overlayLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "111827").withAlphaComponent(0.72)
        view.alpha = 0
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.StaticColors.white
        label.text = movieName
        return label
    }()
    
    lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.StaticColors.gray400
        label.text = "\(currentEpisode.number.ordinalString()) \(NSLocalizedString("Series-series", comment: ""))"
        label.isHidden = movieType != "MOVIE"
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        button.imageView?.layer.transform = CATransform3DMakeScale(1.8, 1.8, 1.8)
        button.addTarget(self, action: #selector(playButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "backward"), for: .normal)
        button.addTarget(self, action: #selector(backwardButtonTapped(_:)), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "forward"), for: .normal)
        button.addTarget(self, action: #selector(forwardButtonTapped(_:)), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var movieTimelineSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(videoDuration)
        slider.thumbTintColor = Style.StaticColors.purple500
        slider.minimumTrackTintColor = Style.StaticColors.purple500.withAlphaComponent(0.4)
        slider.maximumTrackTintColor = Style.StaticColors.white.withAlphaComponent(0.4)
        slider.setValue(0, animated: true)
        
        let thumbSize: CGFloat = 16
        let thumbSizeExpanded: CGFloat = 32
        
        slider.setThumbImage(UIImage.circle(diameter: thumbSize, color: Style.StaticColors.purple500), for: .normal)
        slider.setThumbImage(UIImage.circle(diameter: thumbSizeExpanded, color: Style.StaticColors.purple500), for: .highlighted)
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .allTouchEvents)
        
        return slider
    }()
    
    lazy var currentTimeCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.StaticColors.white
        label.text = "00:00"
        return label
    }()
    
    lazy var totalTimeCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.StaticColors.white
        label.text = "00:00"
        return label
    }()
    
    private lazy var nextEpisodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next Episode", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.5)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextEpisodeButtonTapped), for: .touchUpInside)
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var overlayTimer: Timer?
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscapeLeft, .landscapeRight]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupGestureRecognizers()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarHidden(true)
        startOverlayTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setTabBarHidden(false)
        stopOverlayTimer()
    }
    
    
}


// MARK: - UI Setups
private extension MoviePlayerViewController {
    
    func setupUI() {
        view.backgroundColor = Style.StaticColors.darkBackground
        
        setupPlayerView()
        setupPauseImageView()
        
        setupOverlayLayerView()
        setupCloseButton()
        setupMovieNameLabel()
        setupEpisodeLabel()
        setupPlayButton()
        setupForwardButton()
        setupBackwardButton()
        setupMovieTimelineSlider()
        setupCurrentTimeCodeLabel()
        setupTotalTimeCodeLabel()
        
        setupNextEpisodeButton()
    }
    
    func setupPlayerView() {
        view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupPauseImageView() {
        playerView.addSubview(pauseImageView)
        
        pauseImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupOverlayLayerView() {
        playerView.addSubview(overlayLayerView)
        
        overlayLayerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupCloseButton() {
        overlayLayerView.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(24)
            make.width.height.equalTo(48)
        }
    }
    
    func setupMovieNameLabel() {
        overlayLayerView.addSubview(movieNameLabel)
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupEpisodeLabel() {
        overlayLayerView.addSubview(episodeLabel)
        
        episodeLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).inset(-4)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupPlayButton() {
        overlayLayerView.addSubview(playButton)
        
        playButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
    func setupBackwardButton() {
        overlayLayerView.addSubview(backwardButton)
        
        backwardButton.snp.makeConstraints { make in
            make.right.equalTo(playButton.snp.left).inset(-64)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
    func setupForwardButton() {
        overlayLayerView.addSubview(forwardButton)
        
        forwardButton.snp.makeConstraints { make in
            make.left.equalTo(playButton.snp.right).inset(-64)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
    
    func setupMovieTimelineSlider() {
        overlayLayerView.addSubview(movieTimelineSlider)
        
        movieTimelineSlider.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(47)
        }
    }
    
    func setupCurrentTimeCodeLabel() {
        overlayLayerView.addSubview(currentTimeCodeLabel)
        
        currentTimeCodeLabel.snp.makeConstraints { make in
            make.left.equalTo(movieTimelineSlider)
            make.bottom.equalTo(movieTimelineSlider.snp.top).inset(-4)
        }
    }
    
    
    func setupTotalTimeCodeLabel() {
        overlayLayerView.addSubview(totalTimeCodeLabel)
        totalTimeCodeLabel.snp.makeConstraints { make in
            make.right.equalTo(movieTimelineSlider)
            make.bottom.equalTo(movieTimelineSlider.snp.top).inset(-4)
        }
    }
    
    func setupNextEpisodeButton() {
        view.addSubview(nextEpisodeButton)
        nextEpisodeButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(160)
            make.bottom.equalToSuperview().inset(64)
            make.right.equalToSuperview().inset(48)
        }
    }
    
}

// MARK: - Targets
private extension MoviePlayerViewController {
    
    @objc func playButtonTapped(_ sender: UIButton!) {
        resetOverlayTimer()
        isPause.toggle()
    }
    
    @objc func forwardButtonTapped(_ sender: UIButton!) {
        if timeLeft > 10 {
            playerView.seek(to: currentTime + 10, allowSeekAhead: true)
        } else {
            playerView.seek(to: Float(videoDuration), allowSeekAhead: true)
        }
        resetOverlayTimer()
    }
    
    @objc func backwardButtonTapped(_ sender: UIButton!) {
        if currentTime > 10 {
            playerView.seek(to: currentTime - 10, allowSeekAhead: true)
        } else {
            playerView.seek(to: 0, allowSeekAhead: true)
        }
        resetOverlayTimer()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let currentValue = sender.value
        currentTimeCodeLabel.text = currentValue.timeCodeValue
        playerView.seek(to: currentValue, allowSeekAhead: true)
        resetOverlayTimer()
    }
    
    @objc func nextEpisodeButtonTapped() {
        if episodeIndex == seasons[seasonIndex].videos.count - 1 { // if episode is last in season
            if seasonIndex == seasons.count - 1 { // if season is last
                self.dismiss(animated: true)
                return
            } else {
                seasonIndex += 1
                episodeIndex = 0
                playerView.loadWithVideoId(currentEpisode.youtubeID)
            }
        } else {
            episodeIndex += 1
            playerView.loadWithVideoId(currentEpisode.youtubeID)
        }
        downloadDataForPlayer()
        hideNextEpisodeButton()
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
    
    
}

// MARK: - Internal functions
private extension MoviePlayerViewController {
    
    // MARK: Gesture Recognizers
    func setupGestureRecognizers() {
        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerViewTapped)))
        pauseImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerViewTapped)))
        overlayLayerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerViewTapped)))
    }
    
    @objc func playerViewTapped() {
        if overlayLayerView.alpha == 0 {
            showOverlayView()
        } else {
            hideOverlayView()
        }
    }
    
    // MARK: Player data downlading
    func downloadDataForPlayer() {
        playerView.fetchDuration { duration in
            self.videoDuration = (duration ?? 3) - 3
        }
    }
    
    // MARK: Overlay Actions
    func showOverlayView() {
        UIView.animate(withDuration: 0.3) {
            self.overlayLayerView.alpha = 1
        }
        resetOverlayTimer()
    }
    
    func hideOverlayView() {
        UIView.animate(withDuration: 0.3) {
            self.overlayLayerView.alpha = 0
        }
    }
    
    
    // MARK: Overlay Timer
    func startOverlayTimer() {
        resetOverlayTimer()
    }
    
    func resetOverlayTimer() {
        overlayTimer?.invalidate()
        overlayTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.hideOverlayView()
        }
    }
    
    func stopOverlayTimer() {
        overlayTimer?.invalidate()
        overlayTimer = nil
    }
    
    // MARK: Next episode button settings
    func showNextEpisodeButton() {
        if !isButtonVisible {
            UIView.animate(withDuration: 0.3) {
                self.nextEpisodeButton.alpha = 1
            }
            nextEpisodeButton.changeBackgroundWithAnimation(animationDuration: 10, toColor: Style.StaticColors.purple500)
            isButtonVisible = true
        }
    }
    
    func hideNextEpisodeButton() {
        if isButtonVisible {
            UIView.animate(withDuration: 0.3) {
                self.nextEpisodeButton.alpha = 0
            }
            nextEpisodeButton.stopBackgroundAnimation(backgroundColor: .black.withAlphaComponent(0.5))
            isButtonVisible = false
        }
    }
    
    
}


// MARK: - Public functions
extension MoviePlayerViewController {
    
    func configureScene(seasons: [Season] = [], movieName: String, selectedSeason: Int = 0, selectedSeries: Int = 0, movieType: String = "", movieLink: String = "") {
        self.movieName = movieName
        
        self.movieType = movieType
        self.movieLink = movieLink
        
        self.seasons = seasons
        self.seasonIndex = selectedSeason
        self.episodeIndex = selectedSeries
    }
    
    
}


// MARK: - Youtube Player Delegate
extension MoviePlayerViewController: YoutubePlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
        playerView.play()
        downloadDataForPlayer()
    }
    
    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
        Logger.log(.warning, "Error: \(error)")
    }
    
    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
        if !self.movieTimelineSlider.isFocused {
            currentTime = time
        }
        
        if timeLeft < 1 && movieType != "MOVIE" {
            nextEpisodeButtonTapped()
            isPause = true
            showOverlayView()
        }
        
        if timeLeft < 10 && movieType != "MOVIE"  {
            showNextEpisodeButton()
            nextEpisodeButton.setTitle("Next episode (\(timeLeft))", for: .normal)
        } else {
            hideNextEpisodeButton()
        }
    }
    
    func playerViewDidPause(pauseImage: UIImage) {
        pauseImageView.image = pauseImage
    }
    
    
}
