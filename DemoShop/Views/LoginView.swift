import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer().frame(height: 40)

                Image(systemName: "storefront.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                    .accessibilityIdentifier("app-logo")

                Text("DemoShop")
                    .font(.largeTitle.bold())
                    .accessibilityIdentifier("app-title")

                VStack(spacing: 16) {
                    TextField("Username", text: $auth.username)
                        .textFieldStyle(.roundedBorder)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .accessibilityIdentifier("username-field")

                    SecureField("Password", text: $auth.password)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityIdentifier("password-field")

                    if !auth.errorMessage.isEmpty {
                        Text(auth.errorMessage)
                            .foregroundColor(.red)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .accessibilityIdentifier("error-message")
                    }

                    Button(action: auth.login) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .font(.headline)
                    }
                    .accessibilityIdentifier("login-button")
                }
                .padding(.horizontal, 32)

                Spacer()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Accepted usernames:")
                        .font(.caption.bold())
                    Text("standard_user\nlocked_out_user\nproblem_user")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("Password for all users:")
                        .font(.caption.bold())
                        .padding(.top, 4)
                    Text("secret_sauce")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 32)
                .accessibilityIdentifier("login-hint")

                Spacer().frame(height: 40)
            }
        }
    }
}
