//
//  NewsModel.swift
//  SaleMarket
//
//  Created by Timur Isaev on 24.12.2020.
//

import Foundation

struct NewsModel {
    enum TypeNews {
        case news
        case test
    }
    
    let id: Int
    let name: String
    let imageMini: String
    let image: String
    let type: TypeNews
    let urlNews: String?
    let testId: Int
}

func featchNewsData() -> [NewsModel] {
    
    var newsArray = [NewsModel]()
    
    newsArray.append(NewsModel(id: 1,
                               name: "5 советов, как выбрать удачный подарок на Новый Год",
                               imageMini: "image-mini-1",
                               image: "image-1",
                               type: .news, urlNews: "https://hi-tech.mail.ru/news/52361-mask-nazval-nerealnoy-innovacionnuyu-batareyu-dlya-mashiny-apple/?frommail=1",
                               testId: 0))
    newsArray.append(NewsModel(id: 2,
                               name: "Новогодние подарки для коллег",
                               imageMini: "image-mini-2",
                               image: "image-2",
                               type: .news, urlNews: "https://hi-tech.mail.ru/news/52364-novogodnee-nastroenie-ot-nasa-kak-vyglyadit-skoplenie-rozhdestvenskaya-elka/?frommail=1",
                               testId: 0))
    newsArray.append(NewsModel(id: 3,
                               name: "Тест: как выбрать идеальный подарок на Новый Год",
                               imageMini: "image-mini-3",
                               image: "image-3",
                               type: .test, urlNews: nil,
                               testId: 1))
    
    return newsArray
}
