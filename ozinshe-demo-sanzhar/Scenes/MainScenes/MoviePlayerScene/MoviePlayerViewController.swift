//
//  MoviePlayerViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import UIKit

class MoviePlayerViewController: UIViewController {
    
    var movieDuration: Float = 100
    var isPause: Bool = false {
        didSet {
            let imageName = isPause ? "pause.fill" : "play.fill"
            playButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    private lazy var playerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        imageView.isUserInteractionEnabled = true // Enable user interaction
        return imageView
    }()
    
    private lazy var overlayLayerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "111827").withAlphaComponent(0.72)
        view.alpha = 0 // Initially transparent
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.StaticColors.white
        label.text = "Қызғалдақтар мекені"
        return label
    }()
    
    lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.StaticColors.gray400
        label.text = "1 серия"
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
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
        slider.maximumValue = Float(movieDuration)
        slider.thumbTintColor = .black
        slider.minimumTrackTintColor = UIColor.black.withAlphaComponent(0.4)
        slider.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.4)
        slider.setValue(0, animated: true)
        
        let thumbSize: CGFloat = 16
        let thumbSizeExpanded: CGFloat = 32
        
        slider.setThumbImage(UIImage.circle(diameter: thumbSize, color: .black), for: .normal)
        slider.setThumbImage(UIImage.circle(diameter: thumbSizeExpanded, color: .black), for: .highlighted)
        
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        
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
        label.text = "01:00:00"
        return label
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
        view.backgroundColor = Style.Colors.label
        
        setupPlayerView()
        
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
    }
    
    func setupPlayerView() {
        view.addSubview(playerView)
        
        playerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupOverlayLayerView() {
        view.addSubview(overlayLayerView)
        
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
    
}

// MARK: - Targets
private extension MoviePlayerViewController {
    
    @objc func playButtonTapped(_ sender: UIButton!) {
        resetOverlayTimer()
        isPause.toggle()
    }
    
    @objc func forwardButtonTapped(_ sender: UIButton!) {
        resetOverlayTimer()
    }
    
    @objc func backwardButtonTapped(_ sender: UIButton!) {
        resetOverlayTimer()
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let currentValue = sender.value
        print(currentValue)
        resetOverlayTimer()
    }
    
    
    
}

// MARK: - Internal functions
private extension MoviePlayerViewController {
    
    // MARK: Gesture Recognizers
    
    func setupGestureRecognizers() {
        playerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerViewTapped)))
        overlayLayerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playerViewTapped)))
    }
    
    @objc func playerViewTapped() {
        if overlayLayerView.alpha == 0 {
            showOverlayView()
        } else {
            hideOverlayView()
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
    
    
}

// MARK: - Public functions
extension MoviePlayerViewController {
    
}
