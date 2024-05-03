import SwiftUI

struct ChallengeView: View {
    @StateObject private var viewModel = ChallengeViewModel()
    @State var creatingChallenge = false
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
        }()

    var body: some View {
        VStack {
            HStack{
                Text("Challenge")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .bold()
                   
                Spacer()
            } .padding(.horizontal)
            ScrollView{
                
                //            List(viewModel.challenges) { challenge in
                //            (viewModel.challenges).forEach { challenge in
                //            for challenge in viewModel.challenges {
                ForEach(viewModel.challenges) { challenge in
                    if let challengeId = challenge.id {
                        let remaining = Double(challenge.goalValue) - challenge.currentProgress
                        blockContent(challenge: challenge, remaining: remaining)
                            .swipeActions {
                                Button {
                                    viewModel.delete(id: challengeId)
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                            }
                    }
                }
                .padding(.horizontal)
//                Spacer()
            }
            Button {
                creatingChallenge = true
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(UIColor(hex: "#164EAD")))
                        .frame(width: 200, height: 50)
                    Text("Create Challenge")
                        .foregroundColor(.white)
                }
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $creatingChallenge) {
            createChallenge()
                .background(Color(UIColor(hex: "#292929")))
        }
    }
    
    func unit(for type: ChallengeType) -> String {
        switch type {
        case .distance:
            return "km"
        case .time:
            return "Hr"
        case .calorie:
            return "cal"
        }
    }
}

private struct blockContent: View {
    var challenge: Challenge
    var remaining: Double
    
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
        }()
    
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(Color(UIColor(hex: "#202020")))
            HStack{
                VStack(alignment: .leading){
                    Text("Challenge:")
                        .font(.system(size: 20))
                    Text(typeToString(for: challenge.type))
                        .font(.system(size: 30))
                        .bold()
                    Text("Due Date: \(Self.dateFormatter.string(from: challenge.dueDate))")
                        .font(.system(size: 15))
                        .foregroundColor(Color(UIColor(hex: "#8399BD")))
                }
                .frame(width: 200)
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(UIColor(hex: "#48556A")))
                    VStack(alignment: .center){
                        if (remaining>0 || challenge.dueDate > Date()){
                            Text(String(format: "%.2f", remaining))
                                .font(.system(size: 20))
                                .bold()
                                .overlay(
                                    Rectangle()
                                        .frame(width: .infinity, height: 1),
                                    alignment: .bottom
                                )
                            Text(String(Int(challenge.goalValue)))
                                .font(.system(size: 15))
                                .foregroundColor(Color(UIColor(hex: "#8399BD")))
                        } else {
                            Text("Complete")
                        }
                    }
                    .padding()
                }
                .frame(width: 100)
                .padding()
            }
            .foregroundColor(.white)
        }
        .frame(width: .infinity, height: 150)
    }
    
    func typeToString(for type: ChallengeType) -> String {
        switch type {
        case .distance:
            return "Distance"
        case .time:
            return "Time"
        case .calorie:
            return "Calory"
        }
    }
}

private struct createChallenge: View {
    @StateObject private var viewModel = ChallengeViewModel()
    @State private var selectedType: ChallengeType = .distance
    @State private var goalValue: String = ""
    @State private var dueDate = Date()
    @State private var isShowingDatePicker = false
    
    var body: some View {
        VStack{
            Text("Create Challenge")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .bold()
            Picker("Select Challenge Type", selection: $selectedType) {
                Text("Distance(km)").tag(ChallengeType.distance)
                Text("Time(Hr)").tag(ChallengeType.time)
                Text("Calories(cal)").tag(ChallengeType.calorie)
            }.pickerStyle(SegmentedPickerStyle())
            
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(UIColor(hex: "#6881AB")))
                    .frame(width: .infinity, height: 50)
                
                if (goalValue.isEmpty){
                    Text("Goal Value")
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 16)
                }
                TextField("Goal Value", text: $goalValue)
                    .keyboardType(.numberPad) // Dismiss number keyboard when tapped outside
                    .padding()
                    .foregroundColor(.white)
                
            }
            
            VStack(alignment: .leading){
                Text("Select Due Date")
                    .foregroundColor(.white)
                    .bold()
                
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                    .background(Color(UIColor(hex: "#48556A")))
                    .accentColor(.white)
            }
            
            Button{
                guard let goal = Int(goalValue) else {
                    print("Invalid goal value")
                    return
                }
                viewModel.addChallenge(type: selectedType, goalValue: goal, dueDate: dueDate)
                goalValue = "" // Reset goalValue after adding challenge
                isShowingDatePicker = false // Close date picker after adding challenge
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(Color(UIColor(hex: "#164EAD")))
                        .frame(width: 200, height: 50)
                    Text("Create")
                        .foregroundColor(.white)
                }
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
