import SwiftUI

struct RegisterView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var email = ""
    @State private var fullname = ""
    
    var body: some View {
        NavigationView {
            VStack{
                Text("ShareMyWay!")
                    .font(.system(size:46))
                    .bold()
                    .padding(10)
                
                Text("Register")
                    .font(.largeTitle)
                    .bold()
                    .padding(30)
                    
                
                TextField("Username*", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                SecureField("Password*", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                SecureField("Password again*", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                TextField("Email*", text: $email)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                TextField("Full name", text: $fullname)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                Button("Register", action: {
                    print("Register")
                })
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15)
                
                Text("Already have an account?")
                    .padding()
                
                Button("Log in!", action: {
                    print("Log in!")
                })
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 50)
            }
            
        }
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

