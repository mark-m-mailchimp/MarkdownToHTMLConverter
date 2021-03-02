class MarkdownToHTML
  RULES_MAP = [
    { :regex => /\[([\w|\s]+)\]\((\S+)\)/, :sub => :a_link },
    { :regex => /(#+) (.*)/, :sub => :header },
    { :regex => /(^[A-Za-z].*(?:\n[A-Za-z].*)*)/, :sub => :paragraph }
  ].freeze

  def convert_to_html(markdown)
    RULES_MAP.each do |rule|
      markdown.gsub!(rule[:regex]) do |match|
        self.send(rule[:sub], *Regexp.last_match[1..-1])
      end
    end

    markdown
  end

  def header(hashes, content)
    level = hashes.length

    "<h#{level}>#{content}</h#{level}>"
  end

  def a_link(content, href)
    "<a href='#{href}'>#{content}</a>"
  end

  def paragraph(content)
    #Don't wrap in <p> if already wrapped in html
    if content.match(/^<\/?(ul|ol|li|h|p|bl)/i)
      return content;
    end

    "<p>#{content}</p>"
  end
end

