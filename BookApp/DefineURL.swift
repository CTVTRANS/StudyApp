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

let getAllNewsURL: String = "/api/post/list_latest_post"
let sendCommentURL: String = "/api/comment/add"
let likeUnlikeURL: String = "/api/like/like"
let getAllCommentURL: String = "/api/comment/latest"

let css: String = "<style> img{max-width:100%} </style>"

class DefineURL: NSObject {

}
