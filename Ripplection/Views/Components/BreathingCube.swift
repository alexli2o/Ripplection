import SwiftUI

/// The glassy square used during Box Breathing. Its fill rises and falls
/// continuously against wall-clock time within the current phase (via
/// `TimelineView`), rather than stepping once per second like the countdown
/// text does — this is what makes the water look like it's actually flowing.
struct BreathingCubeView: View {
    let phase: BreathingPhase
    let phaseStartDate: Date
    let secondsRemaining: Int
    var size: CGFloat = 220

    var body: some View {
        TimelineView(.animation) { timeline in
            let progress = (timeline.date.timeIntervalSince(phaseStartDate) / phase.duration)
                .clamped(to: 0...1)

            ZStack {
                RoundedRectangle(cornerRadius: 36)
                    .fill(.white.opacity(0.12))

                RoundedRectangle(cornerRadius: 36)
                    .fill(
                        LinearGradient(colors: [.blue.opacity(0.8), .blue.opacity(0.4)], startPoint: .top, endPoint: .bottom)
                    )
                    .mask(alignment: .bottom) {
                        Rectangle()
                            .frame(height: size * CGFloat(fillFraction(for: progress)))
                    }

                Color.clear
                    .glassEffect(.regular, in: .rect(cornerRadius: 36))

                Text("\(secondsRemaining)")
                    .font(.system(size: 64, weight: .thin, design: .rounded))
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText(countsDown: true))
            }
            .frame(width: size, height: size)
        }
    }

    /// Inhale/hold-after-inhale fill upward; exhale/hold-after-exhale fill downward.
    private func fillFraction(for progress: Double) -> Double {
        switch phase {
        case .inhale: return progress
        case .holdAfterInhale: return 1
        case .exhale: return 1 - progress
        case .holdAfterExhale: return 0
        }
    }
}

#Preview {
    BreathingCubeView(phase: .inhale, phaseStartDate: .now, secondsRemaining: 2)
}
