import SwiftUI

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.white.opacity(0.6)) // Placeholder rengi
                    .padding(.leading, 12) // Sol kenara biraz boşluk ekliyoruz
            }
            
            TextField("", text: $text)
                .padding()
                .background(Color.white.opacity(0.1)) // Arka plan rengini açık gri yapıyoruz
                .cornerRadius(15)
                .foregroundColor(.white) // Yazıyı beyaz yapıyoruz
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.6), lineWidth: 1)) // Kenar çerçevesi daha açık gri
        }
    }
}
