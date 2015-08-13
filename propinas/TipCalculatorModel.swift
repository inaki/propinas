//
//  TipCalculatorModel.swift
//  propinas
//
//  Created by Imanol Aranzadi on 8/13/15.
//  Copyright (c) 2015 Imanol Aranzadi. All rights reserved.
//

import Foundation


class TipCalculatorModel {
    
    var total: Double
    
    init(total: Double) {
        self.total = total
    }
    
    func calcTipWithTipPct(tipPct: Double) -> Double {
        return total * tipPct
    }
    
    func returnPossibleTips() -> [Int: Double] {
        
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        
        var retval = [Int: Double]()
        for possibleTip in possibleTipsInferred {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPct(possibleTip)
        }
        return retval
        
    }
    
}