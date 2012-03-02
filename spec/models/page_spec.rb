require File.dirname(__FILE__) + '/../spec_helper'

describe "Page rendering snippets" do
  dataset :pages, :snippets
  
  test_helper :render
  
  let(:page){ pages(:home) }
  
  it 'should render a snippet' do
    page.render_snippet(snippets(:first)).should == 'test'
  end

  it 'should render a snippet with a filter' do
    page.render_snippet(snippets(:markdown)).should match(%r{<p><strong>markdown</strong></p>})
  end

  it 'should render a snippet with a tag' do
    page.render_snippet(snippets(:radius)).should == 'Home'
  end
  
  describe "<r:snippet>" do
    it "should render the contents of the specified snippet" do
      page.should render('<r:snippet name="first" />').as('test')
    end

    it "should render an error when the snippet does not exist" do
      page.should render('<r:snippet name="non-existant" />').with_error("snippet 'non-existant' not found")
    end

    it "should render an error when not given a 'name' attribute" do
      page.should render('<r:snippet />').with_error("`snippet' tag must contain a `name' attribute.")
    end

    it "should filter the snippet with its assigned filter" do
      page.should render('<r:page><r:snippet name="markdown" /></r:page>').matching(%r{<p><strong>markdown</strong></p>})
    end

    it "should maintain the global page inside the snippet" do
      pages(:parent).should render('<r:snippet name="global_page_cascade" />').as("#{page.title} " * page.children.count)
    end

    it "should maintain the global page when the snippet renders recursively" do
      pages(:child).should render('<r:snippet name="recursive" />').as("Great GrandchildGrandchildChild")
    end

    it "should render the specified snippet when called as an empty double-tag" do
      page.should render('<r:snippet name="first"></r:snippet>').as('test')
    end

    it "should capture contents of a double tag, substituting for <r:yield/> in snippet" do
      page.should render('<r:snippet name="yielding">inner</r:snippet>').
        as('Before...inner...and after')
    end

    it "should do nothing with contents of double tag when snippet doesn't yield" do
      page.should render('<r:snippet name="first">content disappears!</r:snippet>').
        as('test')
    end

    it "should render nested yielding snippets" do
      page.should render('<r:snippet name="div_wrap"><r:snippet name="yielding">Hello, World!</r:snippet></r:snippet>').
      as('<div>Before...Hello, World!...and after</div>')
    end

    it "should render double-tag snippets called from within a snippet" do
      page.should render('<r:snippet name="nested_yields">the content</r:snippet>').
        as('<snippet name="div_wrap">above the content below</snippet>')
    end

    it "should render contents each time yield is called" do
      page.should render('<r:snippet name="yielding_often">French</r:snippet>').
        as('French is Frencher than French')
    end
  end

  it "should do nothing when called from page body" do
    page.should render('<r:yield/>').as("")
  end
end