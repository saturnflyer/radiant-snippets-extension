require File.dirname(__FILE__) + "/../../spec_helper"

describe Radiant::AdminUI do
  let(:admin) do
    @admin = Radiant::AdminUI.new
    @admin.snippet = @admin.load_default_snippet_regions
    @admin
  end
  
  subject{ admin }
  its(:snippet){ should_not be_nil }
  its(:snippets){ should_not be_nil }
  
  context 'edit Region' do
    subject{ admin.snippet.edit }
    its(:main){ should == %w{ edit_header edit_form } }
    its(:form){ should == %w{ edit_title edit_content edit_filter } }
    its(:form_bottom){ should == %w{ edit_buttons edit_timestamp } }
  end
  
  context 'new Region' do
    subject{ admin.snippet.new }
    its(:main){ should == %w{ edit_header edit_form } }
    its(:form){ should == %w{ edit_title edit_content edit_filter } }
    its(:form_bottom){ should == %w{ edit_buttons edit_timestamp } }
  end
  
  subject{ admin.snippet.index }
  its(:top){ should == [] }
  its(:thead){ should == %w{ title_header actions_header } }
  its(:tbody){ should == %w{ title_cell actions_cell } }
  its(:bottom){ should == %w{ new_button } }
end