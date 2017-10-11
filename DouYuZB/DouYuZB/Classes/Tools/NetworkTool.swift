//
//  NetworkTool.swift
//  DouYuZB
//
//  Created by YYW on 2017/10/11.
//  Copyright © 2017年 YYW. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType :String{
    case GET  = "GET"
    case POST = "POST"
}

class NetworkTool{
    class func requestData(type:MethodType,url:String,parameters:[String:NSString]? = nil,finishedCallBack:@escaping (_ result:AnyObject)->()) {
        var meType:HTTPMethod = HTTPMethod.get
        if type == .POST {
            meType = HTTPMethod.post
        }
        Alamofire.request(url, method: meType, parameters: parameters, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("进度: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // 自定义的校验闭包, 现在加上了 `data` 参数(允许你提前转换数据以便在必要时挖掘到错误信息)
                
                return .success
            }
            .responseJSON { response in
//                debugPrint(response)
                finishedCallBack(response.result.value as AnyObject)
        }
    }
}
