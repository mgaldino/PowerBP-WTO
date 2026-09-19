// Read-only PDF rasterization with macOS Quartz. No PDF or source mutation.
// Usage: swift -module-cache-path <writable-cache> render_quartz_page.swift INPUT.pdf PAGE OUTPUT.png DPI
import Foundation
import CoreGraphics
import ImageIO

let args = CommandLine.arguments
guard args.count == 5, let pageNumber = Int(args[2]),
      let dpi = Double(args[4]), pageNumber > 0, dpi > 0 else {
    fatalError("Expected INPUT.pdf PAGE OUTPUT.png DPI")
}
guard let pdf = CGPDFDocument(URL(fileURLWithPath: args[1]) as CFURL),
      let page = pdf.page(at: pageNumber) else {
    fatalError("Cannot read the requested PDF page")
}
let box = page.getBoxRect(.mediaBox)
let scale = dpi / 72.0
let width = Int(ceil(box.width * scale))
let height = Int(ceil(box.height * scale))
guard let context = CGContext(
    data: nil, width: width, height: height,
    bitsPerComponent: 8, bytesPerRow: width * 4,
    space: CGColorSpaceCreateDeviceRGB(),
    bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
) else { fatalError("Cannot create the raster context") }
context.setFillColor(CGColor(gray: 1, alpha: 1))
context.fill(CGRect(x: 0, y: 0, width: width, height: height))
context.scaleBy(x: scale, y: scale)
context.drawPDFPage(page)
guard let image = context.makeImage(),
      let destination = CGImageDestinationCreateWithURL(
        URL(fileURLWithPath: args[3]) as CFURL,
        "public.png" as CFString, 1, nil
      ) else { fatalError("Cannot create the PNG output") }
CGImageDestinationAddImage(destination, image, nil)
guard CGImageDestinationFinalize(destination) else {
    fatalError("Cannot write the PNG output")
}
print("Quartz rendered PDF page \(pageNumber) at \(dpi) dpi (\(width)x\(height))")
