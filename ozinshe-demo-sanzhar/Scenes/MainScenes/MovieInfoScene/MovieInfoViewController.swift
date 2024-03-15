//
//  MovieInfoViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 14.03.2024.
//

import UIKit
import SnapKit

class MovieInfoViewController: UIViewController {
    
    let descriptionGradientLayer = CAGradientLayer()
    
    var isDescriptionRevealed: Bool = false
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -32
        return stackView
    }()
    
    
    
    
    /* MARK: HEADER ELEMENTS */
    lazy var previewImageContainerView = UIView()
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var shadowGradientView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gradient")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "playButton"), for: .normal)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "shareButton"), for: .normal)
        return button
    }()
    
    lazy var shareLabel: UILabel = {
        let label = UILabel()
        label.text = "Бөлісу"
        label.textColor = Style.StaticColors.gray400
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var saveLabel: UILabel = {
        let label = UILabel()
        label.text = "Тізімге қосу"
        label.textColor = Style.StaticColors.gray400
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "saveButton"), for: .normal)
        return button
    }()
    
    
    
    
    /* MARK: BODY ELEMENTS */
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.background
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var shortInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 • Телехакия • 5 сезон, 46 серия, 7 мин."
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    lazy var separator1View: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray200
        label.numberOfLines = 5
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray600
        return label
    }()
    
    lazy var directorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Бақдәулет Әлімбеков"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    lazy var producerLabel: UILabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray600
        return label
    }()
    
    lazy var producerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Сандуғаш Кенжебаева"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    lazy var separator2View: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        return view
    }()
    
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var sectionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        button.setTitleColor(Style.Colors.gray400, for: .normal)
        button.tintColor = Style.Colors.purple300
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    lazy var sectionInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "5 сезон, 46 серия"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    lazy var screenshotsLabel: UILabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var screenshotsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(184, 112)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        
        collectionView.register(ScreenshotCollectionViewCell.self,
                                forCellWithReuseIdentifier: ScreenshotCollectionViewCell.ID)
        return collectionView
    }()
    
    lazy var similarSeriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Ұқсас телехикаялар"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var moreSimilarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Барлыгы", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        return button
    }()
    
    lazy var similarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(112, 219)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        
        collectionView.register(GalleryListCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryListCollectionViewCell.ID)
        return collectionView
    }()
    
    
    
    
    /* MARK: VIEW CONTROLLER LIFECYCLE */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupScrollView()
        setupPreviewImageView()
        setupContentView()
    }
    
    override func viewDidLayoutSubviews() {
        setupDescriptionConfig()
    }
    
    
}


// MARK: UI Setups
extension MovieInfoViewController {
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    
    
    /* MARK: Header setups */
    fileprivate func setupPreviewImageView() {
        stackView.addArrangedSubview(previewImageContainerView)
        previewImageContainerView.backgroundColor = .red
        
        previewImageContainerView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        
        
        previewImageContainerView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalToSuperview()
        }
        
        setupGradientView()
        setupPlayButton()
        setupShareButton()
        setupSaveButton()
    }
    
    fileprivate func setupGradientView() {
        previewImageView.addSubview(shadowGradientView)
        
        shadowGradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupPlayButton() {
        previewImageView.addSubview(playButton)
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(32 + 4)
            make.height.width.equalTo(132)
        }
    }
    
    fileprivate func setupShareButton() {
        previewImageView.addSubview(shareButton)
        
        shareButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.right.equalToSuperview().inset(37)
            make.bottom.equalToSuperview().inset(32 + 4)
        }
        
        
        shareButton.addSubview(shareLabel)
        
        shareLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(46)
        }
    }
    
    fileprivate func setupSaveButton() {
        previewImageView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.equalToSuperview().inset(37)
            make.bottom.equalToSuperview().inset(32 + 4)
        }
        
        
        saveButton.addSubview(saveLabel)
        
        saveLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(46)
        }
    }
    
    
    
    /* MARK: Body setups */
    fileprivate func setupContentView() {
        stackView.addArrangedSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(900)
        }
        
        setupMovieNameLabel()
        setupShortInfoLabel()
        setupSeparator1View()
        
        setupDescriptionTextView()
        setupMoreButton()
        
        setupDirectorLabel()
        setupDirectorNameLabel()
        setupProducerLabel()
        setupProducerNameLabel()
        setupSeparator2View()
        
        setupSectionButton()
        setupSectionLabel()
        setupSectionInfoLabel()
        
        setupScreenshotsLabel()
        setupScreenshotsCollectionView()
        
        setupSimilarSeriesLabel()
        setupSimilarCollectionView()
    }
    
    fileprivate func setupMovieNameLabel() {
        contentView.addSubview(movieNameLabel)
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupShortInfoLabel() {
        contentView.addSubview(shortInfoLabel)
        
        shortInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(movieNameLabel)
        }
    }
    
    fileprivate func setupSeparator1View() {
        contentView.addSubview(separator1View)
        
        separator1View.snp.makeConstraints { make in
            make.top.equalTo(shortInfoLabel.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    
    fileprivate func setupDescriptionTextView() {
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(separator1View.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        descriptionGradientLayer.colors = [Style.Colors.background.withAlphaComponent(0.0).cgColor,
                                           Style.Colors.background.cgColor]
        
        descriptionGradientLayer.startPoint = CGPoint(x: 0, y: 0.1)
        descriptionGradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        descriptionLabel.layer.insertSublayer(descriptionGradientLayer, at: 0)
    }
    
    fileprivate func setupDescriptionConfig() {
        if descriptionLabel.isTruncated || isDescriptionRevealed {
            moreButton.isHidden = false
            moreButton.snp.updateConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom).inset(-24)
                make.height.equalTo(24)
            }
            descriptionGradientLayer.frame = descriptionLabel.bounds
        } else {
            moreButton.isHidden = true
            moreButton.snp.updateConstraints { make in
                make.top.equalTo(descriptionLabel.snp.bottom)
                make.height.equalTo(0)
            }
        }
    }
    
    fileprivate func setupMoreButton() {
        contentView.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-16)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
    }
    
    fileprivate func setupDirectorLabel() {
        contentView.addSubview(directorLabel)
        
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupDirectorNameLabel() {
        contentView.addSubview(directorNameLabel)
        
        directorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).inset(-24)
            make.left.equalTo(directorLabel.snp.right).inset(-16)
            make.width.equalTo(200)
        }
    }
    
    fileprivate func setupProducerLabel() {
        contentView.addSubview(producerLabel)
        
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupProducerNameLabel() {
        contentView.addSubview(producerNameLabel)
        
        producerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).inset(-8)
            make.left.equalTo(producerLabel.snp.right).inset(-16)
            make.width.equalTo(200)
        }
    }
    
    fileprivate func setupSeparator2View() {
        contentView.addSubview(separator2View)
        
        separator2View.snp.makeConstraints { make in
            make.top.equalTo(producerLabel.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
    }
    
    fileprivate func setupSectionLabel() {
        contentView.addSubview(sectionLabel)
        
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(separator2View.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupSectionButton() {
        contentView.addSubview(sectionButton)
        
        sectionButton.snp.makeConstraints { make in
            make.top.equalTo(separator2View.snp.bottom).inset(-24+8)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(contentView.snp.centerX)
            make.height.equalTo(32)
        }
    }
    
    fileprivate func setupSectionInfoLabel() {
        sectionButton.addSubview(sectionInfoLabel)
        
        sectionInfoLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(13 + 8) // 13 is a chevron.right(button's icon) width
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func setupScreenshotsLabel() {
        contentView.addSubview(screenshotsLabel)
        
        screenshotsLabel.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).inset(-32)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupScreenshotsCollectionView() {
        contentView.addSubview(screenshotsCollectionView)
        
        screenshotsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(screenshotsLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
    }
    
    fileprivate func setupSimilarSeriesLabel() {
        contentView.addSubview(similarSeriesLabel)
        
        similarSeriesLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotsCollectionView.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupSimilarCollectionView() {
        contentView.addSubview(similarCollectionView)
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarSeriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.height.equalTo(224)
        }
    }
    
    
}

extension MovieInfoViewController {
    
    @objc func moreButtonTapped(_ sender: UIButton!) {
        Logger.log(.action, "More button pressed")
        if !isDescriptionRevealed { // show full text
            UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.descriptionLabel.numberOfLines = 0
            })
            self.moreButton.setTitle("Жасыру", for: .normal)
            self.descriptionGradientLayer.isHidden = true
        } else { // shop short
            UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.descriptionLabel.numberOfLines = 4
            })
            self.moreButton.setTitle("Толығырақ", for: .normal)
            descriptionGradientLayer.isHidden = false
        }
        isDescriptionRevealed.toggle()
    }
    
    
}


extension MovieInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case screenshotsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.ID, for: indexPath)
            return cell
        case similarCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryListCollectionViewCell.ID, for: indexPath)
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    
}
