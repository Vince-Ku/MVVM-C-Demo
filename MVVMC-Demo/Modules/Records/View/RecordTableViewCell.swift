//
//  RecordTableViewCell.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    private let containerHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let containerVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()
    
    private let starImageView: UIImageView = {
        let image = UIImage(systemName: "star")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(containerHStackView)
        containerVStackView.addArrangedSubview(titleLabel)
        containerVStackView.addArrangedSubview(detailLabel)
        containerHStackView.addArrangedSubview(containerVStackView)
        containerHStackView.addArrangedSubview(starImageView)

        NSLayoutConstraint.activate([
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            
            containerHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerHStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            containerHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setup(viewObject: RecordCellViewObject) {
        // titleLabel
        switch viewObject.titleStyle {
        case .regular(let titleText):
            titleLabel.text = titleText
            titleLabel.textColor = .black

        case .highLight(let titleText):
            titleLabel.text = titleText
            titleLabel.textColor = UIColor(red: 0, green: 150/255, blue: 0, alpha: 1)
        }
        
        // detailLabel
        detailLabel.text = viewObject.detailColumnText
        
        // starImageView
        switch viewObject.starImageStyle {
        case .regular:
            starImageView.isHidden = false
        case .none:
            starImageView.isHidden = true
        }
    }
}


