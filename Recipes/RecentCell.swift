import UIKit

final class RecentCell: UITableViewCell {
    static let identifier = "RecentCell"
    private let pictureView = PictureView()
    private let footerView = TrendingFooterView()
    private let timeLabel = DurationLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPictureView()
        setupFooterView()
        setupTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPictureView() {
        contentView.addSubview(pictureView)
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    private func setupFooterView() {
        contentView.addSubview(footerView)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: pictureView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: pictureView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor)
        ])
    }
    
    private func setupTimeLabel() {
        pictureView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.trailingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: -8),
            timeLabel.bottomAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: -8)
        ])
    }
}
//@available(iOS 17.0, *)
//#Preview {
//    ViewController()
//}
