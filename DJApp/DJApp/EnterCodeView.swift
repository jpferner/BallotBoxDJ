//
//  EnterCodeView.swift
//  DJApp
//
//  Created by user206471 on 12/2/21.
//

import SwiftUI

struct EnterCodeView: View {
    //    enum Field: Hashable {
    //        case char1
    //        case char2
    //        case char3
    //        case char4
    //        case char5
    //        case char6
    //    }
    @State private var focus: Int = 0
    //    @State private var code: String = ""
    @State private var chars: [Character?] = [nil, nil, nil, nil, nil, nil]
    //    @FocusState private var focused: Field?
    var body: some View {
        VStack {
            Text("Enter Room Code")
            HStack {
                ForEach(0..<6) { index in
                    CodeCharView(char: chars[index], focused: focus == index) { newChar in
                        chars[index] = newChar
                        if focus < chars.count - 1 {
                            focus += 1
                        }
                    } onClear: {
                        chars[index] = nil
                    } onBackspace: {
                        if focus > 0 {
                            focus -= 1
                            chars[focus] = nil
                        }
                        
                    } onFocus: {
                        focus = index
                        
                    }
                    
                }
            }
            
            Button(action: {
                
            }) {
                Text("Join")
            }
        }
    }
}

struct CodeCharView: View {
    
    //    @State private var char: String = ""
    var char: Character?
    var focused: Bool
    var onChange: (Character?) -> ()
    var onClear: () -> ()
    var onBackspace: () -> ()
    var onFocus: () -> ()
    
    
    //    @FocusState private var hasFocused: Bool
    
    var body: some View {
        VStack {
            CharTextField(char: char, focused: focused) {newValue in
                onChange(newValue)
            }onClear: {
                onClear()
            } onBackspace: {
                onBackspace()
            } onFocus: {
                onFocus()
            }
            
        }
        .frame(width: 48, height: 80)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 3))
        //        .onChange(of: char) { newValue in
        //            if newValue.count > 0 {
        //                char = String(newValue.last!.uppercased())
        //            }
        //            onChange(newValue.last)
        //
        //        }
        //        .onChange(of: focused) { newValue in
        //            hasFocused = newValue
        //        }
        //        .onChange(of: hasFocused) { newValue in
        //            onFocus(newValue)
        //        }
        ////        .focusable(<#T##Bool#>)
        //    }
        //
    }
}

struct CharTextField: UIViewRepresentable {
    typealias Context = UIViewRepresentableContext<Self>
    typealias UIViewType = BackspaceTextField
    
    final class Coordinator: NSObject, UITextFieldDelegate,
                             BackspaceTextFieldDelegate {
        let parent: CharTextField
        
        init(parent: CharTextField) {
            self.parent = parent
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if !parent.focused {
                DispatchQueue.main.async {
                    self.parent.onFocus()
                }
            }
        }
        func backspacePressed(_ textField: BackspaceTextField) {
            if ((textField.text ?? "").count > 0) {
                parent.onClear();
            } else {
                parent.onBackspace()
            }
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let char = string.cString(using: .utf8)
            let isBackspace = strcmp(char, "\\b") == -92
            
            if isBackspace {
                parent.onClear()
            } else {
                let newValue = string.uppercased().last!
                if CharacterSet(charactersIn: String(newValue)).isSubset(of: .alphanumerics) {
                    parent.onNewValue(string.uppercased().last!)
                }
            }
            return false
        }
    }
    
    let char: Character?
    let focused: Bool
    let onNewValue: (Character) -> ()
    let onClear: () -> ()
    let onBackspace: () -> ()
    let onFocus: () -> ()
    
    func makeUIView(context: Context) -> BackspaceTextField {
        let textField = BackspaceTextField()
        textField.text = char != nil ? String(char!) : nil
        textField.textAlignment = .center
        textField.font = .systemFont(ofSize: 30)
        textField.delegate = context.coordinator
        textField.backspaceDelegate = context.coordinator
        return textField
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
        
    }
    
    func updateUIView(_ uiView: BackspaceTextField, context: Context) {
        uiView.text = char != nil ? String(char!) : nil
        if !uiView.isFirstResponder && focused {
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
        }
    }
}

protocol BackspaceTextFieldDelegate: AnyObject {
    func backspacePressed(_ textField: BackspaceTextField)
}

class BackspaceTextField: UITextField {
    weak var backspaceDelegate: BackspaceTextFieldDelegate?
    
    override func deleteBackward() {
        backspaceDelegate?.backspacePressed(self)
    }
}

struct EnterCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterCodeView()
    }
}

