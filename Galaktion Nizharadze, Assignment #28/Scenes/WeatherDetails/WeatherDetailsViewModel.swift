//
//  WeatherDetailsViewModel.swift
//  Galaktion Nizharadze, Assignment #28
//
//  Created by Gaga Nizharadze on 30.08.22.
//

import Foundation
import UIKit

class WeatherDetailsViewModel {
    
    func generatePricesLabels(fontSize: CGFloat, isBold: Bool, textColor: UIColor?, text: String?, textAlignment: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.textAlignment = textAlignment
        if let text = text {
            label.text = text
        }
        if isBold {
            label.font = .boldSystemFont(ofSize: fontSize)
            
        } else {
            label.font = .systemFont(ofSize: fontSize)
        }
         
        return label
    }
    
    func changeIconIfNeeds(weatherState: String) -> String? {
        if let enumCase = WeatherIndicatorImage(rawValue: weatherState) {
            return enumCase.value
        }
        return nil
    }
    
}
