//
//  NewsHeaderView.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 23.11.2022.
//

import UIKit

class NewsHeaderView: UITableViewHeaderFooterView {
    static let preferredHeight: CGFloat = 70
    
    // MARK: - Private properties
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("+ WatchList", for: .normal)
        button.backgroundColor = .systemCyan
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addAllSubbviews(label, button)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // TODO: - Let's set later
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 14, y: 0, width: contentView.width - 28, height: contentView.height)
        button.sizeToFit() // resize button frame depends on text button
        button.frame = CGRect(x: contentView.width - button.width - 18,
                              y: (contentView.height - button.height)/2,
                              width: button.width + 8,
                              height: button.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    @objc private func buttonPressed() {
        print("button pressed")
    }
    
    public func updateNewsHeader(with viewModel: NewsHeaderViewModel) {
        self.label.text = viewModel.title
        button.isHidden = !viewModel.shouldShowAddButton
    }
    
    

}
