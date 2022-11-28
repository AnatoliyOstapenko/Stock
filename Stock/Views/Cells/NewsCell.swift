//
//  NewsCell.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 25.11.2022.
//

import UIKit

class NewsCell: UITableViewCell {

    // MARK: - Private UI
    private let sourceLabel = NewsCellLabel(ofSize: 14, weight: .medium)
    private let headlineLabel = NewsCellLabel(ofSize: 17, weight: .regular)
    private let dateLabel = NewsCellLabel(ofSize: 14, weight: .light)
    
    private let storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        contentView.backgroundColor = nil
        backgroundColor = nil
        addAllSubbviews(sourceLabel, headlineLabel, dateLabel, storyImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
        
    }
    

}
