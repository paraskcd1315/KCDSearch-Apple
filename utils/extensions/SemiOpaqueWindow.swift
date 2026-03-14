//
//  SemiOpaqueWindow.swift
//  kcdsearch
//
//  Created by ParasKCD on 14/3/26.
//

import SwiftUI

#if os(macOS)
extension View {
    public static func semiOpaqueWindow() -> some View {
        VisualEffect().ignoresSafeArea()
    }
}

struct VisualEffect : NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let view = NSVisualEffectView()
        view.state = .active
        return view
    }
    func updateNSView(_ view: NSView, context: Context) { }
}
#endif
