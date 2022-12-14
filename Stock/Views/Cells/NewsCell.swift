//
//  NewsCell.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 25.11.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let preferedHeight: CGFloat = 140
    
    // MARK: - Private UI
    private let sourceLabel = NewsCellLabel(ofSize: 14, weight: .regular, textColor: .label)
    private let headlineLabel = NewsCellLabel(ofSize: 22, weight: .semibold, textColor: .label)
    private let dateLabel = NewsCellLabel(ofSize: 12, weight: .light, textColor: .secondaryLabel)
    private let storyImageView = StoryImageView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        contentView.backgroundColor = .systemBackground
        addAllSubbviews(sourceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Layout for storyImageView
        let imageSize: CGFloat = contentView.height / 1.4
        storyImageView.frame = CGRect(x: contentView.width - imageSize - 10,
                                      y: (contentView.height - imageSize) / 2,
                                      width: imageSize,
                                      height: imageSize)
        
        // Layout for labels
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15
        dateLabel.frame = CGRect(x: separatorInset.left,
                                 y: contentView.height - 40,
                                 width: availableWidth,
                                 height: 40)
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(x: separatorInset.left,
                                   y: 4,
                                   width: availableWidth,
                                   height: sourceLabel.height)
        
        headlineLabel.frame = CGRect(x: separatorInset.left,
                                     y: sourceLabel.bottom + 5,
                                     width: availableWidth,
                                     height: contentView.height - sourceLabel.bottom - dateLabel.height - 10)
    }
    
    // FIXME: - Read later, what the reason to prepare my cell?
    override func prepareForReuse() {
        super.prepareForReuse()
        sourceLabel.text = nil
        headlineLabel.text = nil
        dateLabel.text = nil
        storyImageView.image = nil
    }
    
    public func updateNewsCell(with viewModel: NewsCellModel) {
        sourceLabel.text = viewModel.source
        headlineLabel.text = viewModel.headline
        dateLabel.text = viewModel.dateString
        storyImageView.setImage(urlString: viewModel.imageURL)
    }  
}
