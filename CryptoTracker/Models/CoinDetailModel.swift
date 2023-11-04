//
//  CoinDetailModel.swift
//  CryptoTracker
//
//  Created by Anton Tropin on 01.11.23.
//

import Foundation

// JSON Data
/*
 URL:
 https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 
 RESPONSE
 {
   "id": "bitcoin",
   "symbol": "btc",
   "name": "Bitcoin",
   "asset_platform_id": null,
   "platforms": {
     "": ""
   },
   "detail_platforms": {
     "": {
       "decimal_place": null,
       "contract_address": ""
     }
   },
   "block_time_in_minutes": 10,
   "hashing_algorithm": "SHA-256",
   "categories": [
     "FTX Holdings",
     "Cryptocurrency",
     "Layer 1 (L1)"
   ],
   "preview_listing": false,
   "public_notice": null,
   "additional_notices": [],
   "description": {
     "en": "Bitcoin is the first successful internet money based on peer-to-peer technology; whereby no central bank or authority is involved in the transaction and production of the Bitcoin currency. It was created by an anonymous individual/group under the name, Satoshi Nakamoto. The source code is available publicly as an open source project, anybody can look at it and be part of the developmental process.\r\n\r\nBitcoin is changing the way we see money as we speak. The idea was to produce a means of exchange, independent of any central authority, that could be transferred electronically in a secure, verifiable and immutable way. It is a decentralized peer-to-peer internet currency making mobile payment easy, very low transaction fees, protects your identity, and it works anywhere all the time with no central authority and banks.\r\n\r\nBitcoin is designed to have only 21 million BTC ever created, thus making it a deflationary currency. Bitcoin uses the <a href=\"https://www.coingecko.com/en?hashing_algorithm=SHA-256\">SHA-256</a> hashing algorithm with an average transaction confirmation time of 10 minutes. Miners today are mining Bitcoin using ASIC chip dedicated to only mining Bitcoin, and the hash rate has shot up to peta hashes.\r\n\r\nBeing the first successful online cryptography currency, Bitcoin has inspired other alternative currencies such as <a href=\"https://www.coingecko.com/en/coins/litecoin\">Litecoin</a>, <a href=\"https://www.coingecko.com/en/coins/peercoin\">Peercoin</a>, <a href=\"https://www.coingecko.com/en/coins/primecoin\">Primecoin</a>, and so on.\r\n\r\nThe cryptocurrency then took off with the innovation of the turing-complete smart contract by <a href=\"https://www.coingecko.com/en/coins/ethereum\">Ethereum</a> which led to the development of other amazing projects such as <a href=\"https://www.coingecko.com/en/coins/eos\">EOS</a>, <a href=\"https://www.coingecko.com/en/coins/tron\">Tron</a>, and even crypto-collectibles such as <a href=\"https://www.coingecko.com/buzz/ethereum-still-king-dapps-cryptokitties-need-1-billion-on-eos\">CryptoKitties</a>."
   },
   "links": {
     "homepage": [
       "http://www.bitcoin.org",
       "",
       ""
     ],
     "blockchain_site": [
       "https://blockchair.com/bitcoin/",
       "https://btc.com/",
       "https://btc.tokenview.io/",
       "https://www.oklink.com/btc",
       "https://3xpl.com/bitcoin",
       "",
       "",
       "",
       "",
       ""
     ],
     "official_forum_url": [
       "https://bitcointalk.org/",
       "",
       ""
     ],
     "chat_url": [
       "",
       "",
       ""
     ],
     "announcement_url": [
       "",
       ""
     ],
     "twitter_screen_name": "bitcoin",
     "facebook_username": "bitcoins",
     "bitcointalk_thread_identifier": null,
     "telegram_channel_identifier": "",
     "subreddit_url": "https://www.reddit.com/r/Bitcoin/",
     "repos_url": {
       "github": [
         "https://github.com/bitcoin/bitcoin",
         "https://github.com/bitcoin/bips"
       ],
       "bitbucket": []
     }
   },
   "image": {
     "thumb": "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png?1696501400",
     "small": "https://assets.coingecko.com/coins/images/1/small/bitcoin.png?1696501400",
     "large": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400"
   },
   "country_origin": "",
   "genesis_date": "2009-01-03",
   "sentiment_votes_up_percentage": 82.88,
   "sentiment_votes_down_percentage": 17.12,
   "watchlist_portfolio_users": 1360397,
   "market_cap_rank": 1,
   "coingecko_rank": 1,
   "coingecko_score": 83.151,
   "developer_score": 99.241,
   "community_score": 83.341,
   "liquidity_score": 100.011,
   "public_interest_score": 0.073,
   "public_interest_stats": {
     "alexa_rank": 9440,
     "bing_matches": null
   },
   "status_updates": [],
   "last_updated": "2023-11-01T10:55:57.877Z"
 }
 
 */

import Foundation

// MARK: - CoinDetail
struct CoinDetail: Decodable {
    let id, symbol, name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let previewListing: Bool?
    let description: Description?
    let links: Links?
    
    var readableDescription: String? {
        description?.en?.removingHTMLOccurances
    }
}

// MARK: - Description
struct Description: Decodable {
    let en: String?
}

// MARK: - Links
struct Links: Decodable {
    let homepage: [String]?
    let twitterScreenName, facebookUsername: String?
    let telegramChannelIdentifier: String?
    let subredditURL: String?
}
