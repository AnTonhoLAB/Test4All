//
//  CommentView.swift
//  Test4All
//
//  Created by George Gomes on 11/07/19.
//  Copyright © 2019 George Gomes. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    private let identifier = "CommentView"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    
    convenience init(with comment: Comment, provider: TaskProvider) {
        self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 140))
        setupView(with: comment, provider: provider)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comInit()
    }
    
    private func comInit() {
        Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
    }
    
    func setupView(with comment: Comment, provider: TaskProvider) {
        self.nameLabel.text = comment.name
        self.titleLabel.text = comment.title
        self.commentLabel.text = comment.comment
        
        if let photoUrl = comment.urlPicture {
            provider.getImageData(withLink: photoUrl) { (result) in
                switch result {
                    
                case .success(let photoData):
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: photoData)
                    }
                case .failure(_):
                    break
                }
            }
        }
        
        guard let stars = comment.grade else { return }
    
        for (index, star) in stackView.arrangedSubviews.enumerated() {
            star.alpha = index < stars ? 1 : 0
        }
    }
}
