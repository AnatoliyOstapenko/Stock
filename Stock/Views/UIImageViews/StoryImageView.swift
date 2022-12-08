//
//  StoryImageView.swift
//  Stock
//
//  Created by AnatoliiOstapenko on 08.12.2022.
//

import UIKit

class StoryImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        clipsToBounds = true
        layer.cornerRadius = 6
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
        image = Constants.defaultImage
    }
    
    func setImage(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = Constants.defaultImage
            return }
        
        DispatchQueue.global(qos: .userInteractive).async {
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil, let data = data else { return }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }

}
