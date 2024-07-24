// TokenGroups.swift
// Copyright (c) 2024 Party Labs, Inc

import Foundation

/// Users/joeblau/Library/Messages/Attachments/9a/10/4861A32B-169C-4AEC-980C-567941966BD8/IMG_6258.mov
//  TokenData.swift
//  TokensNotDapps
//
//  Created by Joe Blau on 5/30/24.
//

import Foundation

let TOKEN_BUNDLES: [TokenBundle] = [
    TokenBundle(tokensIn: [ethereumToken], tokensOut: [usdlToken], actions: [.borrow, .repay]),

    TokenBundle(tokensIn: [fenixToken], tokensOut: [fenixYieldToken], actions: [.depositStake, .end]),

    TokenBundle(tokensIn: [dxnToken], tokensOut: [dxnYieldToken, ethereumYieldToken], actions: [.depositStake, .collect, .end]),

    TokenBundle(tokensIn: [shibToken, ethereumToken], actions: [.farm, .addLiquidity, .removeLiquidity]),

    TokenBundle(tokensIn: [degenToken, ethereumToken], tokensOut: [aerodromeToken], actions: [.addLiquidity, .removeLiquidity, .collect, .end]),

    TokenBundle(tokensIn: [maxiToken, baseToken, trioToken, luckyToken, deciToken], actions: [.addLiquidity, .removeLiquidity, .collect]),

    TokenBundle(tokensIn: [purpleToken], actions: purpleToken.actions),
    TokenBundle(tokensIn: [boredApeToken, mutantApeToken], tokensOut: [apeToken], actions: [.collect]),
    TokenBundle(tokensIn: [xenToken], actions: xenToken.actions),
    TokenBundle(tokensIn: [degenToken, ethereumToken], actions: [.farm, .addLiquidity, .removeLiquidity, .collect]),
    TokenBundle(tokensIn: [daiToken, usdcToken, usdtToken], actions: [.addLiquidity, .removeLiquidity, .collect]),
    TokenBundle(tokensIn: [ethereumToken], tokensOut: [usdlToken], actions: [.borrow, .repay]),
    TokenBundle(tokensIn: [degenToken], actions: degenToken.actions),
    TokenBundle(tokensIn: [liquityToken], actions: liquityToken.actions),
    TokenBundle(tokensIn: [daiToken], actions: daiToken.actions),
    TokenBundle(tokensIn: [compoundToken], actions: compoundToken.actions),
    TokenBundle(tokensIn: [apeToken], actions: apeToken.actions),
    TokenBundle(tokensIn: [curveToken], actions: curveToken.actions),
    TokenBundle(tokensIn: [dydxToken], actions: dydxToken.actions),
    TokenBundle(tokensIn: [usdcToken], actions: usdcToken.actions),
    TokenBundle(tokensIn: [ethereumToken], actions: ethereumToken.actions),
]
//    .sorted { first, second in
//    first.balance.fiat > second.balance.fiat
// }

let ethereumToken = Token(address: "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
                          name: "Ethereum",
                          symbol: "ETH",
                          actions: [.send, .swap, .depositStake, .burn, .depositLoan, .borrow],
                          balance: Balance(value: 3.08, fiat: 11558.52))

let ethereumYieldToken = Token(address: "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
                               name: "Ethereum",
                               symbol: "ETH",
                               actions: [.send, .swap, .depositStake, .burn, .depositLoan, .borrow],
                               balance: Balance(value: 0.23, fiat: 875.88))

let xenToken = Token(address: "0x06450dEe7FD2Fb8E39061434BAbCFC05599a6Fb8",
                     name: "XEN",
                     symbol: "XEN",
                     actions: [.send, .swap, .mine, .depositStake, .burn, .depositLoan, .borrow],
                     balance: Balance(value: 26_824_534_982.94, fiat: 5144.94))

let degenToken = Token(address: "0xEb54dACB4C2ccb64F8074eceEa33b5eBb38E5387",
                       chainId: 8453,
                       name: "DEGEN",
                       symbol: "DEGEN",
                       actions: [.send, .swap, .depositLoan, .borrow],
                       balance: Balance(value: 266_703.94, fiat: 4107.24))

let liquityToken = Token(address: "0x6DEA81C8171D0bA574754EF6F8b412F2Ed88c54D",
                         name: "Liquity",
                         symbol: "LQTY",
                         actions: [.send, .swap, .depositLoan, .borrow],
                         balance: Balance(value: 1242, fiat: 1401.54))

let usdlToken = Token(address: "0x5f98805A4E8be255a32880FDeC7F6728C6568bA0",
                      name: "LUSD Stablecoin",
                      symbol: "LUSD",
                      actions: [.send, .swap, .depositLoan, .borrow],
                      balance: Balance(value: 4421.54, fiat: 4421.54))

let daiToken = Token(address: "0x6B175474E89094C44Da98b954EedeAC495271d0F",
                     name: "DaiStablecoin",
                     symbol: "DAI",
                     actions: [.send, .swap, .depositLoan, .borrow],
                     balance: Balance(value: 649.12, fiat: 649.12))

let compoundToken = Token(address: "0xc00e94Cb662C3520282E6f5717214004A7f26888",
                          name: "Compound",
                          symbol: "COMP",
                          actions: [.send, .swap, .depositLoan, .borrow],
                          balance: Balance(value: 42, fiat: 2482.04))

let apeToken = Token(address: "0x4d224452801ACEd8B2F0aebE155379bb5D594381",
                     name: "ApeCoin",
                     symbol: "APE",
                     actions: [.send, .swap],
                     balance: Balance(value: 991, fiat: 1252.47))

let curveToken = Token(address: "0xD533a949740bb3306d119CC777fa900bA034cd52",
                       name: "CurveDAOToken",
                       symbol: "CRV",
                       actions: [.send, .swap],
                       balance: Balance(value: 420, fiat: 195.99))

let dydxToken = Token(address: "0x92D6C1e31e14520e676a687F0a93788B716BEff5",
                      name: "dYdX",
                      symbol: "DYDX",
                      actions: [.send, .swap],
                      balance: Balance(value: 69, fiat: 130.04))

let fenixToken = Token(address: "0xC3e8abfA04B0EC442c2A4D65699a40F7FcEd8055",
                       name: "FENIX",
                       symbol: "FENIX",
                       actions: [.send, .swap, .end],
                       balance: Balance(value: 526_013.65, fiat: 809.53))

let fenixYieldToken = Token(address: "0xC3e8abfA04B0EC442c2A4D65699a40F7FcEd8055",
                            name: "FENIX",
                            symbol: "FENIX",
                            actions: [.send, .swap, .end],
                            balance: Balance(value: 1_578_040.97, fiat: 2428.61))

let usdcToken = Token(address: "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48",
                      name: "USDC",
                      symbol: "USDC",
                      actions: [.send, .swap, .depositLoan, .borrow, .depositStake],
                      balance: Balance(value: 280.64, fiat: 280.73))

let dxnToken = Token(address: "0x80f0C1c49891dcFDD40b6e0F960F84E6042bcB6F",
                     name: "DBXen Token",
                     symbol: "DXN",
                     actions: [.addLiquidity, .collect, .end],
                     balance: Balance(value: 103_424, fiat: 15969.4))

let dxnYieldToken = Token(address: "0x80f0C1c49891dcFDD40b6e0F960F84E6042bcB6F",
                          name: "DBXen Token",
                          symbol: "DXN",
                          actions: [.addLiquidity, .collect, .end],
                          balance: Balance(value: 8273.92, fiat: 1276.75))

let usdtToken = Token(address: "0xdAC17F958D2ee523a2206206994597C13D831ec7",
                      name: "Tether USD",
                      symbol: "USDT",
                      actions: [.send, .swap, .depositLoan, .borrow, .depositStake],
                      balance: Balance(value: 280.64, fiat: 280.73))

let aerodromeToken = Token(address: "0x940181a94A35A4569E4529A3CDfB74e38FD98631",
                           name: "Aerodrome",
                           symbol: "AERO",
                           actions: [.send, .swap, .depositLoan, .borrow, .depositStake],
                           balance: Balance(value: 280.64, fiat: 280.73))

let boredApeToken = Token(erc: .erc721,
                          address: "0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D",
                          name: "BoredApeYachtClub",
                          symbol: "BAYC",
                          actions: [.send, .swap, .depositLoan, .borrow, .depositStake, .vote],
                          balance: Balance(value: 1, fiat: 69420.00))

let mutantApeToken = Token(erc: .erc721,
                           address: "0x60E4d786628Fea6478F785A6d7e704777c86a7c6",
                           name: "MutantApeYachtClub",
                           symbol: "MAYC",
                           actions: [.send, .swap, .depositLoan, .borrow, .depositStake, .vote],
                           balance: Balance(value: 1, fiat: 6942.00))

let purpleToken = Token(erc: .erc721,
                        address: "0xa45662638E9f3bbb7A6FeCb4B17853B7ba0F3a60",
                        name: "Purple",
                        symbol: "PRPL",
                        actions: [.send, .swap, .vote],
                        balance: Balance(value: 4, fiat: 15399.07))

let maxiToken = Token(address: "0x0d86EB9f43C57f6FF3BC9E23D8F9d82503f0e84b",
                      name: "Maximums",
                      symbol: "MAXI",
                      actions: [.send, .swap],
                      balance: Balance(value: 168_591.68, fiat: 1275.01))

let baseToken = Token(address: "0xe9f84d418B008888A992Ff8c6D22389C2C3504e0",
                      name: "Maximus Base",
                      symbol: "BASE",
                      actions: [.send, .swap],
                      balance: Balance(value: 39059.91, fiat: 281.79))

let trioToken = Token(address: "0xF55cD1e399e1cc3D95303048897a680be3313308",
                      name: "Maximus Trio",
                      symbol: "TRIO",
                      actions: [.send, .swap],
                      balance: Balance(value: 39129.28, fiat: 316.44))

let luckyToken = Token(address: "0x6B0956258fF7bd7645aa35369B55B61b8e6d6140",
                       name: "Maximus Lucky",
                       symbol: "LUCKY",
                       actions: [.send, .swap],
                       balance: Balance(value: 62045.45, fiat: 376.33))

let deciToken = Token(address: "0x6b32022693210cD2Cfc466b9Ac0085DE8fC34eA6",
                      name: "Maximus Decimus",
                      symbol: "DECI",
                      actions: [.send, .swap],
                      balance: Balance(value: 201_451.53, fiat: 1174.52))

let shibToken = Token(address: "0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE",
                      name: "Shiba Inu",
                      symbol: "SHIB",
                      actions: [.send, .swap],
                      balance: Balance(value: 102_415_352, fiat: 2354.21))
