class ShowPdf < Prawn::Document
  def initialize(article)
    super(top_margin: 30)
    @article = article
    show_title
    show_caption
    show_photo
    show_matter
  end

  def show_title
    text "#{@article.title}", style: :bold
  end

  def show_caption
    move_down(2)
    text "#{@article.caption}",size: 10, style: :italic
  end

  def show_photo
    move_down 20
    id_sample = @article.photo.path
    image id_sample, height: 200, width: 300
  end

  def show_matter
    move_down(25)
    text "#{@article.matter}",size: 10
  end
end