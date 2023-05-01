//
//  TeamTableViewCell.swift
//  Football Teams
//
//  Created by Vikas on 01/05/23.
//

import UIKit

protocol TeamTableViewCellDelegate: class {
    func didTapPlayButton(for team: Team)
}

class TeamTableViewCell: UITableViewCell {
    
    static let cellID = "TeamTableViewCell"
    
    // MARK: - UI
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()
    
    private lazy var badgeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var playbackBtn: UIButton = {
         let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var foundedLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private lazy var jobLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 10, weight: .light)
        return label
    }()
    
    private lazy var infoLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private weak var delegate: TeamTableViewCellDelegate?
    private var team: Team?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
        self.team = nil
        self.containerView.subviews.forEach{$0.removeFromSuperview()}
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
    }
    
    func configure(with team: Team, delegate: TeamTableViewCellDelegate) {
        
        self.delegate = delegate
        self.team = team
        
        containerView.backgroundColor = team.id.background
        
        badgeImage.image = team.id.badge
        playbackBtn.setImage(team.isPlaying ? Assets.pause : Assets.play, for: .normal)
        playbackBtn.addTarget(self, action: #selector(didTapPlaybutton), for: .touchUpInside)
        
        nameLbl.text = team.name
        foundedLbl.text = team.founded
        jobLbl.text = "Current \(team.manager.job.rawValue): \(team.manager.name)"
        infoLbl.text = team.info
        
        // Cell layout constraints
        cellLayout()
    }
    
    func cellLayout() {
        self.contentView.addSubview(containerView)
        
        containerView.addSubview(contentStackView)
        containerView.addSubview(badgeImage)
        containerView.addSubview(playbackBtn)
        
        contentStackView.addArrangedSubview(nameLbl)
        contentStackView.addArrangedSubview(foundedLbl)
        contentStackView.addArrangedSubview(jobLbl)
        contentStackView.addArrangedSubview(infoLbl)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            
            badgeImage.heightAnchor.constraint(equalToConstant: 50),
            badgeImage.widthAnchor.constraint(equalToConstant: 50),
            badgeImage.topAnchor.constraint(equalTo: self.contentStackView.topAnchor),
            badgeImage.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 8),
            
            contentStackView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: self.badgeImage.trailingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: self.playbackBtn.leadingAnchor, constant: -8),
            
            playbackBtn.widthAnchor.constraint(equalToConstant: 44),
            playbackBtn.heightAnchor.constraint(equalToConstant: 44),
            playbackBtn.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -8),
            playbackBtn.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor)
        ])
    }
    
    @objc func didTapPlaybutton() {
        guard let team else { return }
        delegate?.didTapPlayButton(for: team)
    }
    
}
