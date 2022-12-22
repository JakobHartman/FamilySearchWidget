//
//  LDSLoginView.swift
//  AncestralWatch
//
//  Created by Jakob Hartman on 12/20/22.
//

import SwiftUI

struct LDSLoginView: View {
    
    @Binding var selection: String?
    
    var body: some View {
        NavigationView {
            SwiftUIWebView(url: "https://ident.familysearch.org/cis-web/oauth2/v3/oidc_sso?openid_provider_name=ChurchAccountOkta&redirect_uri=https%3A%2F%2Fwww.familysearch.org%2Fauth%2Ffamilysearch%2Fcallback&client_id=3Z3L-Z4GK-J7ZS-YT3Z-Q4KY-YN66-ZX5K-176R&state=%2F&ip_address=\(Utils.getIPAddress())&openid_provider_url=https://id.churchofjesuschrist.org/oauth2/default/v1/authorize", callback: {
                selection = nil;
            })
        }.padding()
    }
}

struct LDSLoginView_Previews: PreviewProvider {
    static var previews: some View {
        LDSLoginView(selection: .constant("A"))
    }
}
