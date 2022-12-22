//
//  WWWLoginView.swift
//  AncestralWatch
//
//  Created by Jakob Hartman on 12/22/22.
//

import SwiftUI

struct WWWLoginView: View {
    
    @Binding var selection: String?
    
    var body: some View {
        SwiftUIWebView(url: "https://ident.familysearch.org/cis-web/oauth2/v3/authorization?client_secret=eBMhYpSHEfmvajjSlKdc6HdqYJDbxc5nzVJwqnVBNLfSeIUCpPl8t9Kl5HSZEf6cAiDONOAkQ73KAjAIksYAYu%2BgOSu7yrRtlew43t%2BGZZqOvuB9u8vaBXIKLPQJaNh33P2DSk0B4NuiWqAz2dLPTDAqXNHluNXfutkSG912odPWfXc2TRQC0hT5NDR%2Fzq0py%2FA7UYsW63MQe60npW%2BErHL8CqIKjXLIe1ji8DyF%2FE8u%2BTGj90i1WILaEpCqS%2FaYEJEDJ18ErcaGeEA8ifvdufTs6SzEPAHy%2BpzedXoT95SZAXr8Wziwk3Xdmj6R9rDcx4A34cTevMbHFysbCWPWfg%3D%3D&response_type=code&redirect_uri=https%3A%2F%2Fwww.familysearch.org%2Fauth%2Ffamilysearch%2Fcallback&state=%2F&client_id=3Z3L-Z4GK-J7ZS-YT3Z-Q4KY-YN66-ZX5K-176R", callback: {
            selection = nil
        })
    }
}

struct WWWLoginView_Previews: PreviewProvider {
    static var previews: some View {
        WWWLoginView(selection: .constant("C"))
    }
}
