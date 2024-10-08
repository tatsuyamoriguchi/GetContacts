//
//  ContentView.swift
//  GetContacts
//
//  Created by Tatsuya Moriguchi on 10/8/24.
//

import SwiftUI
import Contacts

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task.init {
                await fetchAllContacts()
            }
        }
    }
    
    func fetchAllContacts() async {
        // Run this in the background async
        
        // Get access to Contacts store
        let store = CNContactStore()
        
        // Specify which data keys to fetch
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactOrganizationNameKey,  CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        // Call method to fetch all contacts
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, result in
                // Do something with contact
                print("")
                let name = contact.givenName + " " + contact.familyName
                print(name)
                if contact.organizationName != "" {
                    print(contact.organizationName)
                } else {
                    print("No organization name found")
                }
                for number in contact.phoneNumbers {
                    
                    switch number.label {
                    case CNLabelPhoneNumberMain:
                        print("- Main: \(number.value.stringValue)")
                    case CNLabelPhoneNumberMobile:
                        print("- Mobile: \(number.value.stringValue)")
                    case CNLabelWork:
                        print("- Work: \(number.value.stringValue)")
                    case CNLabelHome:
                        print("- Home: \(number.value.stringValue)")
                    case CNLabelPhoneNumberPager:
                        print("- Pager: \(number.value.stringValue)")
                    case CNLabelSchool:
                        print("- School: \(number.value.stringValue)")
                    case CNLabelPhoneNumberAppleWatch:
                        print("- Apple Watch: \(number.value.stringValue)")
                    case CNLabelPhoneNumberHomeFax:
                        print("- Home Fax: \(number.value.stringValue)")
                    case CNLabelPhoneNumberWorkFax:
                        print("- Work Fax: \(number.value.stringValue)")
                    case CNLabelPhoneNumberOtherFax:
                        print("- Other Fax: \(number.value.stringValue)")
                    case CNLabelOther:
                        print("- Other: \(number.value.stringValue)")
                    default:
                        print("- Unclassified Number: \(number.value.stringValue)")
                    }
                    
                }
//                print(contact.emailAddresses)
                for email in contact.emailAddresses {
                    switch email.label {
                    case CNLabelEmailiCloud:
                        print("- Cloud eMail: \(email.value)")
                    case CNLabelWork:
                        print("- Work: \(email.value)")
                    case CNLabelHome:
                        print("- Home: \(email.value)")
                    case CNLabelSchool:
                        print("- School: \(email.value)")
                    case CNLabelOther:
                        print("- Other: \(email.value)")
                    default:
                        print("- \(email.label ?? "Unclassified eMail"): \(email.value)")

                    }
                }

            
            })
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView()
}
