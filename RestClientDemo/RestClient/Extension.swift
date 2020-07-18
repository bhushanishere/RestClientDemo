//
//  Extension.swift
//
//  Created by Bhushan  Borse on 24/06/20.
//  Copyright © 2020 Bhushan  Borse. All rights reserved.
//

import Foundation

enum RegistrationError: Error {
    case noContentError             // 204
    case badRequestError            // 400
    case unauthorizedError          // 401
    case paymentRequiredError       // 402
    case forbiddenError             // 403
    case notFoundError              // 404
    case internalServerError        // 500
    case badGatewayError            // 502
    case serviceUnavailableError    // 503
    case gatewayTimeoutError        // 504
    case unsuppotedURLError         // -1003
    case unknownError
}

/// Get the error object and filter by error code and return the error message
func passErrorCode(andReturn error : NSError) -> Error {
    let errorCode = error.code
    switch errorCode {
    case 204:
        return RegistrationError.noContentError
    case 400:
        return RegistrationError.badRequestError
    case 401:
        return RegistrationError.unauthorizedError
    case 402:
        return RegistrationError.paymentRequiredError
    case 403:
        return RegistrationError.forbiddenError
    case 404:
        return RegistrationError.notFoundError
    case 500:
        return RegistrationError.internalServerError
    case 502:
        return RegistrationError.badGatewayError
    case 503:
        return RegistrationError.serviceUnavailableError
    case 504:
        return RegistrationError.gatewayTimeoutError
    case -1003:
        return RegistrationError.unsuppotedURLError
    default:
        return RegistrationError.unknownError
    }
}

/// Set the error message as per error type...sssss
extension RegistrationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noContentError:
            return NSLocalizedString("The server successfully processed the request and is not returning any content.", comment: "No Content")
        case .badRequestError:
            return NSLocalizedString("The server cannot or will not process the request due to an apparent client error.", comment: "Bad Request")
        case .unauthorizedError:
            return NSLocalizedString("Description of unauthorized", comment: "Unauthorized")
        case .paymentRequiredError:
            return NSLocalizedString("Description of payment required", comment: "Payment Required")
        case .forbiddenError:
            return NSLocalizedString("Description of forbidden", comment: "Forbidden")
        case .notFoundError:
            return NSLocalizedString("Description of Not found", comment: "Not Found")
        case .internalServerError:
            return NSLocalizedString("Description of internal server", comment: "Internal Server")
        case .badGatewayError:
            return NSLocalizedString("Description of bad gateway", comment: "Bad Gateway")
        case .serviceUnavailableError:
            return NSLocalizedString("Description of service unavailable", comment: "Service Unavailable")
        case .gatewayTimeoutError:
            return NSLocalizedString("Description of gateway timeout", comment: "Gateway Timeout")
        case .unsuppotedURLError:
            return NSLocalizedString("Description of unsuppoted URL", comment: "Unsuppoted URL")
        case .unknownError:
            return NSLocalizedString("Description of unknown error", comment: "Unknown Error")
        }
    }
    
    /// Here how you use this...
   /*
     let error: Error = RegistrationError.invalidEmail
     print(error.localizedDescription)
     */
}

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: self)
    }
}


class RestClientMessages : NSObject {
    static let kErrorDomain = "com.Domain.name"
    static let kOfflineMsg = "Offline, please check your connection"
    static let noAuth = "Session Expired. Please login again!"
    static let kMsgString = "message"
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
