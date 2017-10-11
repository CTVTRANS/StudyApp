//
//  DefineURL.swift
//  BookApp
//
//  Created by kien le van on 8/25/17.
//  Copyright © 2017 Le Cong. All rights reserved.
//

import UIKit

let defaultNonSigin = "/api/setting/get_setting"

// MARK: Book
let getBookTypeURL = "/api/book/list_category"
let getBookForEachTypeURL = "/api/book/list_post_by_category"
let getBookSuggestForTypeURL = "/api/book/list_suggest_posts_by_category"
let getBookNewestURL = "/api/book/list_latest_posts"
let getAllBookSuggestURL = "/api/book/list_all_suggest_posts"
let getAllBookFreeURL = "/api/book/list_free"
let getAllBookBookmarkedURL = "/api/collection/collection_book"

// MARK: Chanel
let getAllChanelSuggestURL = "/api/teacher/list_all_suggest_teacher"
let getChanelFreeURL = "/api/teacher/list_free"
let getListLessonOfChanelURL = "/api/teacher/list_lesson"
let getTotalViewOfChanelURL = "/api/teacher/number_of_play"
let getAllSubcribled = "/api/teacher/list_subscribe"
let getHotChanel = "/api/teacher/list_hot"
let subcribleURL = "/api/teacher/subscribe"
let increaseViewChanelURL = "/api/teacher/play_lesson"

// MARK: News
let getAllNewsURL = "/api/post/list_latest_post"
let getAllTypeNewsURL = "/api/post/list_category"
let getAllNewsBookmarkedURL = "/api/collection/collection_news"
let getNewRelatedURL = "/api/post/get_related_post"

// MARK: Coment, Like, Book,ark
let sendCommentURL = "/api/comment/add"
let checkLikeedURL = "/api/like/check_like"
let likeUnlikeURL = "/api/like/like"
let bookMarkURL = "/api/collection/collect"
let checkBookMarkedURL = "/api/collection/check_collect"
let getAllCommentURL = "/api/comment/latest"
let getAllCommentHotURL = "/api/comment/hot"

// MARK: Golobal
let searchBookURL = "/api/search/book"
let searchNewsURL = "/api/search/news"
let getNotification = "/api/notification/get"
let markReadNoticeURL = "/api/notification/mark_read"
let getHotKeyWordURL = "/api/search/hot_keyword"
let removeNoticeURL = "/api/notification/delete"

// MARK: Member
let getProfileMemberURL = "/api/member/detail"
let getCodeURL = "/api/member/generate_confirm_code"
let registerURL = "/api/member/register"
let sigInURL = "/api/member/login"
let forgetPasswordURL = "/api/member/forgot_password"
let upDateInfomationMemberURL = "/api/member/update_profile"
let upDatePasswordURL = "/api/member/change_password"
let upAvaterURL = "/api/member/update_avatar"
let upDatePointURL = "/api/member/add_point"

// MARK: Group
let getSlidershowURL = "/api/slide/get?screen_show"
let getAllGroupURL = "/api/group/list_group"
let getAllGroupJoinedURL = "/api/group/list_subscribe"
let getListNewsInGroupURL = "/api/group/list_post_by_group"
let subcribleGroupURL = "/api/group/multi_subscribe"
let subcribleOneGroupURL = "/api/group/subscribe"
let getListNewsForAllGroupURL = "/api/group/list_post"

// MARK: Product
let getAllProductByPointURL = "/api/product/list_product_point"
let getAllProductByPointAndMoneyURL = "/api/product/list_product_price_mix"
let getAllProductURL = "/api/product/list_all_product"
let getAllVipProductURL = "/api/product/list_package"

let css: String = "<style> img{max-width:100%} </style>"

class DefineURL: NSObject {
    
}
