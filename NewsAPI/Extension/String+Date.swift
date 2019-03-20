//
//  String+Date.swift
//
//  Created by Tushar  Jadhav on 2019-03-04.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import UIKit

extension String {
    
    private func getDateFormatter(hasRelativeDate: Bool = false, dateFormat: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = hasRelativeDate

        if let dateFormat = dateFormat
        {
            formatter.dateFormat = dateFormat
        }
        else {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        return formatter
    }

    func getCurrentDate() -> String
    {
        let currentDateTime = Date()
        let dateFormatter = getDateFormatter()
        let result:String = dateFormatterToString(dateFormatter,currentDateTime)
        
        return result
    }
    
    func getEalierDate(days: Int) -> String
    {
        let dateFormatter = getDateFormatter()
        
        guard let toDate = dateFormatter.date(from: self) else {
            return self
        }
        
        let resultDate = Calendar.current.date(byAdding: .day, value: -days, to: toDate)
        
        if let resultDate = resultDate {
            return dateFormatterToString(dateFormatter,resultDate)
        }
        return self
    }
    
    func getNewsPostDate() -> String  {
        
        let formatter = getDateFormatter()
        guard let date = formatter.date(from: self) else {
            return ""
        }
        
        let dateFormatter = getDateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let result:String = dateFormatterToString(dateFormatter,date)        //Set timestyle and date style to compare date
        return result
    }
    
    
    func getDateObject() -> Date? {
        
        let dateFormatter = getDateFormatter()
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
    
    func dateFormatterToString(_ formatter: DateFormatter, _ date: Date) -> String {
        return formatter.string(from: date)
    }

    

}
