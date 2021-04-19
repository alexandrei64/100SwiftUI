//
//  AddView.swift
//  iExpense
//
//  Created by Alex Andrei on 18.04.2021.
//

import SwiftUI

struct AddView: View {
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    static let types = ["Business", "Personal"]
    
    @State private var showingAlert = false

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                inputChecker()
            })
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Alert"), message: Text("Only numbers are accepted for amount"), dismissButton: .default(Text("Dismiss")))
        }
        .preferredColorScheme(.dark)
    }
    
    func inputChecker() {
        let digits = CharacterSet.decimalDigits
        
        if CharacterSet(charactersIn: amount).isSubset(of: digits) == false {
            showingAlert = true
        } else {
            if let actualAmount = Int(self.amount) {
                let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                self.expenses.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
