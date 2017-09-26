//
//  HeaderCollectionReusableView.swift
//  BookApp
//
//  Created by kien le van on 9/13/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit
import FSPagerView

class HeaderCollectionReusableView: UICollectionReusableView, FSPagerViewDataSource, FSPagerViewDelegate {
        
    @IBOutlet weak var showAll: UIButton!
    @IBOutlet weak var markNumber: UILabel!
    @IBOutlet weak var showMark: UIButton!
    @IBOutlet weak var showMarkAndMoney: UIButton!
    
    private var listSlider: [SliderShow] = []
    @IBOutlet weak var sliderShow: FSPagerView! {
        didSet {
            self.sliderShow.scrollDirection = .horizontal
            self.sliderShow.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.sliderShow.itemSize = .zero
        }
    }

    @IBOutlet weak var pageControlView: FSPageControl! {
        didSet {
            self.pageControlView.contentHorizontalAlignment = .center
            self.pageControlView.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showAll.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        showMark.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        showMarkAndMoney.layer.borderColor = UIColor.rgb(red: 255, green: 102, blue: 0).cgColor
        if Constants.sharedInstance.memberProfile != nil {
             markNumber.text = String(Constants.sharedInstance.memberProfile!.point)
        }
        sliderShow.delegate = self
        sliderShow.dataSource = self
    }

    // MARK: FSPagerView Data Source
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listSlider.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage(with: URL(string:listSlider[index].imageURL))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    // MARK: FSPagerView Delegate

    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        sliderShow.deselectItem(at: index, animated: true)
        sliderShow.scrollToItem(at: index, animated: true)
        self.pageControlView.currentPage = index
        print(index)
    }

    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControlView.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControlView.currentPage = pagerView.currentIndex // Or Use KVO with property "currentIndex"
    }
    
    func binData(listBaner: [SliderShow]) {
        listSlider = listBaner
        pageControlView.numberOfPages = listSlider.count
        sliderShow.reloadData()
    }

    @IBAction func pressedShowAllButton(_ sender: Any) {
        
    }
    
    @IBAction func pressedShowMarkButton(_ sender: Any) {
        print("2")
    }
    
    @IBAction func pressShowMarkAndMoney(_ sender: Any) {
        print("3")    }

}
