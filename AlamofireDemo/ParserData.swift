//
//  ParserData.swift
//  AlamofireDemo
//
//  Created by MTQ on 8/2/17.
//  Copyright © 2017 MTQ. All rights reserved.
//

import Foundation

class ParserData {
    func parseCourse(_ json: [Dictionary<String, Any>]) -> MyCourse? {
        var myCourse: MyCourse?
        for dict in json {
            guard let nameOfCourse = dict["course"] as? String else {
                return nil
            }
            guard let id = dict["id"] as? String else {
                return nil
            }
            let course = Course(name: nameOfCourse, id: id)
            if let _ = myCourse {
                myCourse!.courses.append(course)
            } else {
                myCourse = MyCourse(courses: [course])
            }
        }
        return myCourse ?? nil
    }
}
