//
//  DefineURL.swift
//  BookApp
//
//  Created by kien le van on 8/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

let getBookTypeURL: String = "/api/book/list_category"
let getBookForEachTypeURL: String = "/api/book/list_post_by_category"
let getBookSuggestForTypeURL: String = "/api/book/list_suggest_posts_by_category"
let getBookNewestURL: String = "/api/book/list_latest_posts"
let getAllBookSuggestURL: String = "/api/book/list_all_suggest_posts"
let getAllBookFreeURL: String = "/api/book/list_free"

let getAllChanelSuggestURL: String = "/api/teacher/list_all_suggest_teacher"
let getChanelFreeURL: String = "/api/teacher/list_free"
let getListLessonOfChanelURL = "/api/teacher/list_lesson"
let getTotalViewOfChanelURL = "/api/teacher/number_of_play"
let getAllSubcribled = "/api/teacher/list_subscribe"
let getHotChanel = "/api/teacher/list_hot"
let subcribleURL = "/api/teacher/subscribe"
let increaseViewChanelURL = "/api/teacher/play_lesson"

let getAllNewsURL: String = "/api/post/list_latest_post"
let getAllTypeNewsURL = "/api/post/list_category"

let sendCommentURL: String = "/api/comment/add"
let checkLikeedURL: String = "/api/like/check_like"
let likeUnlikeURL: String = "/api/like/like"
let bookMarkURL: String = "/api/collection/collect"
let checkBookMarkedURL: String = "/api/collection/check_collect"
let getAllCommentURL: String = "/api/comment/latest"
let searchBookURL: String = "/api/search/book"
let searchNewsURL: String = "/api/search/news"

let getProfileMemberURL: String = "/api/member/detail"

let getSlidershowURL: String = "/api/slide/get?screen_show"
let getAllGroupURL: String = "/api/group/list_group"
let getAllGroupJoinedURL: String = "/api/group/list_subscribe"
let getListNewsInGroupURL: String = "/api/group/list_post_by_group"
let subcribleGroupURL: String = "/api/group/multi_subscribe"

let getAllProductByPointURL: String = "/api/product/list_product_point"
let getAllProductByPointAndMoneyURL: String = "/api/product/list_product_price_mix"
let getAllProductURL: String = "/api/product/list_all_product"
let getAllVipProductURL: String = "/api/product/list_package"

let css: String = "<style> img{max-width:100%} </style>"

class DefineURL: NSObject {
    
}
