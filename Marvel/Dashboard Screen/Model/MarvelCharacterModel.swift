//
//  MarvelCharacterModel.swift
//  Marvel
//
//  Created by Rabi Chourasia on 12/03/22.


import Foundation

// MARK: - MarvelList
struct MarvelCharacterListModel: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: MarvelListData?
}

// MARK: - MarvelListData
struct MarvelListData: Codable {
    let offset, limit, total, count: Int?
    let results: [MarvelListResult]?
}

// MARK: - MarvelListResult
struct MarvelListResult: Codable {
    let id: Int?
    let name, resultDescription, modified: String?
    let thumbnail: MarvelListThumbnail?
    let resourceURI: String?
    let comics, series: MarvelListComics?
    let stories: MarvelListStories?
    let events: MarvelListComics?
    let urls: [MarvelListURL]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

// MARK: - MarvelListComics
struct MarvelListComics: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [MarvelListComicsItem]?
    let returned: Int?
}

// MARK: - MarvelListComicsItem
struct MarvelListComicsItem: Codable {
    let resourceURI: String?
    let name: String?
}

// MARK: - MarvelListStories
struct MarvelListStories: Codable {
    let available: Int?
    let collectionURI: String?
    let items: [MarvelListStoriesItem]?
    let returned: Int?
}

// MARK: - MarvelListStoriesItem
struct MarvelListStoriesItem: Codable {
    let resourceURI: String?
    let name, type: String?
}

// MARK: - MarvelListThumbnail
struct MarvelListThumbnail: Codable {
    let path: String?
    let thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - MarvelListURL
struct MarvelListURL: Codable {
    let type: String?
    let url: String?
}
