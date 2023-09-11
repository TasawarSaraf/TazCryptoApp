//
//  MarketDataModel.swift
//  CryptoClone
//
//  Created by Tasawar Saraf on 7/4/22.
//

import Foundation


/*
 
 URL: https://api.coingecko.com/api/v3/global
 JSON Response:
 
 {
 "data": {
   "active_cryptocurrencies": 13396,
   "upcoming_icos": 0,
   "ongoing_icos": 49,
   "ended_icos": 3376,
   "markets": 526,
   "total_market_cap": {
     "btc": 46993034.1466938,
     "eth": 835845229.1328027,
     "ltc": 18098062860.44026,
     "bch": 8733149423.729677,
     "bnb": 4110120722.185025,
     "eos": 963173163862.4613,
     "xrp": 2876235548701.1084,
     "xlm": 8495995865579.153,
     "link": 148258928368.72626,
     "dot": 132667552840.78781,
     "yfi": 155695158.33272788,
     "usd": 930615321054.983,
     "aed": 3418140768081.7393,
     "ars": 117219334277690.19,
     "aud": 1355199255133.1045,
     "bdt": 86956012527731.86,
     "bhd": 350877339419.9282,
     "bmd": 930615321054.983,
     "brl": 4929376294096.146,
     "cad": 1198423145071.5803,
     "chf": 893901616024.0425,
     "clp": 863676161011496,
     "cny": 6235215712600.48,
     "czk": 22081640337992.6,
     "dkk": 6638100489237.55,
     "eur": 892266524904.9491,
     "gbp": 768782247338.8424,
     "hkd": 7301149015644.09,
     "huf": 359008976993004.44,
     "idr": 13956182329832868,
     "ils": 3258293627460.728,
     "inr": 73468828957974.53,
     "jpy": 126274779311277.1
     
   },
   "total_volume": {
     "btc": 3493926.6431466998,
     "eth": 62144995.92637224,
     "ltc": 1345588876.4289289,
     "bch": 649308647.6370265,
     "bnb": 305586999.40429246,
     "eos": 71611813118.47084,
     "xrp": 213847779741.19156,
     "xlm": 631676308070.4304,
     "link": 11023034143.63201,
     "dot": 9863817179.893946,
     "yfi": 11575916.97972824,
     "usd": 69191141278.61192,
     "aed": 254138370004.92856,
     "ars": 8715243919902.441,
     "aud": 100758907575.56554,
     "bdt": 6465169454775.792,
     "bhd": 26087689525.405247,
     "bmd": 69191141278.61192,
     "brl": 366498556238.68005,
     "cad": 89102621960.06444,
     "chf": 66461481564.02937,
     "clp": 64214222486441.21,
     "cny": 463587565680.8269,
     "czk": 1641767400258.901,
     "dkk": 493542002136.5861,
     "eur": 66339912728.802864,
     "gbp": 57158871001.40257
    
   },
   "market_cap_percentage": {
     "btc": 40.612640461613466,
     "eth": 14.295076010431554,
     "usdt": 7.1022067429569695,
     "usdc": 6.0064523096699185,
     "bnb": 3.972559096590199,
     "busd": 1.906379432165025,
     "xrp": 1.6843062673917324,
     "ada": 1.6575032750115182,
     "sol": 1.264941479637047,
     "doge": 0.9739034561024231
   },
   "market_cap_change_percentage_24h_usd": 3.31522387056629,
   "updated_at": 1656951667
 }
}
 
 
 */



struct GlobalData: Codable {
    let data: MarketDataModel?
}



struct MarketDataModel:Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    
    
    enum CodingKeys: String, CodingKey{
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    // we want to make sure we get the item value as USD
    
    var marketCap: String {
        if let item = totalMarketCap.first(where:{ (key, value) -> Bool in
            return key == "usd"
        }){
            return "$"+item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String{
        if let item = totalMarketCap.first(where:{ (key, value) -> Bool in
            return key == "usd"
        }){
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    
    var btcDominance: String{
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
        
        return ""
    }
    
}
