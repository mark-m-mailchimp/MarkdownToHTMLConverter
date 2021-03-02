require './lib/markdown_to_html'

describe MarkdownToHTML do
  subject {
    described_class.new.convert_to_html(markdown)
  }

  context "paragraph" do
    let(:markdown) {
      "This is a paragraph"
    }

    it "converts correctly" do
      expect(subject).to eq("<p>This is a paragraph</p>")
    end

    context "newlines" do
      let(:markdown) {
        <<~HEREDOC
        Hello there

        How are you?
        What's going on?
        HEREDOC
      }

      it "converts succeeding double newling paragraph correctly" do
        expect(subject).to eq("<p>Hello there</p>\n\n<p>How are you?\nWhat's going on?</p>\n")
      end
    end
  end

  context "header" do
    let(:markdown) {
      <<~HEREDOC
      # Header 1
      ## Header 2
      ### Header 3
      #### Header 4
      ##### Header 5
      ###### Header 6
      HEREDOC
    }

    it "converts correctly" do
      expect(subject).to eq(
        "<h1>Header 1</h1>\n<h2>Header 2</h2>\n<h3>Header 3</h3>\n" \
        "<h4>Header 4</h4>\n<h5>Header 5</h5>\n<h6>Header 6</h6>\n"
      )
    end
  end

  context "a link" do
    let(:markdown) {
      "[Mailchimp](https://www.mailchimp.com)"
    }

    it "converts correctly" do
      expect(subject).to eq("<a href='https://www.mailchimp.com'>Mailchimp</a>")
    end

    context "inline in paragraph" do
      let(:markdown) {
        "This is sample markdown for the [Mailchimp](https://www.mailchimp.com) homework assignment."
      }

      it "converts correctly" do
        expect(subject).to eq(
          "<p>This is sample markdown for the <a href='https://www.mailchimp.com'>Mailchimp</a> homework assignment.</p>"
        )
      end
    end

    context "inline in header" do
      let(:markdown) {
        "## This is sample markdown for the [Mailchimp](https://www.mailchimp.com) homework assignment."
      }

      it "converts correctly" do
        expect(subject).to eq(
          "<h2>This is sample markdown for the <a href='https://www.mailchimp.com'>Mailchimp</a> homework assignment.</h2>"
        )
      end
    end
  end

  context "mailchimp sample markdown" do
    let(:markdown) {
      <<~HEREDOC
      # Header one

      Hello there

      How are you?
      What's going on?

      ## Another Header

      This is a paragraph [with an inline link](http://google.com). Neat, eh?

      ## This is a header [with a link](http://yahoo.com)
      HEREDOC
    }

    it "converts correctly" do
      expect(subject).to eq(
        "<h1>Header one</h1>\n\n<p>Hello there</p>\n\n<p>How are you?\nWhat's going on?</p>\n\n"\
        "<h2>Another Header</h2>\n\n<p>This is a paragraph <a href='http://google.com'>with an inline link</a>. Neat, eh?</p>\n\n"\
        "<h2>This is a header <a href='http://yahoo.com'>with a link</a></h2>\n"\
      )
    end
  end
end
