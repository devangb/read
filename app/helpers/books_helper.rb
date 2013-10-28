module BooksHelper
	def gravatar_for_book(book, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(book.title.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: book.title, class: "gravatar")
  end
end
