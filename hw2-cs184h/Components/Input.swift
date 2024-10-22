//
//  Input.swift
//  hw2-cs184h
//
//  Created by Nevin Manimaran on 10/22/24.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    var body: some View {
        VStack(alignment: .leading, spacing:12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}
