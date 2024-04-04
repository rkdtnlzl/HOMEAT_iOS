//
//  FoodTalkController.swift
//  HOMEAT
//
//  Created by 이지우 on 4/4/24.
//

import Foundation
import UIKit
import Then

class FoodTalkViewController: BaseViewController {
    
    //MARK: - Property
    private let searchBar = UISearchBar()
    private let listButton = UIButton()
    private let scrollView = UIScrollView()
    //버튼이 여러개 존재하는데 재사용 파일을 만들어야 하나?
    private let hashtagButton = UIButton()
    //private let collectionView = UICollectionView()
    private let writeButton = UIButton()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
    }
    
    //MARK: - SetUI
    override func setConfigure() {
        view.do {
            $0.backgroundColor = UIColor(r: 30, g: 32, b: 33)
        }
        
        searchBar.do {
            $0.backgroundImage = UIImage()
            $0.backgroundColor = UIColor(named: "coolGray4")
            $0.searchTextField.placeholder = "관심있는 집밥을 검색해보세요!"
            $0.makeBorder(width: 1, color: UIColor(r: 102, g: 102, b: 102))
            $0.makeCornerRound(radius: 7)
            $0.delegate = self
        }
        
        listButton.do {
            $0.setTitle("최신순", for: .normal)
            $0.setTitleColor(UIColor(named: "turquoiseGreen"), for: .normal)
        }
    }
    
    override func setConstraints() {
        
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(164)
            $0.width.equalTo(351)
            $0.height.equalTo(35)
        }
    }
}

//MARK: - Extension
extension FoodTalkViewController: UISearchBarDelegate {
    
    func setSearchBar(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //searchBar 백그라운드 컬러
            textfield.backgroundColor = UIColor(named: "coolGray4")
            //플레이스홀더 글씨 색 정하기
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(r: 216, g: 216, b: 216)])
            //searchBar 텍스트입력시 색 정하기
            textfield.textColor = UIColor(r: 216, g: 216, b: 216)
            //왼쪽 아이콘 이미지넣기
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                //이미지 틴트컬러 정하기
                leftView.tintColor = UIColor(r: 216, g: 216, b: 216)
            }
        }
        
        // UISearchBarDelegate 메서드 구현.
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            // 검색 버튼을 눌렀을 때 호출되는 메서드.
            if let searchText = searchBar.text {
                // 검색어를 사용하여 검색을 수행.
                performSearch(with: searchText)
            }
            searchBar.resignFirstResponder() // 키보드 숨기기
        }
        
        func performSearch(with searchText: String) {
            // 검색 로직 구현하는 부분. 네트워크.
            print("검색어: \(searchText)")
        }
    }
}
