import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationView {
            VStack{
                Text("ShareMyWay!")
                    .font(.system(size:46))
                    .bold()
                    .padding(50)
                
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(30)
                    
                
                TextField("Username", text: $username)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                SecureField("Password", text: $password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(15)
                
                Button("Log in", action: {
                    print("Log in")
                })
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15)
                
                Text("Don't have an account?")
                    .padding()
                
                Button("Register!", action: {
                    print("Register!")
                })
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 50)
            }
            
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

