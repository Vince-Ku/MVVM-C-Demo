//
//  HomeViewController.swift
//  MVVMC-Demo
//
//  Created by 辜敬閎 on 2023/4/1.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject {
    func showLotteryResult(result: LotteryResult)
}

class HomeViewController: UIViewController {
    
    private let buttonsContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let recordsButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Lottery Records", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.addTarget(nil, action: #selector(recordsButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let lotteryButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Go Lottery!", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20)
        btn.addTarget(nil, action: #selector(lotteryButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    private let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupButtonsLayout()
        setupDelegate()
    }
    
    private func setupDelegate() {
        viewModel.viewDelegate = self
    }
    
    private func setupButtonsLayout() {
        view.addSubview(buttonsContainerStackView)
        
        buttonsContainerStackView.addArrangedSubview(recordsButton)
        buttonsContainerStackView.addArrangedSubview(lotteryButton)
        
        NSLayoutConstraint.activate([
            buttonsContainerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsContainerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buttonsContainerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsContainerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func recordsButtonDidTap() {
        viewModel.recordsButtonDidTap()
    }
    
    @objc func lotteryButtonDidTap() {
        viewModel.lotteryButtonDidTap()
    }
}

extension HomeViewController: HomeViewControllerDelegate {
    func showLotteryResult(result: LotteryResult) {
        lotteryButton.setTitle(result.rawValue, for: .normal)
    }
}
