//
//  Currencies.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 20.02.25.
//

import Foundation
import SwiftData

enum Currency: String, CaseIterable, Codable {
    case inch = "1inch"
    case aave = "Aave"
    case ada = "Cardano"
    case aed = "Emirati Dirham"
    case afn = "Afghan Afghani"
    case agix = "SingularityNET"
    case akt = "Akash Network"
    case algo = "Algorand"
    case all = "Albanian Lek"
    case amd = "Armenian Dram"
    case amp = "Amp"
    case ang = "Dutch Guilder"
    case aoa = "Angolan Kwanza"
    case ape = "ApeCoin"
    case apt = "Aptos"
    case ar = "Arweave"
    case arb = "Arbitrum"
    case ars = "Argentine Peso"
    case atom = "Cosmos"
    case ats = "Austrian Schilling"
    case aud = "Australian Dollar"
    case avax = "Avalanche"
    case awg = "Aruban or Dutch Guilder"
    case axs = "Axie Infinity"
    case azm = "Azerbaijani Manat"
    case azn = "Azerbaijan Manat"
    case bake = "BakeryToken"
    case bam = "Bosnian Convertible Mark"
    case bat = "Basic Attention Token"
    case bbd = "Barbadian or Bajan Dollar"
    case bch = "Bitcoin Cash"
    case bdt = "Bangladeshi Taka"
    case bef = "Belgian Franc"
    case bgn = "Bulgarian Lev"
    case bhd = "Bahraini Dinar"
    case bif = "Burundian Franc"
    case bmd = "Bermudian Dollar"
    case bnb = "Binance Coin"
    case bnd = "Bruneian Dollar"
    case bob = "Bolivian Bolíviano"
    case brl = "Brazilian Real"
    case bsd = "Bahamian Dollar"
    case bsv = "Bitcoin SV"
    case bsw = "Biswap"
    case btc = "Bitcoin"
    case btcb = "Bitcoin BEP2"
    case btg = "Bitcoin Gold"
    case btn = "Bhutanese Ngultrum"
    case btt = "BitTorrent"
    case busd = "Binance USD"
    case bwp = "Botswana Pula"
    //case byn = "Belarusian Ruble"
    case byr = "Belarusian Ruble"
    case bzd = "Belizean Dollar"
    case cad = "Canadian Dollar"
    case cake = "PancakeSwap"
    case cdf = "Congolese Franc"
    case celo = "Celo"
    case cfx = "Conflux"
    case chf = "Swiss Franc"
    case chz = "Chiliz"
    case clp = "Chilean Peso"
    case cnh = "Chinese Yuan Renminbi Offshore"
    case cny = "Chinese Yuan Renminbi"
    case comp = "Compound"
    case cop = "Colombian Peso"
    case crc = "Costa Rican Colon"
    case cro = "Crypto.com Chain"
    case crv = "Curve DAO Token"
    case cspr = "Casper"
    case cuc = "Cuban Convertible Peso"
    case cup = "Cuban Peso"
    case cve = "Cape Verdean Escudo"
    case cvx = "Convex Finance"
    case cyp = "Cypriot Pound"
    case czk = "Czech Koruna"
    case dai = "DAI"
    case dash = "Digital Cash"
    case dcr = "Decred"
    case dem = "German Deutsche Mark"
    case dfi = "DfiStarter"
    case djf = "Djiboutian Franc"
    case dkk = "Danish Krone"
    case doge = "Dogecoin"
    case dop = "Dominican Peso"
    case dot = "Polkadot"
    case dydx = "dYdX"
    case dzd = "Algerian Dinar"
    case eek = "Estonian Kroon"
    case egld = "Elrond"
    case egp = "Egyptian Pound"
    case enj = "Enjin Coin"
    case eos = "EOS"
    case ern = "Eritrean Nakfa"
    case esp = "Spanish Peseta"
    case etb = "Ethiopian Birr"
    case etc = "Ethereum Classic"
    case eth = "Ethereum"
    case eur = "Euro"
    case fei = "Fei USD"
    case fil = "Filecoin"
    case fim = "Finnish Markka"
    case fjd = "Fijian Dollar"
    case fkp = "Falkland Island Pound"
    case flow = "Flow"
    case flr = "FLARE"
    case frax = "Frax"
    case frf = "French Franc"
    case ftt = "FarmaTrust"
    case fxs = "Frax Share"
    case gala = "Gala"
    case gbp = "British Pound"
    case gel = "Georgian Lari"
    case ggp = "Guernsey Pound"
    case ghc = "Ghanaian Cedi"
//    case ghs = "Ghanaian Cedi"
    case gip = "Gibraltar Pound"
    case gmd = "Gambian Dalasi"
    case gmx = "Goldmaxcoin"
    case gnf = "Guinean Franc"
    case gno = "Gnosis"
    case grd = "Greek Drachma"
    case grt = "The Graph"
    case gt = "GateToken"
    case gtq = "Guatemalan Quetzal"
    case gusd = "Gemini US Dollar"
    case gyd = "Guyanese Dollar"
    case hbar = "Hedera"
    case hkd = "Hong Kong Dollar"
    case hnl = "Honduran Lempira"
    case hnt = "Helium"
    case hot = "Hydro Protocol"
    case hrk = "Croatian Kuna"
    case ht = "Huobi Token"
    case htg = "Haitian Gourde"
    case huf = "Hungarian Forint"
    case icp = "Internet Computer"
    case idr = "Indonesian Rupiah"
    case iep = "Irish Pound"
    case ils = "Israeli Shekel"
    case imp = "Isle of Man Pound"
    case imx = "Immutable X"
    case inj = "Injective"
    case inr = "Indian Rupee"
    case iqd = "Iraqi Dinar"
    case irr = "Iranian Rial"
    case isk = "Icelandic Krona"
    case itl = "Italian Lira"
    case jep = "Jersey Pound"
    case jmd = "Jamaican Dollar"
    case jod = "Jordanian Dinar"
    case jpy = "Japanese Yen"
    case kas = "Kaspa"
    case kava = "Kava"
    case kcs = "Kucoin"
    case kda = "Kadena"
    case kes = "Kenyan Shilling"
    case kgs = "Kyrgyzstani Som"
    case khr = "Cambodian Riel"
    case klay = "Klaytn"
    case kmf = "Comorian Franc"
    case knc = "Kyber Network Crystals"
    case kpw = "North Korean Won"
    case krw = "South Korean Won"
    case ksm = "Kusama"
    case kwd = "Kuwaiti Dinar"
    case kyd = "Caymanian Dollar"
    case kzt = "Kazakhstani Tenge"
    case lak = "Lao Kip"
    case lbp = "Lebanese Pound"
    case ldo = "Lido DAO Token"
    case leo = "LEOcoin"
    case link = "Chainlink"
    case lkr = "Sri Lankan Rupee"
    case lrc = "Loopring"
    case lrd = "Liberian Dollar"
    case lsl = "Basotho Loti"
    case ltc = "Litecoin"
    case ltl = "Lithuanian Litas"
    case luf = "Luxembourg Franc"
    case luna = "Terra"
    case lunc = "Terra Classic"
    case lvl = "Latvian Lat"
    case lyd = "Libyan Dinar"
    case mad = "Moroccan Dirham"
    case mana = "Mana Coin Decentraland"
    case matic = "Polygon"
    case mbx = "MobieCoin"
    case mdl = "Moldovan Leu"
    case mga = "Malagasy Ariary"
    case mgf = "Malagasy Franc"
    case mina = "Mina"
    case mkd = "Macedonian Denar"
    case mkr = "Maker"
    case mmk = "Burmese Kyat"
    case mnt = "Mongolian Tughrik"
    case mop = "Macau Pataca"
    case mro = "Mauritanian Ouguiya"
//    case mru = "Mauritanian Ouguiya"
    case mtl = "Maltese Lira"
    case mur = "Mauritian Rupee"
    case mvr = "Maldivian Rufiyaa"
    case mwk = "Malawian Kwacha"
    case mxn = "Mexican Peso"
    case mxv = "Unidad De Inversion"
    case myr = "Malaysian Ringgit"
    case mzm = "Mozambican Metical"
//    case mzn = "Mozambican Metical"
    case nad = "Namibian Dollar"
    case near = "NEAR Protocol"
    case neo = "NEO"
    case nexo = "NEXO"
    case nft = "NFT"
    case ngn = "Nigerian Naira"
    case nio = "Nicaraguan Cordoba"
//    case nlg = "Dutch Guilder"
    case nok = "Norwegian Krone"
    case npr = "Nepalese Rupee"
    case nzd = "New Zealand Dollar"
    case okb = "Okex"
    case omr = "Omani Rial"
    case one = "Menlo One"
    case op = "Optimism"
    case ordi = "Ordi"
    case pab = "Panamanian Balboa"
    case paxg = "PAX Gold"
    case pen = "Peruvian Sol"
    case pepe = "Pepe"
    case pgk = "Papua New Guinean Kina"
    case php = "Philippine Peso"
    case pkr = "Pakistani Rupee"
    case pln = "Polish Zloty"
    case pte = "Portuguese Escudo"
    case pyg = "Paraguayan Guarani"
    case qar = "Qatari Riyal"
    case qnt = "Quant"
    case qtum = "QTUM"
    case rol = "Romanian Leu"
//    case ron = "Romanian Leu"
    case rpl = "Rocket Pool"
    case rsd = "Serbian Dinar"
    case rub = "Russian Ruble"
    case rune = "THORChain (ERC20)"
    case rvn = "Ravencoin"
    case rwf = "Rwandan Franc"
    case sand = "The Sandbox"
    case sar = "Saudi Arabian Riyal"
    case sbd = "Solomon Islander Dollar"
    case scr = "Seychellois Rupee"
    case sdd = "Sudanese Dinar"
    case sdg = "Sudanese Pound"
    case sek = "Swedish Krona"
    case sgd = "Singapore Dollar"
    case shib = "Shiba Inu"
    case shp = "Saint Helenian Pound"
    case sit = "Slovenian Tolar"
    case skk = "Slovak Koruna"
    case sle = "Sierra Leonean Leone"
//    case sll = "Sierra Leonean Leone"
    case snx = "Synthetix Network"
    case sol = "Solana"
    case sos = "Somali Shilling"
    case spl = "Seborgan Luigino"
    case srd = "Surinamese Dollar"
    case srg = "Surinamese Guilder"
    case std = "Sao Tomean Dobra"
//    case stn = "Sao Tomean Dobra"
    case stx = "Stacks"
    case sui = "Sui"
    case svc = "Salvadoran Colon"
    case syp = "Syrian Pound"
    case szl = "Swazi Lilangeni"
    case thb = "Thai Baht"
    case theta = "Theta"
    case tjs = "Tajikistani Somoni"
    case tmm = "Turkmenistani Manat"
//    case tmt = "Turkmenistani Manat"
    case tnd = "Tunisian Dinar"
    case ton = "Tokamak Network"
    case top = "Tongan Pa'anga"
    case trl = "Turkish Lira"
    case trx = "TRON"
//    case `try` = "Turkish Lira"
    case ttd = "Trinidadian Dollar"
    case tusd = "True USD"
    case tvd = "Tuvaluan Dollar"
    case twd = "Taiwan New Dollar"
    case twt = "Trust Wallet Token"
    case tzs = "Tanzanian Shilling"
    case uah = "Ukrainian Hryvnia"
    case ugx = "Ugandan Shilling"
    case uni = "Uniswap"
    case usd = "US Dollar"
    case usdc = "USDC"
    case usdd = "Decentralized USD"
    case usdp = "USDP Stablecoin"
    case usdt = "Tether"
    case uyu = "Uruguayan Peso"
    case uzs = "Uzbekistani Som"
    case val = "Vatican City Lira"
    case veb = "Venezuelan Bolívar"
//    case ved = ""
//    case vef = "Venezuelan Bolívar"
//    case ves = "Venezuelan Bolívar"
    case vet = "Vechain"
    case vnd = "Vietnamese Dong"
    case vuv = "Ni-Vanuatu Vatu"
    case waves = "Waves"
    case wemix = "WEMIX"
    case woo = "WOO Network"
    case wst = "Samoan Tala"
    case xaf = "Central African CFA Franc BEAC"
    case xag = "Silver Ounce"
    case xau = "Gold Ounce"
    case xaut = "Tether Gold"
//    case xbt = ""
    case xcd = "East Caribbean Dollar"
    case xch = "Chia"
    case xdc = "XDC Network"
    case xdr = "IMF Special Drawing Rights"
    case xec = "Eternal Coin"
    case xem = "NEM"
    case xlm = "Stellar Lumen"
    case xmr = "Monero"
    case xof = "CFA Franc"
    case xpd = "Palladium Ounce"
    case xpf = "CFP Franc"
    case xpt = "Platinum Ounce"
    case xrp = "Ripple"
    case xtz = "Tezos"
    case yer = "Yemeni Rial"
    case zar = "South African Rand"
    case zec = "ZCash"
    case zil = "Zilliqa"
    case zmk = "Zambian Kwacha"
//    case zmw = "Zambian Kwacha"
    case zwd = "Zimbabwean Dollar"
//    case zwg = ""
//    case zwl = "Zimbabwean Dollar"

    
    static func from(rawValue: String) -> Currency? {
        return self.allCases.first { $0.rawValue.lowercased() == rawValue.lowercased() }
    }
}

@Model
class FavoriteCurrency {
    var name: Currency
    var favorited: Bool
    var startCurrency: Bool
    var rawName: String
    
    init(name: Currency, favorited: Bool = false, startCurrency: Bool = false) {
        self.name = name
        self.favorited = favorited
        self.startCurrency = startCurrency
        self.rawName = name.rawValue
    }
}

extension FavoriteCurrency {
    static var allCurrencies: [FavoriteCurrency] {
        var allCurr = [FavoriteCurrency]()
        Currency.allCases.forEach { currency in
            var fav: FavoriteCurrency
            if currency.rawValue == "Euro" {
                fav = FavoriteCurrency.init(name: currency, startCurrency: true)
            } else {
                fav = FavoriteCurrency.init(name: currency)
            }
            allCurr.append(fav)
        }
        return allCurr
    }
}

// Model for decoding the API response
struct ExchangeRatesResponse: Codable {
    let date: String
    let rates: [String: [String: Double]]  // Dictionary for dynamic keys

    enum CodingKeys: String, CodingKey {
        case date
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(String.self, forKey: .date)

        // Capture the dynamic exchange rate key (e.g., "eur", "usd")
        let allKeys = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var ratesDictionary = [String: [String: Double]]()

        for key in allKeys.allKeys where key.stringValue != "date" {
            let value = try allKeys.decode([String: Double].self, forKey: key)
            ratesDictionary[key.stringValue] = value
        }
        self.rates = ratesDictionary
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) { self.stringValue = stringValue }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
}

func getFullCurrencyName(from currency: String) -> String {
    Currency.allCases.first { String(describing: $0) == currency }?.rawValue
        ?? currency.localizedCapitalized
}

// Custom CodingKeys to handle dynamic JSON keys
//struct DynamicCodingKeys: CodingKey {
//    var stringValue: String
//    init?(stringValue: String) { self.stringValue = stringValue }
//    var intValue: Int? { return nil }
//    init?(intValue: Int) { return nil }
//}
