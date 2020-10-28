import UIKit

class PokeListCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     label.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: 16),
                                     label.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -16)])
        return label
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                                     imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                                     imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16)])
        return imageView
    }()
    
    private var viewModel: PokeListCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel?.cancelRequest()
        previewImageView.image = nil
    }
    
    func setup(viewModel: PokeListCellViewModel) {
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true

        titleLabel.text = viewModel.name
        previewImageView.image = UIImage(named: viewModel.placeholderName)
        
        self.viewModel = viewModel
        self.viewModel?.onFailure = { [weak self] in self?.onError($0) }
        self.viewModel?.onSuccess = { [weak self] in self?.imageDownloaded($0) }
        self.viewModel?.loadImage()
    }
    
    private func imageDownloaded(_ data: Data) {
        previewImageView.image = UIImage(data: data)
    }
    
    private func onError(_ error: Error) {
        previewImageView.image = viewModel.flatMap({ UIImage(named: $0.placeholderName) })
    }
}
