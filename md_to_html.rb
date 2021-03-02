require_relative 'lib/markdown_to_html'

markdown = File.open(ARGV[0]).read
markdown_to_html =  MarkdownToHTML.new
html = markdown_to_html.convert_to_html(markdown)

puts html