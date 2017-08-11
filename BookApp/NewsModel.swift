//
//  NewsModel.swift
//  BookApp
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    private var imageURL: String!
    private var titleNews: String!
    private var detailTitle: String!
    private var typeNews: String!
    private var numberViewNews: String!
    private var numberLikeNews: String!
    private var numberCommentNews: String!
    private var numberBookMarkNews: String!
    
    init(imageUrl: String,
            title: String,
            detail: String,
            type: String,
            numberView: String,
            numberLike: String,
            numberComment: String,
            numberBookMark: String) {
        imageURL = imageUrl
        titleNews = title
        detailTitle = detail
        typeNews = type
        numberViewNews = numberView
        numberLikeNews = numberLike
        numberCommentNews = numberComment
        numberBookMarkNews = numberBookMark
    }
    
    func getImageUrl() -> String {
        return imageURL
    }
    
    func getTitle() -> String {
        return titleNews
    }
    
    func getDetailTitle() -> String {
        return detailTitle
    }
    
    func getType() -> String {
        return typeNews
    }
    
    func getNumberView() -> String {
        return numberViewNews
    }
    
    func getNumberLike() -> String {
        return numberLikeNews
    }
    
    func getNumberComment() -> String {
        return numberCommentNews
    }
    
    func getNumberBookMark() -> String {
        return numberBookMarkNews
    }

}
