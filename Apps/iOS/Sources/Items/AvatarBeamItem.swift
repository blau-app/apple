// AvatarBeamItem.swift
// Copyright (c) 2024 Superdapp, Inc

import SwiftUI

class AvatarBeam {
    private let SIZE: CGFloat = 36

    struct AvatarData {
        let wrapperColor: Color
        let faceColor: Color
        let backgroundColor: Color
        let wrapperTranslateX: CGFloat
        let wrapperTranslateY: CGFloat
        let wrapperRotate: Double
        let wrapperScale: CGFloat
        let isMouthOpen: Bool
        let isCircle: Bool
        let eyeSpread: CGFloat
        let mouthSpread: CGFloat
        let faceRotate: Double
        let faceTranslateX: CGFloat
        let faceTranslateY: CGFloat
    }

    private func generateData(name: String, colors: [Color]?) -> AvatarData {
        let seed = name.hash
        let range = colors?.count ?? 0
        let wrapperColor = getRandomColor(seed, colors: colors, range: range)
        let preTranslateX = getUnit(seed, modulus: 10, offset: 1)
        let wrapperTranslateX = preTranslateX < 5 ? preTranslateX + SIZE / 9 : preTranslateX
        let preTranslateY = getUnit(seed, modulus: 10, offset: 2)
        let wrapperTranslateY = preTranslateY < 5 ? preTranslateY + SIZE / 9 : preTranslateY

        return AvatarData(
            wrapperColor: wrapperColor,
            faceColor: getContrast(wrapperColor),
            backgroundColor: getRandomColor(seed + 13, colors: colors, range: range),
            wrapperTranslateX: wrapperTranslateX,
            wrapperTranslateY: wrapperTranslateY,
            wrapperRotate: Double(getUnit(seed, modulus: 360)),
            wrapperScale: 1 + CGFloat(getUnit(seed, modulus: Int(SIZE / 12))) / 10,
            isMouthOpen: getBoolean(seed, modulus: 2),
            isCircle: getBoolean(seed, modulus: 1),
            eyeSpread: CGFloat(getUnit(seed, modulus: 5)),
            mouthSpread: CGFloat(getUnit(seed, modulus: 3)),
            faceRotate: Double(getUnit(seed, modulus: 10, offset: 3)),
            faceTranslateX: wrapperTranslateX > SIZE / 6 ? wrapperTranslateX / 2 : CGFloat(getUnit(seed, modulus: 8, offset: 1)),
            faceTranslateY: wrapperTranslateY > SIZE / 6 ? wrapperTranslateY / 2 : CGFloat(getUnit(seed, modulus: 7, offset: 2))
        )
    }

    func createAvatarView(name: String, colors: [Color]? = [.cyan, .blue, .indigo, .purple, .pink], size: CGFloat, square: Bool = false) -> some View {
        let data = generateData(name: name, colors: colors)
        return AvatarView(data: data, size: size, square: square)
    }

    private func getRandomColor(_ seed: Int, colors: [Color]?, range _: Int) -> Color {
        if let colors = colors, !colors.isEmpty {
            return colors[abs(seed) % colors.count]
        } else {
            let r = CGFloat(abs((seed * 123) % 255)) / 255.0
            let g = CGFloat(abs((seed * 456) % 255)) / 255.0
            let b = CGFloat(abs((seed * 789) % 255)) / 255.0
            return Color(red: r, green: g, blue: b)
        }
    }

    private func getContrast(_ color: Color) -> Color {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 0

        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &opacity)

        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        return luminance > 0.5 ? .black : .white
    }

    private func getUnit(_ seed: Int, modulus: Int, offset: Int = 0) -> CGFloat {
        CGFloat(abs((seed + offset) % modulus))
    }

    private func getBoolean(_ seed: Int, modulus: Int) -> Bool {
        abs(seed) % modulus == 0
    }
}

struct AvatarView: View {
    let data: AvatarBeam.AvatarData
    let size: CGFloat
    let square: Bool

    private let ORIGINAL_SIZE: CGFloat = 36

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(data.backgroundColor)

                Rectangle()
                    .fill(data.wrapperColor)
                    .cornerRadius(data.isCircle ? size / 2 : size / 6)
                    .offset(x: data.wrapperTranslateX / ORIGINAL_SIZE * size,
                            y: data.wrapperTranslateY / ORIGINAL_SIZE * size)
                    .rotationEffect(.degrees(data.wrapperRotate), anchor: .center)
                    .scaleEffect(data.wrapperScale)

                FaceView(data: data)
                    .offset(x: data.faceTranslateX / ORIGINAL_SIZE * size,
                            y: data.faceTranslateY / ORIGINAL_SIZE * size)
                    .rotationEffect(.degrees(data.faceRotate), anchor: .center)
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
        }
        .frame(width: size, height: size)
    }
}

struct FaceView: View {
    let data: AvatarBeam.AvatarData

    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let scaleFactor = size / 36 // 36 is the original size

            Group {
                // Mouth
                if data.isMouthOpen {
                    Path { path in
                        path.move(to: CGPoint(x: 13 * scaleFactor, y: (19 + data.mouthSpread) * scaleFactor))
                        path.addCurve(
                            to: CGPoint(x: 24 * scaleFactor, y: (19 + data.mouthSpread) * scaleFactor),
                            control1: CGPoint(x: 17 * scaleFactor, y: (21 + data.mouthSpread) * scaleFactor),
                            control2: CGPoint(x: 19 * scaleFactor, y: (21 + data.mouthSpread) * scaleFactor)
                        )
                    }
                    .stroke(style: StrokeStyle(lineWidth: scaleFactor, lineCap: .round))
                    .stroke(data.faceColor, lineWidth: scaleFactor)
                } else {
                    Path { path in
                        path.move(to: CGPoint(x: 13 * scaleFactor, y: (19 + data.mouthSpread) * scaleFactor))
                        path.addArc(
                            center: CGPoint(x: 18 * scaleFactor, y: (19 + data.mouthSpread) * scaleFactor),
                            radius: -5 * scaleFactor,
                            startAngle: .degrees(180),
                            endAngle: .degrees(0),
                            clockwise: false
                        )
                    }
                    .fill(data.faceColor)
                }

                // Left Eye
                Circle()
                    .fill(data.faceColor)
                    .frame(width: 4.5 * scaleFactor, height: 6 * scaleFactor)
                    .cornerRadius(1 * scaleFactor)
                    .offset(x: (10 - data.eyeSpread) * scaleFactor, y: 8 * scaleFactor)

                // Right Eye
                Circle()
                    .fill(data.faceColor)
                    .frame(width: 4.5 * scaleFactor, height: 6 * scaleFactor)
                    .cornerRadius(1 * scaleFactor)
                    .offset(x: (22 + data.eyeSpread) * scaleFactor, y: 8 * scaleFactor)
            }
        }
    }
}

#Preview {
    VStack {
        AvatarBeam().createAvatarView(name: "John Doe",
                                      colors: [.cyan, .blue, .indigo, .purple, .pink],
                                      size: 100)
        AvatarBeam().createAvatarView(name: "Jane Doe",
                                      colors: [.cyan, .blue, .indigo, .purple, .pink],
                                      size: 100)
        AvatarBeam().createAvatarView(name: "Alice Smith",
                                      colors: [.cyan, .blue, .indigo, .purple, .pink],
                                      size: 100)
    }
}
