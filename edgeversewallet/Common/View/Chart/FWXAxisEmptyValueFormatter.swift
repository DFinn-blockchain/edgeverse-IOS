import Charts

/// `FWXAxisEmptyValueFormatter` returns empty string and thus own place
/// under chart thas is used by `FWXAxisChartLegendView`
final class FWXAxisEmptyValueFormatter: AxisValueFormatter {
    func stringForValue(_: Double, axis _: AxisBase?) -> String {
        ""
    }
}
