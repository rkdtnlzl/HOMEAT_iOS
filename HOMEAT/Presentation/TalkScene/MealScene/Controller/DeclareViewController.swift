//
//  declareViewController.swift
//  HOMEAT
//
//  Created by 이지우 on 5/5/24.
//

import UIKit

class DeclareViewController: BaseViewController {
    
    //MARK: - Property
    private let declareLabel = UILabel()
    private let container = UIStackView()
    private let firstButton = UIButton()
    private let secondButton = UIButton()
    private let thirdButton = UIButton()
    private let forthButton = UIButton()
    private let fifthButton = UIButton()
    private let submitButton = UIButton()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        view.backgroundColor = UIColor(named: "homeBackgroundColor")
        
        declareLabel.do {
            $0.text = "신고하는 이유가 무엇인가요?"
            $0.font = .headBold24
            $0.textColor = .white
        }
        
        container.do {
            $0.backgroundColor = UIColor(named: "homeBackgroundColor")
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 30
        }
        
        firstButton.do {
            $0.setTitle("음란물입니다.", for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.warmgray6.cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        }
        
        secondButton.do {
            $0.setTitle("욕설/생명경시/혐오/차별적 표현입니다.", for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.warmgray6.cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        }
        
        thirdButton.do {
            $0.setTitle("불쾌한 표현이 있습니다.", for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.warmgray6.cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        }
        
        forthButton.do {
            $0.setTitle("개인정보 노출 게시물입니다.", for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.warmgray6.cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        }
        
        fifthButton.do {
            $0.setTitle("불법정보를 표현하고 있습니다.", for: .normal)
            $0.titleLabel?.font = .bodyBold16
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.warmgray6.cgColor
            $0.contentHorizontalAlignment = .left
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            $0.addTarget(self, action: #selector(optionActtion), for: .touchUpInside)
        }
        
        submitButton.do {
            $0.setTitle("신고하기", for: .normal)
            $0.titleLabel?.font = .bodyMedium18
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .warmgray3
            $0.layer.cornerRadius = 10
        }
    }
    override func setConstraints() {
        view.addSubviews(declareLabel, container, submitButton)
        container.addArrangedSubview(firstButton)
        container.addArrangedSubview(secondButton)
        container.addArrangedSubview(thirdButton)
        container.addArrangedSubview(forthButton)
        container.addArrangedSubview(fifthButton)
        
        declareLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(139)
            $0.leading.equalToSuperview().inset(52)
            $0.trailing.equalToSuperview().inset(52)
            $0.height.equalTo(28)
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(declareLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(21)
            $0.trailing.equalToSuperview().inset(21)
            $0.height.equalTo(355)
        }
        
        submitButton.snp.makeConstraints {
            $0.leading.equalTo(container.snp.leading)
            $0.trailing.equalTo(container.snp.trailing)
            $0.bottom.equalToSuperview().inset(68)
            $0.height.equalTo(57)
        }
    }
    
    private func setNavigationBar() {
        navigationItem.title = "게시글 신고하기"
        let backbutton = UIBarButtonItem()
        backbutton.tintColor = .white
        navigationController?.navigationBar.topItem?.backBarButtonItem = backbutton
    }
    
    //MARK: - @objc
    @objc func optionActtion(_ sender: UIButton) {
        let nextVC = DeclareWriteViewController()
        nextVC.hidesBottomBarWhenPushed = true
        switch sender {
        case firstButton:
            nextVC.optionLabel = firstButton.titleLabel?.text
            navigationController?.pushViewController(nextVC, animated: true)
        case secondButton:
            nextVC.optionLabel = secondButton.titleLabel?.text
            navigationController?.pushViewController(nextVC, animated: true)
        case thirdButton:
            nextVC.optionLabel = thirdButton.titleLabel?.text
            navigationController?.pushViewController(nextVC, animated: true)
        case forthButton:
            nextVC.optionLabel = forthButton.titleLabel?.text
            navigationController?.pushViewController(nextVC, animated: true)
        case fifthButton:
            nextVC.optionLabel = fifthButton.titleLabel?.text
            navigationController?.pushViewController(nextVC, animated: true)
        default:
            fatalError("Error")
        }
    }
}
